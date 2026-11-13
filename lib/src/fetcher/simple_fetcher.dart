import 'package:dio/dio.dart';
import 'package:simple_fetch/src/models/simple_error.dart';

class SimpleFetch {
  final Dio dio;

  /// [dio] is used as-is when set. Otherwise a client is built from
  /// [baseOptions], which is where a base URL, headers, and timeouts go.
  SimpleFetch({Dio? dio, BaseOptions? baseOptions})
    : dio = dio ?? Dio(baseOptions);

  /// Make an http GET request.
  Future<T?> get<T>({
    required String url,
    required T Function(Map<String, dynamic>)? mapper,
    Function(dynamic transform)? transformer,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    List<int>? successCodes,
  }) async {
    final response = await _request(
      'GET',
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      successCodes: successCodes,
    );
    return _decodeObject<T>(
      response,
      mapper: mapper,
      transformer: transformer,
      successCodes: successCodes,
    );
  }

  /// Make an http GET request when the response is a list.
  Future<List<T?>> getList<T>({
    required String url,
    required T Function(Map<String, dynamic>)? mapper,
    Function(dynamic transform)? transformer,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    List<int>? successCodes,
  }) async {
    final response = await _request(
      'GET',
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      successCodes: successCodes,
    );
    return _decodeList<T>(
      response,
      mapper: mapper,
      transformer: transformer,
      successCodes: successCodes,
    );
  }

  /// Make an http POST request.
  Future<T?> post<T>({
    required String url,
    required T Function(Map<String, dynamic>)? mapper,
    Function(dynamic transform)? transformer,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    List<int>? successCodes,
  }) async {
    final response = await _request(
      'POST',
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
      successCodes: successCodes,
    );
    return _decodeObject<T>(
      response,
      mapper: mapper,
      transformer: transformer,
      successCodes: successCodes,
    );
  }

  /// Make an http POST request when the response is a list.
  Future<List<T?>> postList<T>({
    required String url,
    required T Function(Map<String, dynamic>)? mapper,
    Function(dynamic transform)? transformer,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    List<int>? successCodes,
  }) async {
    final response = await _request(
      'POST',
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
      successCodes: successCodes,
    );
    return _decodeList<T>(
      response,
      mapper: mapper,
      transformer: transformer,
      successCodes: successCodes,
    );
  }

  /// Make an http PUT request.
  Future<T?> put<T>({
    required String url,
    required T Function(Map<String, dynamic>)? mapper,
    Function(dynamic transform)? transformer,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    List<int>? successCodes,
  }) async {
    final response = await _request(
      'PUT',
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
      successCodes: successCodes,
    );
    return _decodeObject<T>(
      response,
      mapper: mapper,
      transformer: transformer,
      successCodes: successCodes,
    );
  }

  /// Make an http PUT request when the response is a list.
  Future<List<T?>> putList<T>({
    required String url,
    required T Function(Map<String, dynamic>)? mapper,
    Function(dynamic transform)? transformer,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    List<int>? successCodes,
  }) async {
    final response = await _request(
      'PUT',
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
      successCodes: successCodes,
    );
    return _decodeList<T>(
      response,
      mapper: mapper,
      transformer: transformer,
      successCodes: successCodes,
    );
  }

  /// Make an http PATCH request.
  Future<T?> patch<T>({
    required String url,
    required T Function(Map<String, dynamic>)? mapper,
    Function(dynamic transform)? transformer,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    List<int>? successCodes,
  }) async {
    final response = await _request(
      'PATCH',
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
      successCodes: successCodes,
    );
    return _decodeObject<T>(
      response,
      mapper: mapper,
      transformer: transformer,
      successCodes: successCodes,
    );
  }

  /// Make an http PATCH request when the response is a list.
  Future<List<T?>> patchList<T>({
    required String url,
    required T Function(Map<String, dynamic>)? mapper,
    Function(dynamic transform)? transformer,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    List<int>? successCodes,
  }) async {
    final response = await _request(
      'PATCH',
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
      successCodes: successCodes,
    );
    return _decodeList<T>(
      response,
      mapper: mapper,
      transformer: transformer,
      successCodes: successCodes,
    );
  }

