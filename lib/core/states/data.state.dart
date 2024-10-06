import '../network/errors/error.model.wings.dart';

abstract class DataState<T> {
  final T? data;
  final ErrorModel? error;
  final String message;

  DataState({this.data, this.error, required this.message});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data) : super(data: data, message: '');
}

class DataError<T> extends DataState<T> {
  final String code;

  DataError({
    required super.message,
    required ErrorModel super.error,
    this.code = '',
  });
}
