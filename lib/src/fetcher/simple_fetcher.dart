import 'package:dio/dio.dart';
import 'package:simple_fetch/simple_fetch.dart';
import 'package:simple_fetch/src/enums/enums.dart';
import 'package:simple_fetch/src/http_methods/delete_methods.dart';
import 'package:simple_fetch/src/http_methods/get_methods.dart';
import 'package:simple_fetch/src/http_methods/patch_methods.dart';
import 'package:simple_fetch/src/http_methods/post_methods.dart';
import 'package:simple_fetch/src/http_methods/put_methods.dart';

class SimpleFetch {
  final Dio dio = Dio();

  // HTTP GET
  /// Make an http GET request
  Future<T?> get<T>({
    String? url = '',
    required T Function(Map<String, dynamic>)? mapper,
    Function(dynamic transform)? transformer,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    List<int>? successCodes,
  }) async {
    successCodes = successCodes ?? [200, 201];

    try {
      final Response response = await dio.get(url!,
          cancelToken: cancelToken,
          data: data,
          onReceiveProgress: onReceiveProgress,
          options: options,
          queryParameters: queryParameters);

      return GetMethods.getObjectTranformer(
        response: response,
        mapper: mapper,
        transformer: transformer,
        successCodes: successCodes,
        responseTypeChecker: ResponseTypeChecker.object,
      );
    } on DioException catch (exception) {
      throw SimpleError(
          requestOptions: exception.requestOptions,
          error: exception.error,
          message: exception.message,
          response: exception.response,
          stackTrace: exception.stackTrace,
          type: exception.type);
    }
  }

  /// Make an http GET request when the response is a list
  Future<List<T?>> getList<T>({
    required T Function(Map<String, dynamic>)? mapper,
    String? url = '',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    Function(dynamic transform)? transformer,
    List<int>? successCodes,
  }) async {
    successCodes = successCodes ?? [200, 201];

    try {
      final Response response = await dio.get(url!,
          cancelToken: cancelToken,
          data: data,
          onReceiveProgress: onReceiveProgress,
          options: options,
          queryParameters: queryParameters);

      return GetMethods.getListObjectTranformer(
        response: response,
        mapper: mapper,
        transformer: transformer,
        successCodes: successCodes,
        responseTypeChecker: ResponseTypeChecker.list,
      );
    } on DioException catch (exception) {
      throw SimpleError(
          requestOptions: exception.requestOptions,
          error: exception.error,
          message: exception.message,
          response: exception.response,
          stackTrace: exception.stackTrace,
          type: exception.type);
    }
  }

  // HTTP POST
  // Make an http POST request
  Future<T?> post<T>({
    required T Function(Map<String, dynamic>)? mapper,
    String? url = '',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    Function(dynamic transform)? transformer,
    List<int>? successCodes,
  }) async {
    successCodes = successCodes ?? [200, 201];

    try {
      final Response response = await dio.post(url!,
          cancelToken: cancelToken,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          options: options,
          queryParameters: queryParameters);

      return PostMethods.postObjectTranformer(
        response: response,
        mapper: mapper,
        transformer: transformer,
        successCodes: successCodes,
        responseTypeChecker: ResponseTypeChecker.object,
      );
    } on DioException catch (exception) {
      throw SimpleError(
          requestOptions: exception.requestOptions,
          error: exception.error,
          message: exception.message,
          response: exception.response,
          stackTrace: exception.stackTrace,
          type: exception.type);
    }
  }

// Make an http POST request when the response is a list
  Future<List<T?>> postList<T>({
    required T Function(Map<String, dynamic>)? mapper,
    String? url = '',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    Function(dynamic transform)? transformer,
    List<int>? successCodes,
  }) async {
    successCodes = successCodes ?? [200, 201];

    try {
      final Response response = await dio.post(url!,
          cancelToken: cancelToken,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          options: options,
          queryParameters: queryParameters);

      return PostMethods.postListObjectTranformer(
        response: response,
        mapper: mapper,
        transformer: transformer,
        successCodes: successCodes,
        responseTypeChecker: ResponseTypeChecker.list,
      );
    } on DioException catch (exception) {
      throw SimpleError(
          requestOptions: exception.requestOptions,
          error: exception.error,
          message: exception.message,
          response: exception.response,
          stackTrace: exception.stackTrace,
          type: exception.type);
    }
  }

