
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:example/models/todo_model.dart';
import 'package:simple_fetch/simple_fetch.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return const SimpleFetchTestApp();
  }
}




class SimpleFetchTestApp extends StatefulWidget {
  const SimpleFetchTestApp({super.key});

  @override
  State<SimpleFetchTestApp> createState() => _SimpleFetchTestAppState();
}

class _SimpleFetchTestAppState extends State<SimpleFetchTestApp> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 120,
          ),
          Column(
            children: [
              CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  child: const Text("Fetch All..."),
                  onPressed: () {
                    getDataFromEndpoint();
                  }),
             const SizedBox(
                height: 60,
              ),
              CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  child: const Text("Single Fetch..."),
                  onPressed: () {
                    getOneDataItemFromEndpoint();
                  }),
            ],
          )
        ],
      ),
    );
  }
}
