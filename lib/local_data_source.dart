library local_data_source;

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

export 'package:equatable/equatable.dart';
export 'package:hive/hive.dart';
export 'package:hive_flutter/hive_flutter.dart';

part 'hive_base.dart';
part 'local_data_source_abstract.dart';

class LocalDataSourceBuilder {
  void appendAdapter<T>({required TypeAdapter<T> adapter}) {
    HiveBase.registerType<T>(adapter: adapter);
  }

  Future<void> build({String? securityKey}) async =>
      await HiveBase.openBoxes(securityKey: securityKey);
}

abstract class LocalDataSource {
  static late LocalDataSourceBuilder _builder;

  ///To initialize singleton local Hive data source all you need to do is to start builder flow by calling builder() method
  ///and append all your TypeAdapters with appendAdapter method. Finally flow is done by calling build() method after appending
  ///adapters.
  ///
  ///Don't forget to 'part' type adapters for corresponding model class and setup as you usually would with Hive annotations
  /// and finally run build-runner with hive-generator which creates TypeAdapters for you.
  ///
  ///You can create optional [securityKey] which handles secure storage of data.
  ///Specify for which unique type which TypeAdapter is being mapped in [typeDefinedAdapters]
  ///
  /// After initialization you are ready to use this lib with basic CRUD 'ofType' methods available in this class
  /// which you can additionally wrap with corresponding type-defined repositories.
  static Future<void> builder(
      Function(LocalDataSourceBuilder builder) initializationDone) async {
    await HiveBase.init();
    _builder = LocalDataSourceBuilder();
    initializationDone(_builder);
  }

  static Future<int> addItemOfType<T extends Equatable>(T item) async =>
      await HiveBase().addItemOfType<T>(item);

  static Future<Iterable<int>> addItemsOfType<T extends Equatable>(
          List<T> items) async =>
      await HiveBase().addItemsOfType<T>(items);

  static Future<void> deleteItemOfType<T extends Equatable>(T item) async =>
      await HiveBase().deleteAllOfType<T>();

  static Future<void> deleteAllOfType<T extends Equatable>() async =>
      HiveBase().deleteAllOfType<T>();

  static List<T> getAllOfType<T extends Equatable>() =>
      HiveBase().getAllOfType<T>();

  static Stream<T>? watchAllOfType<T extends Equatable>() =>
      HiveBase().watchAllOfType<T>();
}
