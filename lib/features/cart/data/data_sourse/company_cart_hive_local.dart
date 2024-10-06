import 'package:gogreen/features/home/main/data/model/company_model.dart';
import 'package:hive/hive.dart';

class CompanyCartHiveLocal {
  //singleton
  static final CompanyCartHiveLocal _cartHive = CompanyCartHiveLocal._internal();

  factory CompanyCartHiveLocal() => _cartHive;

  CompanyCartHiveLocal._internal();

  Future<void> init() async {
    await Hive.openBox<CompanyModel>('company_cart');
  }

  //get company data
  Future<CompanyModel?> getCompany() async {
    final box = await Hive.openBox<CompanyModel>('company_cart');
    return box.get('company');
  }

  //add company data
  Future<void> setCompany(CompanyModel company) async {
    final box = await Hive.openBox<CompanyModel>('company_cart');
    await box.put('company', company);
  }

  //remove company data
  Future<void> removeCompany() async {
    final box = await Hive.openBox<CompanyModel>('company_cart');
    await box.delete('company');
  }

  //clear all data
  Future<void> clear() async {
    final box = await Hive.openBox<CompanyModel>('company_cart');
    await box.clear();
  }
}

class CompanyModelAdapter extends TypeAdapter<CompanyModel> {
  @override
  final int typeId = 3;

  @override
  CompanyModel read(BinaryReader reader) {
    var a = <String, dynamic>{};
    reader.readMap().forEach((key, value) {
      a[key.toString()] = value;
    });
    return CompanyModel.fromJson(a);
  }

  @override
  void write(BinaryWriter writer, CompanyModel obj) {
    writer.writeMap(obj.toJson());
  }
}

