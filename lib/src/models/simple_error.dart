import 'package:dio/dio.dart';

class SimpleError implements Exception {
  /// The [RequestOptions] used for the corresponding request.
  RequestOptions? requestOptions;

  Object? error;

  String? message;

  Response<dynamic>? response;

  StackTrace? stackTrace;

  DioExceptionType type;

  SimpleError({
    required this.requestOptions,
    this.response,
    this.type = DioExceptionType.unknown,
    this.error,
    this.stackTrace,
    this.message,
  });
}
