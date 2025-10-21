import 'package:gogreen/features/cart/data/model/cart_model.dart';
import 'package:gogreen/features/cart/data/model/cart_product_model.dart';
import 'package:gogreen/features/home/main/data/model/company_model.dart';
import 'package:hive/hive.dart';
import 'package:gogreen/features/cart/data/data_sourse/company_cart_hive_local.dart';

class CartHiveLocal {
  static final CartHiveLocal _cartHive = CartHiveLocal._internal();

  factory CartHiveLocal() => _cartHive;

  CartHiveLocal._internal();

  Future<void> init() async {
    Hive.registerAdapter(CartModelAdapter());
    Hive.registerAdapter(CartProductModelAdapter());
    await Hive.openBox<CartModel>('cart');
  }

  Future<CartModel> getCart() async {
    final box = await Hive.openBox<CartModel>('cart');
    return box.get('cart') ?? CartModel.empty();
  }

  Future<void> addToCart(Map<String, dynamic> data) async {
    final box = await Hive.openBox<CartModel>('cart');
    final companyBox = await CompanyCartHiveLocal().getCompany();
    final company = companyBox ?? CompanyModel.empty();
    var cart = box.get('cart');

    if (cart == null) {
      cart = CartModel(
        companyId: company.id,
        products: [CartProductModel.fromJson(data)],
      );
      await box.put('cart', cart);
    } else {
      final products = List<CartProductModel>.from(cart.products);
      final index = products.indexWhere(
        (element) => element.productId == data['product_id'],
      );

      if (index != -1) {
        products[index] = products[index].copyWith(
          quantity: products[index].quantity + data['quantity'] as int,
        );
      } else {
        products.add(CartProductModel.fromJson(data));
      }

      cart = cart.copyWith(products: products);
      await box.put('cart', cart);
    }
  }

  Future<void> updateCartQuantity(int productId, int quantity) async {
    final box = await Hive.openBox<CartModel>('cart');
    final cart = box.get('cart');

    if (cart != null) {
      final products = List<CartProductModel>.from(cart.products);
      final index =
          products.indexWhere((element) => element.productId == productId);

      if (index != -1) {
        if (quantity > 0) {
          products[index] = products[index].copyWith(quantity: quantity);
        } else {
          products.removeAt(index);
        }

        await box.put('cart', cart.copyWith(products: products));
      }
    }
  }

  Future<void> removeFromCart(int id) async {
    final box = await Hive.openBox<CartModel>('cart');
    final cart = box.get('cart');

    if (cart != null) {
      final products = List<CartProductModel>.from(cart.products);
      final product = products.firstWhere(
        (element) => element.productId == id,
        orElse: () => CartProductModel.empty(),
      );

      if (product.quantity > 1) {
        product.quantity -= 1;
      } else {
        products.remove(product);
      }

      await box.put('cart', cart.copyWith(products: products));
    }
  }

  Future<void> clearCart() async {
    final box = await Hive.openBox<CartModel>('cart');
    await box.clear();
  }
}

class CartModelAdapter extends TypeAdapter<CartModel> {
  @override
  final int typeId = 1;

  @override
  CartModel read(BinaryReader reader) {
    final map = reader.readMap().map(
          (key, value) => MapEntry(key.toString(), value),
        );
    return CartModel.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, CartModel obj) {
    writer.writeMap(obj.toJson());
  }
}

class CartProductModelAdapter extends TypeAdapter<CartProductModel> {
  @override
  final int typeId = 2;

  @override
  CartProductModel read(BinaryReader reader) {
    final map = reader.readMap().map(
          (key, value) => MapEntry(key.toString(), value),
        );
    return CartProductModel.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, CartProductModel obj) {
    writer.writeMap(obj.toJson());
  }
}
