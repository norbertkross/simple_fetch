# simple_fetch

A wrapper around [Dio](https://pub.dev/packages/dio) that maps a response into a model in one call. It works for a single JSON object, a list, and nested payloads such as `{"data": [...]}`.

Any 2xx status is success. Pass `successCodes` to allow or require specific codes, including codes outside 2xx. An empty body becomes `null`, or an empty list from the list methods. Pass `baseOptions` or an existing `Dio` to set a base URL, headers, and timeouts. `url` is required.


## Get started

### Install

Add the `simple_fetch` package to your
[pubspec dependencies](https://pub.dev/packages/simple_fetch/install).


```dart
import 'package:simple_fetch/simple_fetch.dart';

final simpleFetch = SimpleFetch();
String apiUrl = 'https://jsonplaceholder.typicode.com/todos/';

```

### Very simple use

```dart

  testGet()async{

      List<Todo?> allProductsData = await simpleFetch.getList<Todo>(
        url: apiUrl,
        mapper: Todo.fromJson,
      );

  }

```

## Examples

Performing a `GET` request :

```dart

 /// Fetch an object and make it a model type
  void getOneDataItemFromEndpoint() async {
    SimpleFetch simpleFetch = SimpleFetch();

    String apiUrl = 'https://jsonplaceholder.typicode.com/todos/1';

    try {
      Todo? productsData = await simpleFetch.get<Todo>(
        url: apiUrl,
        mapper: Todo.fromJson,
        // transformer: (transform) => transform['data'],
      );
      print(productsData?.toJson());
    } on SimpleError catch (exception) {
      print(exception.message);
    } catch (e) {}
  }


 /// Fetch a List of object and make it a model type

  void getDataFromEndpoint() async {

    SimpleFetch simpleFetch = SimpleFetch();

    String apiUrl = 'https://jsonplaceholder.typicode.com/todos/';

    try {
      List<Todo?> allProductsData = await simpleFetch.getList<Todo>(
        url: apiUrl,
        mapper: Todo.fromJson,
      );

      print(allProductsData.map((e) => e?.toJson()).toList());
    } on SimpleError catch (exception) {
      print(exception.message);
    } catch (e) {}
  }

```

Performing a `POST` request:

```dart

 /// If the response of your post request is a single item
  void postSingleResponse() async {
    SimpleFetch simpleFetch = SimpleFetch();

    String apiUrl = 'https://jsonplaceholder.typicode.com/todos/1';

    try {
      Todo? productsData = await simpleFetch.post<Todo>(
        url: apiUrl,
        data: {'id': 1, 'name': 'hello'},
        mapper: Todo.fromJson,
        // transformer: (transform) => transform['data'],
      );
      print(productsData?.toJson());
    } on SimpleError catch (exception) {
      print(exception.message);
    } catch (e) {}
  }

 // If the response of your post request is a list of item

  void postMultipleResponse() async {

    SimpleFetch simpleFetch = SimpleFetch();

    String apiUrl = 'https://jsonplaceholder.typicode.com/todos/';

    try {
      List<Todo?> allProductsData = await simpleFetch.postList<Todo>(
        url: apiUrl,
        data: {'id': 2, 'name': 'Hiiii'},
        mapper: Todo.fromJson,
      );

      print(allProductsData.map((e) => e?.toJson()).toList());
    } on SimpleError catch (exception) {
      print(exception.message);
    } catch (e) {}
  }

```

Performing multiple concurrent requests:

```dart
response = await Future.wait([request1, request2]);
```



## Transformers

By default the packages is designed for you to simply retrieve data that is a list or json
Sometimes you may want to remove,add or filter the data that is received before making it an object
The transformer parameter helps you achieve this 
```dart
{
    "data":[
        {
            "userId": 1,
            "id": 1,
            "title": "delectus aut autem",
            "completed": false
        },
        {
            "userId": 2,
            "id": 2,
            "title": "User ovier vac",
            "completed": true
        },
    ]
}
```

In this case you may want to return an list so you can do

```dart
    try {
      List<Todo?> allProductsData = await simpleFetch.getList<Todo>(
        url: apiUrl,
        mapper: Todo.fromJson,
        transformer: (transform) => transform['data'],
      );

      print(allProductsData.map((e) => e?.toJson()).toList());
    } on SimpleError catch (exception) {
      print(exception.message);
    } catch (e) {}
```