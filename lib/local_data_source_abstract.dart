part of 'local_data_source.dart';

abstract class LocalDataSourceAbstract {
  List<T> getAllOfType<T>();

  Future<int> addItemOfType<T>(T item);

  Future<Iterable<int>> addItemsOfType<T>(List<T> items);

  Future<void> deleteItemOfType<T>(T item);

  Future<void> deleteAllOfType<T>();

  Stream<T>? watchAllOfType<T>();
}