  /// Make an http DELETE request.
  Future<T?> delete<T>({
    required String url,
    required T Function(Map<String, dynamic>)? mapper,
    Function(dynamic transform)? transformer,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    List<int>? successCodes,
  }) async {
    final response = await _request(
      'DELETE',
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      successCodes: successCodes,
    );
    return _decodeObject<T>(
      response,
      mapper: mapper,
      transformer: transformer,
      successCodes: successCodes,
    );
  }

  /// Make an http DELETE request when the response is a list.
  Future<List<T?>> deleteList<T>({
    required String url,
    required T Function(Map<String, dynamic>)? mapper,
    Function(dynamic transform)? transformer,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    List<int>? successCodes,
  }) async {
    final response = await _request(
      'DELETE',
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      successCodes: successCodes,
    );
    return _decodeList<T>(
      response,
      mapper: mapper,
      transformer: transformer,
      successCodes: successCodes,
    );
  }

  Future<Response<dynamic>> _request(
    String method,
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    List<int>? successCodes,
  }) async {
    try {
      return await dio.request<dynamic>(
        url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        options: _options(options, method, successCodes),
      );
    } on DioException catch (exception) {
      throw SimpleError.fromDio(exception);
    }
  }
}

Options _options(Options? options, String method, List<int>? successCodes) {
  final resolved = (options ?? Options()).copyWith(method: method);
  if (successCodes == null || resolved.validateStatus != null) {
    return resolved;
  }
  return resolved.copyWith(
    validateStatus: (status) => status != null && successCodes.contains(status),
  );
}

bool _isSuccess(int? statusCode, List<int>? successCodes) {
  if (statusCode == null) return false;
  if (successCodes != null) return successCodes.contains(statusCode);
  return statusCode >= 200 && statusCode < 300;
}

/// Transform first, then check the shape. Callers use [transformer] to unwrap
/// bodies such as `{"data": [...]}` before they are read as an object or list.
T? _decodeObject<T>(
  Response<dynamic> response, {
  required T Function(Map<String, dynamic>)? mapper,
  Function(dynamic transform)? transformer,
  List<int>? successCodes,
}) {
  _ensureSuccess(response, successCodes);
  final data = transformer == null ? response.data : transformer(response.data);
  if (data == null || data == '') return null;
  if (data is List) {
    throw _failure(
      response,
      'Response is a list. Use the list method, or a transformer that returns one object.',
      type: DioExceptionType.unknown,
    );
  }
  if (mapper == null) return null;
  return mapper(_asMap(data, response));
}

List<T?> _decodeList<T>(
  Response<dynamic> response, {
  required T Function(Map<String, dynamic>)? mapper,
  Function(dynamic transform)? transformer,
  List<int>? successCodes,
}) {
  _ensureSuccess(response, successCodes);
  final data = transformer == null ? response.data : transformer(response.data);
  if (data == null || data == '') return <T?>[];
  if (data is List == false) {
    throw _failure(
      response,
      'Response is not a list. Use the object method, or a transformer that returns a list.',
      type: DioExceptionType.unknown,
    );
  }
  return data.map<T?>((item) {
    if (item == null || mapper == null) return null;
    return mapper(_asMap(item, response));
  }).toList();
}

void _ensureSuccess(Response<dynamic> response, List<int>? successCodes) {
  if (_isSuccess(response.statusCode, successCodes)) return;
  final reason = response.statusMessage;
  final message = (reason == null || reason.isEmpty)
      ? 'Request failed with status ${response.statusCode}'
      : reason;
  throw _failure(response, message);
}

Map<String, dynamic> _asMap(dynamic data, Response<dynamic> response) {
  if (data is Map<String, dynamic>) return data;
  if (data is Map) {
    return data.map((key, value) => MapEntry(key.toString(), value));
  }
  throw _failure(
    response,
    'Expected a JSON object but got ${data.runtimeType}.',
    type: DioExceptionType.unknown,
  );
}

SimpleError _failure(
  Response<dynamic> response,
  String message, {
  DioExceptionType type = DioExceptionType.badResponse,
}) {
  return SimpleError(
    requestOptions: response.requestOptions,
    message: message,
    response: response,
    stackTrace: StackTrace.current,
    type: type,
  );
}
