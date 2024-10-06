// riverpod state
import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/states/view.state.dart';

class GenerateDataState<T> {
  ViewState viewState;
  T data;
  String message;
  ErrorModel errorModel;

  GenerateDataState({
    required this.viewState,
    this.message = '',
    required this.errorModel,
    required this.data,
  });

  factory GenerateDataState.initial(T data) {
    return GenerateDataState<T>(
      viewState: ViewState.initial,
      errorModel: ErrorModel(),
      data: data,
    );
  }

  GenerateDataState<T> loading() {
    return GenerateDataState<T>(
      viewState: ViewState.loading,
      errorModel: errorModel,
      data: data,
    );
  }

  GenerateDataState<T> loadingMore() {
    return GenerateDataState<T>(
      viewState: ViewState.loadingMore,
      errorModel: errorModel,
      data: data,
    );
  }

  GenerateDataState<T> success(T data) {
    return GenerateDataState<T>(
      viewState: ViewState.success,
      errorModel: errorModel,
      data: data,
    );
  }

  GenerateDataState<T> failure(String message, {ErrorModel? error}) {
    return GenerateDataState<T>(
      viewState: ViewState.failure,
      message: message,
      errorModel: error ?? errorModel,
      data: data,
    );
  }

  GenerateDataState<T> copyWith(
      {ViewState? viewState, ErrorModel? errorModel, T? data}) {
    return GenerateDataState<T>(
      viewState: viewState ?? this.viewState,
      errorModel: errorModel ?? this.errorModel,
      data: data ?? this.data,
    );
  }
}
