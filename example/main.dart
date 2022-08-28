import 'package:flutter/material.dart';
import 'package:local_data_source/local_data_source.dart';

import 'custom_model.dart';
import 'second_model.dart';

void main() async {
  await LocalDataSource.builder(
    (builder) async {
      builder.appendAdapter<CustomModel>(adapter: CustomModelAdapter());
      builder.appendAdapter<SecondModel>(adapter: SecondModelAdapter());
      await builder.build();
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    randomStuff();
    return const Scaffold(
      body: Center(
        child: Text("hello"),
      ),
    );
  }

  Future<void> randomStuff() async {
    await LocalDataSource.deleteAllOfType<CustomModel>();
    await LocalDataSource.addItemOfType<CustomModel>(const CustomModel(first: "fgd", second: 455.3));
    await LocalDataSource.addItemOfType<SecondModel>(const SecondModel(third: "fghfghfgh", forth: 4.77));
    debugPrint(LocalDataSource.getAllOfType<CustomModel>().map((e) => e.toString()).join(", "));
    debugPrint(LocalDataSource.getAllOfType<SecondModel>().map((e) => e.toString()).join(", "));
  }
}
