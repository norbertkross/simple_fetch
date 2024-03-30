# dio

A wrapper around [Dio](https://pub.dev/packages?q=topic%3Adio). This make simple and reduce the complexities
of working with models and http requests in Dart/Flutter.


## Get started

### Install

Add the `simple_fetch` package to your
[pubspec dependencies](https://pub.dev/packages/simple_fetch/install).


### Simple use

```dart
import 'package:simple_fetch/simple_fetch.dart';

final simpleFetch = SimpleFetch();
String apiUrl = 'https://jsonplaceholder.typicode.com/todos/';


  testGet()async{
    try {
      List<Todo?> allProductsData = await simpleFetch.getList<Todo>(
        url: apiUrl,
        mapper: (json) => Todo?.fromJson(json),
        // transformer: (transform) => transform['data'],
      );

      print(allProductsData.map((e) => e?.toJson()).toList());

    } on SimpleError catch (exception) {

      print(exception.message);

    } catch (e) {}
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
        mapper: (json) => Todo?.fromJson(json),
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
        mapper: (json) => Todo?.fromJson(json),
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
        mapper: (json) => Todo?.fromJson(json),
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
        mapper: (json) => Todo?.fromJson(json),
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
        mapper: (json) => Todo?.fromJson(json),
        transformer: (transform) => transform['data'],
      );

      print(allProductsData.map((e) => e?.toJson()).toList());
    } on SimpleError catch (exception) {
      print(exception.message);
    } catch (e) {}
```