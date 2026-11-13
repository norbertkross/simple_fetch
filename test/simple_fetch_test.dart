import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_fetch/simple_fetch.dart';

class Todo {
  Todo({this.userId, this.id, this.title, this.completed});

  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'] as int?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      completed: json['completed'] as bool?,
    );
  }
}

Map<String, dynamic> todoJson({
  int id = 1,
  String title = 'delectus aut autem',
}) {
  return <String, dynamic>{
    'userId': 1,
    'id': id,
    'title': title,
    'completed': false,
  };
}

SimpleFetch client(Object? Function(RequestOptions options) reply) {
  final dio = Dio();
  addTearDown(dio.close);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final result = reply(options);
        if (result is DioException) {
          handler.reject(result);
          return;
        }
        if (result is Response) {
          handler.resolve(result);
          return;
        }
        handler.resolve(
          Response<dynamic>(
            requestOptions: options,
            statusCode: 200,
            data: result,
          ),
        );
      },
    ),
  );
  return SimpleFetch(dio: dio);
}

void main() {
  test('get maps a JSON object', () async {
    final fetch = client((_) => todoJson());

    final todo = await fetch.get<Todo>(url: '/todos/1', mapper: Todo.fromJson);

    expect(todo?.id, 1);
    expect(todo?.title, 'delectus aut autem');
  });

  test('get accepts map keys that are not declared as String', () async {
    final fetch = client((_) {
      return <dynamic, dynamic>{
        'userId': 1,
        'id': 4,
        'title': 'loose',
        'completed': true,
      };
    });

    final todo = await fetch.get<Todo>(url: '/todos/4', mapper: Todo.fromJson);

    expect(todo?.id, 4);
    expect(todo?.title, 'loose');
    expect(todo?.completed, isTrue);
  });

  test('getList maps each object and keeps null items', () async {
    final fetch = client(
      (_) => <dynamic>[todoJson(id: 1), null, todoJson(id: 2, title: 'next')],
    );

    final todos = await fetch.getList<Todo>(
      url: '/todos',
      mapper: Todo.fromJson,
    );

    expect(todos.map((todo) => todo?.id).toList(), <int?>[1, null, 2]);
    expect(todos[2]?.title, 'next');
  });

  test('transformer unwraps a nested object or list', () async {
    final fetch = client((options) {
      if (options.path == '/one') {
        return <String, dynamic>{'data': todoJson(id: 7, title: 'nested')};
      }
      return <String, dynamic>{
        'data': <dynamic>[todoJson(id: 8, title: 'row')],
      };
    });

    final one = await fetch.get<Todo>(
      url: '/one',
      mapper: Todo.fromJson,
      transformer: (body) => body['data'],
    );
    final many = await fetch.getList<Todo>(
      url: '/many',
      mapper: Todo.fromJson,
      transformer: (body) => body['data'],
    );

    expect(one?.title, 'nested');
    expect(many.single?.id, 8);
  });

  test('transformer can pick one object out of a list', () async {
    final fetch = client((_) => <dynamic>[todoJson(id: 1), todoJson(id: 2)]);

    final todo = await fetch.get<Todo>(
      url: '/todos',
      mapper: Todo.fromJson,
      transformer: (body) => body.first,
    );

    expect(todo?.id, 1);
  });

  test('object and list methods reject the other shape', () async {
    final listFetch = client((_) => <dynamic>[todoJson()]);
    final objectFetch = client((_) => todoJson());

    await expectLater(
      listFetch.get<Todo>(url: '/todos', mapper: Todo.fromJson),
      throwsA(
        isA<SimpleError>().having(
          (error) => error.message,
          'message',
          contains('list method'),
        ),
      ),
    );
    await expectLater(
      objectFetch.getList<Todo>(url: '/todos/1', mapper: Todo.fromJson),
      throwsA(
        isA<SimpleError>().having(
          (error) => error.message,
          'message',
          contains('object method'),
        ),
      ),
    );
  });

  test('a non-object body throws SimpleError', () async {
    final fetch = client((_) => 'hello');

    await expectLater(
      fetch.get<Todo>(url: '/todos/1', mapper: Todo.fromJson),
      throwsA(
        isA<SimpleError>().having(
          (error) => error.message,
          'message',
          contains('JSON object'),
        ),
      ),
    );
  });

  test(
    'an empty body is null for an object and an empty list for a list',
    () async {
      final fetch = client(
        (options) =>
            Response<dynamic>(requestOptions: options, statusCode: 204),
      );

      final todo = await fetch.delete<Todo>(
        url: '/todos/1',
        mapper: Todo.fromJson,
      );
      final todos = await fetch.deleteList<Todo>(
        url: '/todos',
        mapper: Todo.fromJson,
      );

      expect(todo, isNull);
      expect(todos, isEmpty);
    },
  );

  test('any 2xx status is success unless successCodes is set', () async {
    final created = client(
      (options) => Response<dynamic>(
        requestOptions: options,
        statusCode: 201,
        data: todoJson(id: 3, title: 'created'),
      ),
    );
    final rejected = client(
      (options) => Response<dynamic>(
        requestOptions: options,
        statusCode: 201,
        data: todoJson(),
      ),
    );

    final todo = await created.post<Todo>(
      url: '/todos',
      data: todoJson(id: 3, title: 'created'),
      mapper: Todo.fromJson,
    );

    expect(todo?.title, 'created');
    await expectLater(
      rejected.get<Todo>(
        url: '/todos/1',
        mapper: Todo.fromJson,
        successCodes: const <int>[200],
      ),
      throwsA(isA<SimpleError>()),
    );
  });

  test('successCodes can accept a status Dio would otherwise reject', () async {
    late RequestOptions seen;
    final fetch = client((options) {
      seen = options;
      return Response<dynamic>(
        requestOptions: options,
        statusCode: 404,
        data: todoJson(id: 9, title: 'missing'),
      );
    });

    final todo = await fetch.get<Todo>(
      url: '/todos/9',
      mapper: Todo.fromJson,
      successCodes: const <int>[404],
    );

    expect(todo?.id, 9);
    expect(seen.validateStatus(404), isTrue);
    expect(seen.validateStatus(200), isFalse);
  });

  test(
    'a caller validateStatus is kept and successCodes still filters',
    () async {
      bool allowAll(int? status) => true;
      final fetch = client(
        (options) => Response<dynamic>(
          requestOptions: options,
          statusCode: 500,
          statusMessage: 'nope',
          data: todoJson(),
        ),
      );

      await expectLater(
        fetch.get<Todo>(
          url: '/todos/1',
          mapper: Todo.fromJson,
          options: Options(validateStatus: allowAll),
          successCodes: const <int>[200],
        ),
        throwsA(
          isA<SimpleError>().having(
            (error) => error.message,
            'message',
            'nope',
          ),
        ),
      );
    },
  );

  test('Dio failures become SimpleError', () async {
    final fetch = client(
      (options) => DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
        message: 'offline',
      ),
    );

    await expectLater(
      fetch.get<Todo>(url: '/todos/1', mapper: Todo.fromJson),
      throwsA(
        isA<SimpleError>()
            .having(
              (error) => error.type,
              'type',
              DioExceptionType.connectionError,
            )
            .having((error) => error.message, 'message', 'offline')
            .having(
              (error) => error.toString(),
              'toString',
              contains('offline'),
            ),
      ),
    );
  });

  test('each verb is sent with its method, path, query, and body', () async {
    final methods = <String>['GET', 'POST', 'PUT', 'PATCH', 'DELETE'];

    for (final method in methods) {
      late RequestOptions seen;
      final fetch = client((options) {
        seen = options;
        return todoJson();
      });

      await _callObject(
        fetch,
        method,
        queryParameters: method == 'POST'
            ? <String, dynamic>{'draft': '1'}
            : null,
        data: method == 'GET' ? null : <String, dynamic>{'title': 't'},
      );

      expect(seen.method, method, reason: method);
      expect(seen.path, '/todos');
      if (method == 'POST') {
        expect(seen.data, <String, dynamic>{'title': 't'});
        expect(seen.queryParameters['draft'], '1');
      }
    }
  });

  test('list verbs decode a list', () async {
    Future<List<Todo?>> send(SimpleFetch fetch, String method) {
      switch (method) {
        case 'GET':
          return fetch.getList<Todo>(url: '/todos', mapper: Todo.fromJson);
        case 'POST':
          return fetch.postList<Todo>(url: '/todos', mapper: Todo.fromJson);
        case 'PUT':
          return fetch.putList<Todo>(url: '/todos', mapper: Todo.fromJson);
        case 'PATCH':
          return fetch.patchList<Todo>(url: '/todos', mapper: Todo.fromJson);
        case 'DELETE':
          return fetch.deleteList<Todo>(url: '/todos', mapper: Todo.fromJson);
        default:
          throw StateError(method);
      }
    }

    for (final method in <String>['GET', 'POST', 'PUT', 'PATCH', 'DELETE']) {
      final fetch = client((_) => <dynamic>[todoJson(id: 5)]);
      final todos = await send(fetch, method);
      expect(todos.single?.id, 5, reason: method);
    }
  });

  test('baseOptions sets the base URL and default headers', () async {
    final fetch = SimpleFetch(
      baseOptions: BaseOptions(
        baseUrl: 'https://example.com',
        headers: <String, dynamic>{'Authorization': 'Bearer t'},
      ),
    );
    addTearDown(fetch.dio.close);
    late RequestOptions seen;
    fetch.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          seen = options;
          handler.resolve(
            Response<dynamic>(
              requestOptions: options,
              statusCode: 200,
              data: todoJson(),
            ),
          );
        },
      ),
    );

    await fetch.get<Todo>(url: '/todos/1', mapper: Todo.fromJson);

    expect(seen.uri.toString(), 'https://example.com/todos/1');
    expect(seen.headers['Authorization'], 'Bearer t');
  });

  test('fetches one todo and a short list from jsonplaceholder', () async {
    final fetch = SimpleFetch();
    addTearDown(fetch.dio.close);

    final todo = await fetch.get<Todo>(
      url: 'https://jsonplaceholder.typicode.com/todos/1',
      mapper: Todo.fromJson,
    );
    final todos = await fetch.getList<Todo>(
      url: 'https://jsonplaceholder.typicode.com/todos',
      queryParameters: <String, dynamic>{'_limit': 2},
      mapper: Todo.fromJson,
    );

    expect(todo?.id, 1);
    expect(todo?.title, isNotEmpty);
    expect(todos.length, 2);
    expect(todos.every((item) => item?.id != null), isTrue);

    await expectLater(
      fetch.get<Todo>(
        url: 'https://jsonplaceholder.typicode.com/todos/0',
        mapper: Todo.fromJson,
      ),
      throwsA(isA<SimpleError>()),
    );

    final missing = await fetch.get<Todo>(
      url: 'https://jsonplaceholder.typicode.com/todos/0',
      mapper: Todo.fromJson,
      successCodes: const <int>[404],
    );
    expect(missing?.id, isNull);
  });
}

Future<void> _callObject(
  SimpleFetch fetch,
  String method, {
  Map<String, dynamic>? queryParameters,
  Object? data,
}) {
  switch (method) {
    case 'GET':
      return fetch.get<Todo>(
        url: '/todos',
        mapper: Todo.fromJson,
        queryParameters: queryParameters,
        data: data,
      );
    case 'POST':
      return fetch.post<Todo>(
        url: '/todos',
        mapper: Todo.fromJson,
        queryParameters: queryParameters,
        data: data,
      );
    case 'PUT':
      return fetch.put<Todo>(
        url: '/todos',
        mapper: Todo.fromJson,
        queryParameters: queryParameters,
        data: data,
      );
    case 'PATCH':
      return fetch.patch<Todo>(
        url: '/todos',
        mapper: Todo.fromJson,
        queryParameters: queryParameters,
        data: data,
      );
    case 'DELETE':
      return fetch.delete<Todo>(
        url: '/todos',
        mapper: Todo.fromJson,
        queryParameters: queryParameters,
        data: data,
      );
    default:
      throw StateError(method);
  }
}
