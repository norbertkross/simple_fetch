import 'package:dio/dio.dart';
import 'package:simple_fetch/simple_fetch.dart';
import 'package:simple_fetch/src/enums/enums.dart';
import 'package:simple_fetch/src/utils/helpers.dart';

class DeleteMethods extends SimpleFetch {
  /// Make an http GET request
  static T? deleteObjectTranformer<T>({
    required Response response,
    required T Function(Map<String, dynamic>)? mapper,
    Function(dynamic transform)? transformer,
    List<int>? successCodes,
    required ResponseTypeChecker? responseTypeChecker,
  }) {
    // Assert to prevent list response method being used as object response
    Helpers.assertIsList(
        response.data, responseTypeChecker ?? ResponseTypeChecker.object);

    if (successCodes?.contains(response.statusCode) == true) {
      // Parse JSON response and convert it to an instance of type T
      var jsonResponse = response.data;

      // Transform the response before making it a model
      if (transformer != null) {
        jsonResponse = transformer(jsonResponse);
      }

      T? data = mapper?.call(jsonResponse);
      return data;
    } else {
      throw SimpleError(
        requestOptions: response.requestOptions,
        message: response.statusMessage,
        response: response,
        stackTrace: StackTrace.current,
        type: DioExceptionType.badResponse,
        error: null,
      );
      // return null;
    }
  }

  /// Make an http GET request when the response is a list
  static Future<List<T?>> deleteListObjectTranformer<T>({
    required Response response,
    required T Function(Map<String, dynamic>)? mapper,
    Function(dynamic transform)? transformer,
    List<int>? successCodes,
    required ResponseTypeChecker? responseTypeChecker,
  }) async {
    // Assert to prevent list response method being used as object response
    Helpers.assertIsList(
        response.data, responseTypeChecker ?? ResponseTypeChecker.object);

    if (successCodes?.contains(response.statusCode) == true) {
      // Parse JSON response and convert it to an instance of type T
      List? jsonResponse = response.data;

      // Transform the response before making it a model
      if (transformer != null) {
        jsonResponse = transformer(jsonResponse);
      }

      List<T?>? data = jsonResponse?.map((e) => mapper?.call(e)).toList() ?? [];
      return data;
    } else {
      throw SimpleError(
        requestOptions: response.requestOptions,
        message: response.statusMessage,
        response: response,
        stackTrace: StackTrace.current,
        type: DioExceptionType.badResponse,
        error: null,
      );
    }
  }
}
