library local_data_source;

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_base.dart';
part 'local_data_source_abstract.dart';

abstract class LocalDataSource {
  ///To initialize singleton local Hive data source all you need to do is run this method with proper values.
  ///
  ///Don't forget to 'part' type adapters for corresponding model class and setup as you usually would with Hive annotations
  /// and finally run build-runner with hive-generator which creates TypeAdapters for you.
  ///
  ///You can create any [securityKey] which handles secure storage of data.
  ///Specify for which unique type which TypeAdapter is being mapped in [typeToTypeAdapters]
  ///
  /// After initialization you are ready to use this lib with basic CRUD 'ofType' methods available in this class
  /// which you can additionally wrap with corresponding type-defined repositories.
  static Future<void> init({required String securityKey, required Map<Type, TypeAdapter> typeToTypeAdapters}) async =>
      await HiveBase.init(securityKey: securityKey, typeToTypeAdapters: typeToTypeAdapters);

  static Future<int> addItemOfType<T>(T item) async => await HiveBase().addItemOfType<T>(item);

  static Future<Iterable<int>> addItemsOfType<T>(List<T> items) async => await HiveBase().addItemsOfType<T>(items);

  static Future<void> deleteItemOfType<T>(T item) async => await HiveBase().deleteAllOfType<T>();

  static Future<void> deleteAllOfType<T>() async => HiveBase().deleteAllOfType<T>();

  static List<T> getAllOfType<T>() => HiveBase().getAllOfType<T>();

  static Stream<T>? watchAllOfType<T>() => HiveBase().watchAllOfType<T>();
}
