import 'package:hive_flutter/hive_flutter.dart';

class TypeDefinedAdapter<T> {
  final TypeAdapter<T> typeAdapter;
  final T type;

  TypeDefinedAdapter({required this.typeAdapter, required this.type});
}
