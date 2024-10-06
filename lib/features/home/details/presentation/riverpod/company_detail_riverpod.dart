import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gogreen/core/states/data.state.dart';
import 'package:gogreen/core/states/generateData.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/features/home/details/data/model/category_model.dart';
import 'package:gogreen/features/home/details/data/model/company_detail_model.dart';
import 'package:gogreen/features/home/details/data/model/product_detail_model.dart';
import 'package:gogreen/features/home/details/data/model/product_pagenation_model.dart';
import 'package:gogreen/features/home/details/data/reposaitories/repos.dart';
import 'package:gogreen/locator.dart';

final companyDetailProvider = StateNotifierProvider.autoDispose.family<
    CompanyDetailController, GenerateDataState<CompanyDetailModel>, int>(
  (ref, int id) {
    return CompanyDetailController(id);
  },
);

class CompanyDetailController
    extends StateNotifier<GenerateDataState<CompanyDetailModel>> {
  final int id;

  var sectionId = 0;

  List<CategoryModel> filteredCategories = [];

  CompanyDetailController(this.id)
      : super(GenerateDataState<CompanyDetailModel>.initial(
            CompanyDetailModel.empty())) {
    getData();
  }

  TextEditingController searchController = TextEditingController();
  bool keyboardAutoFocus = false;

  List<int> selectedCategories = [0];

  final _controller = locator<CompanyDetailRepository>();

  Future<void> getData({
    bool moreData = false,
    bool replaceData = false,
  }) async {
    if (state.viewState == ViewState.loadingMore ||
        state.viewState == ViewState.loading) return;
    var categories =
        selectedCategories.where((element) => element != 0).toList();
    if (state.viewState != ViewState.failure) {
      if (moreData) {
        state = state.loadingMore();
      } else {
        state = state.loading();
      }
    }

    int page = state.data.products.currentPage + 1;
    final data = await _controller.getCompanyDetail(
      page: page,
      id: id,
      sectionId: sectionId > 0 ? sectionId : null,
      categoryIds: categories.isNotEmpty ? categories : null,
      search: searchController.text,
    );

    if (data is DataSuccess) {
      var _oldData = state.data;
      if (_oldData.name!.isNotEmpty) {
        PaginatedProductsListModel _products;
        if (!replaceData) {
          _products = _oldData.products.copyWith(
            data: [..._oldData.products.data, ...data.data!.products.data],
            currentPage: data.data!.products.currentPage,
          );
        } else {
          _products = _oldData.products.copyWith(
            data: data.data!.products.data,
            currentPage: data.data!.products.currentPage,
          );
        }
        _oldData = _oldData.copyWith(products: _products);
      } else {
        _oldData = data.data!;
      }
      state = state.success(_oldData);
    } else {
      state = state.failure(
        data.message,
        error: data.error,
      );
    }
  }

  Future<void> search() async {
    state = state.copyWith(
      data: state.data.copyWith(
        products: state.data.products.copyWith(
          data: [],
          currentPage: 0,
        ),
      ),
    );
    await getData(replaceData: true, moreData: true);
  }

  // filter by section id
  Future<void> filterBySection(int id) async {
    // filter the categories based on the section id
    final categories = state.data.categories.where((element) {
      return element.sectionId == id;
    }).toList();

    selectedCategories = [0];
    filteredCategories = categories;
    sectionId = id;

    state = state.copyWith(
      data: state.data.copyWith(
        products: state.data.products.copyWith(
          data: [],
          currentPage: 0,
        ),
      ),
    );
    await getData(replaceData: true, moreData: true);
  }

  // filter by category id
  Future<void> filterByCategory(int id) async {
    List<int> _selectedCategories = [];
    log(id.toString());
    if (id != 0) {
      _selectedCategories = selectedCategories;
      if (_selectedCategories.contains(0)) {
        _selectedCategories.remove(0);
      }
      if (_selectedCategories.contains(id)) {
        _selectedCategories.remove(id);
      } else {
        _selectedCategories.add(id);
      }
    } else {
      _selectedCategories = [0];
    }
    selectedCategories = _selectedCategories;
    state = state.copyWith(
      data: state.data.copyWith(
        products: state.data.products.copyWith(
          data: [],
          currentPage: 0,
        ),
      ),
    );
    await getData(replaceData: true, moreData: true);
  }
}

/// Product Detail Riverpod
final productDetailProvider = StateNotifierProvider.autoDispose.family<
    ProductDetailController, GenerateDataState<ProductDetailModel>, int>(
  (ref, int id) {
    return ProductDetailController(id);
  },
);

class ProductDetailController
    extends StateNotifier<GenerateDataState<ProductDetailModel>> {
  final int id;

  ProductDetailController(this.id)
      : super(GenerateDataState<ProductDetailModel>.initial(
            ProductDetailModel.empty())) {
    getData();
  }

  final _controller = locator<CompanyDetailRepository>();

  Future<void> getData() async {
    state = state.loading();

    final data = await _controller.getProductDetail(id);
    if (data is DataSuccess) {
      state = state.success(data.data as ProductDetailModel);
    } else {
      state = state.failure(
        data.message,
        error: data.error,
      );
    }
  }
}
