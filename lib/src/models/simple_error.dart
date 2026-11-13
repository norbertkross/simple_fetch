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

  SimpleError.fromDio(DioException exception)
    : this(
        requestOptions: exception.requestOptions,
        error: exception.error,
        message: exception.message,
        response: exception.response,
        stackTrace: exception.stackTrace,
        type: exception.type,
      );

  @override
  String toString() {
    final code = response?.statusCode;
    final details = <String>[
      if (code != null) '$code',
      if (message != null && message!.isNotEmpty) message!,
    ].join(' ');
    if (details.isEmpty) return 'SimpleError';
    return 'SimpleError: $details';
  }
}
