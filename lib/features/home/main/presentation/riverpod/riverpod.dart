import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gogreen/core/states/data.state.dart';
import 'package:gogreen/core/states/paginatedData.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/features/home/main/data/model/company_model.dart';
import 'package:gogreen/features/home/main/data/reposaitories/repos.dart';
import 'package:gogreen/locator.dart';

abstract class HomeCompaniesFilter {
  static String all = "all";
  static String famous = "most_famous";
  static String rated = "most_rated";
}

class CompaniesRiverpodController
    extends StateNotifier<PaginatedData<CompanyModel>> {
  var filter = HomeCompaniesFilter.all;

  CompaniesRiverpodController()
      : super(PaginatedData.initial(PaginationModel<CompanyModel>.empty())) {
    getData();
  }

  final _controller = locator<CompanyRepository>();

  //get date from api when the page is loaded
  Future<void> getData({
    bool moreData = false,
  }) async {
    if (state.viewState == ViewState.loadingMore ||
        state.viewState == ViewState.loading) return;

    if (moreData) {
      state = state.loadingMore();
    } else {
      state = state.loading();
    }

    int page = state.data.currentPage + 1;
    final data = await _controller.getCompanies(
      page: page,
      filter: filter,
    );

    if (data is DataSuccess) {
      state = state.success(data.data!);
      if (!moreData && data.data!.data.isEmpty) {
        state = state.empty();
      }
    } else {
      state = state.failure(
        data.message,
        error: data.error,
      );
    }
  }

  changeFilter(String filter) async {
    this.filter = filter;

    state = state.copyWith(
      data: state.data.copyWith(
        data: [],
        currentPage: 0,
        lastPage: 0,
      ),
    );
    await getData();
  }
}

final companiesProvider = StateNotifierProvider<CompaniesRiverpodController,
    PaginatedData<CompanyModel>>(
  (ref) => CompaniesRiverpodController(),
);

final searchCompaniesProvider = StateNotifierProvider.autoDispose<
    SearchCompaniesRiverpodController, PaginatedData<CompanyModel>>(
      (ref) => SearchCompaniesRiverpodController(),
);
class SearchCompaniesRiverpodController
    extends StateNotifier<PaginatedData<CompanyModel>> {
  SearchCompaniesRiverpodController()
      : super(PaginatedData<CompanyModel>.initial(
      PaginationModel<CompanyModel>.empty())) {
    getData();
  }

  var searchTextController = TextEditingController();
  String search = '';


  final _controller = locator<CompanyRepository>();

  //get date from api when the page is loaded
  Future<void> getData({
    bool moreData = false,
  }) async {
    if (state.viewState == ViewState.loadingMore ||
        state.viewState == ViewState.loading) return;

    if (moreData) {
      state = state.loadingMore();
    } else {
      state = state.loading();
    }

    int page = state.data.currentPage + 1;
    final data = await _controller.getCompanies(
      page: page,
      search: search,
    );

    if (data is DataSuccess) {
      state = state.success(data.data!);
      if (!moreData && data.data!.data.isEmpty) {
        state = state.empty(message: 'No Search Data');
      }
    } else {
      state = state.failure(
        data.message,
        error: data.error,
      );
    }
  }

  Future<void> onSearch(String text) async {
    search = text.trim();
    state = state.copyWith(
      data: state.data.copyWith(
        data: [],
        currentPage: 0,
        lastPage: 0,
      ),
    );
    await getData();
  }

  void clearSearch() {
    state = state.copyWith(
      data: state.data.copyWith(
        data: [],
        currentPage: 0,
        lastPage: 0,
      ),
    );
    search = '';
    searchTextController.clear();
    getData();
  }
}