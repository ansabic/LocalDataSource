part of 'local_data_source.dart';

abstract class LocalDataSourceAbstract {
  List<T> getAllOfType<T extends Equatable>();

  Future<int> addItemOfType<T extends Equatable>(T item);

  Future<Iterable<int>> addItemsOfType<T extends Equatable>(List<T> items);

  Future<void> deleteItemOfType<T extends Equatable>(T item);

  Future<void> deleteAllOfType<T extends Equatable>();

  Stream<T>? watchAllOfType<T extends Equatable>();
}
