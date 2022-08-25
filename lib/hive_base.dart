part of 'local_data_source.dart';

class HiveBase extends LocalDataSourceAbstract {
  static final HiveBase _hiveBase = HiveBase._internal();

  HiveBase._internal();

  factory HiveBase() {
    return _hiveBase;
  }

  static final Map<Type, Box<dynamic>> _boxes = {};

  static void _registerBoxes({required Iterable<Type> types}) {
    for (Type type in types) {
      _boxes[type] = Hive.box(type.runtimeType.toString());
    }
  }

  ///Securely opens each box with the same encryption key.
  static Future<void> _openBoxesSecurely({required String securityKey, required Iterable<String> typeNames}) async {
    const secureStorage = FlutterSecureStorage();
    String? key;
    if (await secureStorage.containsKey(key: securityKey)) {
      key = await secureStorage.read(key: securityKey);
    } else {
      key = base64Encode(Hive.generateSecureKey());
      await secureStorage.write(key: securityKey, value: key);
    }
    if (key == null) {
      key = base64Encode(Hive.generateSecureKey());
      await secureStorage.write(key: securityKey, value: key);
    }
    final decoded64 = base64Decode(key);
    for (String name in typeNames) {
      await Hive.openBox(name, encryptionCipher: HiveAesCipher(decoded64));
    }
  }

  static void _registerAdapters({required Map<Type, TypeAdapter<dynamic>> typeToTypeAdapter}) {
    for (MapEntry<Type, TypeAdapter<dynamic>> entry in typeToTypeAdapter.entries) {
      Hive.registerAdapter(entry.value);
    }
  }

  static bool _noneBoxOpened() {
    for (Box<dynamic> box in _boxes.values) {
      if (Hive.isBoxOpen(box.name)) {
        return false;
      }
    }
    return true;
  }

  static Future<void> init(
      {required String securityKey, required Map<Type, TypeAdapter<dynamic>> typeToTypeAdapters}) async {
    if (_noneBoxOpened()) {
      await Hive.initFlutter();
      _registerAdapters(typeToTypeAdapter: typeToTypeAdapters);
      await _openBoxesSecurely(
          typeNames: typeToTypeAdapters.keys.map((e) => e.runtimeType.toString()), securityKey: securityKey);
      _registerBoxes(types: typeToTypeAdapters.keys);
    }
  }

  Box<dynamic>? _getProperBox<T>() => _boxes[T.runtimeType];

  @override
  Future<int> addItemOfType<T>(T item) async {
    return await _getProperBox<T>()?.add(item) ?? -1;
  }

  @override
  Future<Iterable<int>> addItemsOfType<T>(List<T> items) async {
    return await _getProperBox<T>()?.addAll(items) ?? const Iterable.empty();
  }

  @override
  Future<void> deleteAllOfType<T>() async {
    final keys = _getProperBox<T>()?.keys ?? [];
    for (dynamic key in keys) {
      await _getProperBox<T>()?.delete(key);
    }
  }

  @override
  Future<void> deleteItemOfType<T>(T item) async {
    final box = _getProperBox<T>();
    final existing = _getProperBox<T>()?.values.firstWhereOrNull((element) => element == item);
    final index = box?.values.toList().indexOf(existing);
    if (index != null) {
      await box?.deleteAt(index);
    }
  }

  @override
  List<T> getAllOfType<T>() {
    return _getProperBox<T>()?.values.toList().cast<T>() ?? [];
  }

  @override
  Stream<T>? watchAllOfType<T>() {
    return _getProperBox<T>()?.watch().cast<T>();
  }
}
