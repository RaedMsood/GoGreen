import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/states/paginationData/pagination.model.dart';
import 'package:gogreen/core/states/view.state.dart';

import '../constants/app_images.dart';

export 'package:gogreen/core/states/paginationData/pagination.model.dart';

class PaginatedData<T> {
  ViewState viewState;
  PaginationModel<T> data;
  String message;
  ErrorModel errorModel;

  PaginatedData({
    required this.viewState,
    required this.data,
    this.message = '',
    required this.errorModel,
  });

  factory PaginatedData.initial(PaginationModel<T> data) {
    return PaginatedData<T>(
      viewState: ViewState.initial,
      data: data,
      errorModel: ErrorModel(),
    );
  }

  PaginatedData<T> loading() {
    return PaginatedData<T>(
      viewState: ViewState.loading,
      data: data,
      errorModel: errorModel,
    );
  }

  PaginatedData<T> loadingMore() {
    return PaginatedData<T>(
      viewState: ViewState.loadingMore,
      data: data,
      errorModel: errorModel,
    );
  }

  PaginatedData<T> success(PaginationModel<T> data) {
    return PaginatedData<T>(
      viewState: ViewState.success,
      // add data to the existing data
      data: this.data.copyWith(
        data: [...this.data.data, ...data.data],
        currentPage: data.currentPage,
        lastPage: data.lastPage,
      ),
      errorModel: errorModel,
    );
  }

  PaginatedData<T> failure(String message, {ErrorModel? error}) {
    return PaginatedData<T>(
      viewState: ViewState.failure,
      message: message,
      data: data,
      errorModel: error ?? ErrorModel(),
    );
  }

  PaginatedData<T> copyWith(
      {ViewState? viewState,
      PaginationModel<T>? data,
      ErrorModel? errorModel}) {
    return PaginatedData<T>(
      viewState: viewState ?? this.viewState,
      // add data to the existing data
      data: data ?? this.data,
      errorModel: errorModel ?? this.errorModel,
    );
  }

  PaginatedData<T> empty({
    String message = "data.noData",
    String desc = "data.noDataDesc",
    String icon = AppImages.noData,
  }) {
    return PaginatedData<T>(
      viewState: ViewState.failure,
      data: data,
      errorModel: ErrorModel(
        message: message,
        desc: desc,
        icon: icon,
      ),
    );
  }
}