  // HTTP PUT
  // Make an http PUT request
  Future<T?> put<T>({
    required T Function(Map<String, dynamic>)? mapper,
    String? url = '',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    Function(dynamic transform)? transformer,
    List<int>? successCodes,
  }) async {
    successCodes = successCodes ?? [200, 201];

    try {
      final Response response = await dio.put(url!,
          cancelToken: cancelToken,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          options: options,
          queryParameters: queryParameters);

      return PutMethods.putObjectTranformer(
        response: response,
        mapper: mapper,
        transformer: transformer,
        successCodes: successCodes,
        responseTypeChecker: ResponseTypeChecker.object,
      );
    } on DioException catch (exception) {
      throw SimpleError(
          requestOptions: exception.requestOptions,
          error: exception.error,
          message: exception.message,
          response: exception.response,
          stackTrace: exception.stackTrace,
          type: exception.type);
    }
  }

// Make an http PUT request when the response is a list
  Future<List<T?>> putList<T>({
    required T Function(Map<String, dynamic>)? mapper,
    String? url = '',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    Function(dynamic transform)? transformer,
    List<int>? successCodes,
  }) async {
    successCodes = successCodes ?? [200, 201];

    try {
      final Response response = await dio.put(url!,
          cancelToken: cancelToken,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          options: options,
          queryParameters: queryParameters);

      return PutMethods.putListObjectTranformer(
        response: response,
        mapper: mapper,
        transformer: transformer,
        successCodes: successCodes,
        responseTypeChecker: ResponseTypeChecker.list,
      );
    } on DioException catch (exception) {
      throw SimpleError(
          requestOptions: exception.requestOptions,
          error: exception.error,
          message: exception.message,
          response: exception.response,
          stackTrace: exception.stackTrace,
          type: exception.type);
    }
  }

  // HTTP PATCH
  // Make an http PATCH request
  Future<T?> patch<T>({
    required T Function(Map<String, dynamic>)? mapper,
    String? url = '',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    Function(dynamic transform)? transformer,
    List<int>? successCodes,
  }) async {
    successCodes = successCodes ?? [200, 201];

    try {
      final Response response = await dio.patch(url!,
          cancelToken: cancelToken,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          options: options,
          queryParameters: queryParameters);

      return PatchMethods.patchObjectTranformer(
        response: response,
        mapper: mapper,
        transformer: transformer,
        successCodes: successCodes,
        responseTypeChecker: ResponseTypeChecker.object,
      );
    } on DioException catch (exception) {
      throw SimpleError(
          requestOptions: exception.requestOptions,
          error: exception.error,
          message: exception.message,
          response: exception.response,
          stackTrace: exception.stackTrace,
          type: exception.type);
    }
  }

// Make an http PATCH request when the response is a list
  Future<List<T?>> patchList<T>({
    required T Function(Map<String, dynamic>)? mapper,
    String? url = '',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    Function(dynamic transform)? transformer,
    List<int>? successCodes,
  }) async {
    successCodes = successCodes ?? [200, 201];

    try {
      final Response response = await dio.patch(url!,
          cancelToken: cancelToken,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          options: options,
          queryParameters: queryParameters);

      return PatchMethods.patchListObjectTranformer(
        response: response,
        mapper: mapper,
        transformer: transformer,
        successCodes: successCodes,
        responseTypeChecker: ResponseTypeChecker.list,
      );
    } on DioException catch (exception) {
      throw SimpleError(
          requestOptions: exception.requestOptions,
          error: exception.error,
          message: exception.message,
          response: exception.response,
          stackTrace: exception.stackTrace,
          type: exception.type);
    }
  }

  // HTTP DELETE
  // Make an http PATCH request
  Future<T?> delete<T>({
    required T Function(Map<String, dynamic>)? mapper,
    String? url = '',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    Function(dynamic transform)? transformer,
    List<int>? successCodes,
  }) async {
    successCodes = successCodes ?? [200, 201];

    try {
      final Response response = await dio.delete(url!,
          cancelToken: cancelToken,
          data: data,
          options: options,
          queryParameters: queryParameters);

      return DeleteMethods.deleteObjectTranformer(
        response: response,
        mapper: mapper,
        transformer: transformer,
        successCodes: successCodes,
        responseTypeChecker: ResponseTypeChecker.object,
      );
    } on DioException catch (exception) {
      throw SimpleError(
          requestOptions: exception.requestOptions,
          error: exception.error,
          message: exception.message,
          response: exception.response,
          stackTrace: exception.stackTrace,
          type: exception.type);
    }
  }

// Make an http PATCH request when the response is a list
  Future<List<T?>> deleteList<T>({
    required T Function(Map<String, dynamic>)? mapper,
    String? url = '',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    Function(dynamic transform)? transformer,
    List<int>? successCodes,
  }) async {
    successCodes = successCodes ?? [200, 201];

    try {
      final Response response = await dio.delete(url!,
          cancelToken: cancelToken,
          data: data,
          options: options,
          queryParameters: queryParameters);

      return DeleteMethods.deleteListObjectTranformer(
        response: response,
        mapper: mapper,
        transformer: transformer,
        successCodes: successCodes,
        responseTypeChecker: ResponseTypeChecker.list,
      );
    } on DioException catch (exception) {
      throw SimpleError(
          requestOptions: exception.requestOptions,
          error: exception.error,
          message: exception.message,
          response: exception.response,
          stackTrace: exception.stackTrace,
          type: exception.type);
    }
  }
}
