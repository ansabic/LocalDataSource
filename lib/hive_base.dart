part of 'local_data_source.dart';

class HiveBase extends LocalDataSourceAbstract {
  static final HiveBase _hiveBase = HiveBase._internal();

  HiveBase._internal();

  factory HiveBase() {
    return _hiveBase;
  }

  static final List<String> _boxNames = [];

  ///Securely opens each box with the same encryption key.
  static Future<void> openBoxes({required String? securityKey}) async {
    if (securityKey != null) {
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
      for (String name in _boxNames) {
        if (!Hive.isBoxOpen(name)) {
          await Hive.openBox(name, encryptionCipher: HiveAesCipher(decoded64));
        }
      }
    } else {
      for (String name in _boxNames) {
        if (!Hive.isBoxOpen(name)) {
          await Hive.openBox(name);
        }
      }
    }
  }

  static void registerType<T>({required TypeAdapter<T> adapter}) {
    _boxNames.add(T.toString());
    Hive.registerAdapter(adapter);
  }

  static Future<void> init() async => await Hive.initFlutter();

  Box<dynamic>? _getProperBox<T>() {
    if (Hive.isBoxOpen(T.toString())) {
      return Hive.box(T.toString());
    }
    return null;
  }

  @override
  Future<int> addItemOfType<T extends Equatable>(T item) async {
    return await _getProperBox<T>()?.add(item) ?? -1;
  }

  @override
  Future<Iterable<int>> addItemsOfType<T extends Equatable>(
      List<T> items) async {
    return await _getProperBox<T>()?.addAll(items) ?? const Iterable.empty();
  }

  @override
  Future<void> deleteAllOfType<T extends Equatable>() async {
    final keys = _getProperBox<T>()?.keys ?? [];
    for (dynamic key in keys) {
      await _getProperBox<T>()?.delete(key);
    }
  }

  @override
  Future<void> deleteItemOfType<T extends Equatable>(T item) async {
    final box = _getProperBox<T>();
    final existing = box?.values.firstWhereOrNull((element) => element == item);
    final index = box?.values.toList().indexOf(existing);
    if (index != null) {
      await box?.deleteAt(index);
    }
  }

  @override
  List<T> getAllOfType<T extends Equatable>() {
    return _getProperBox<T>()?.values.toList().cast<T>() ?? [];
  }

  @override
  Stream<T>? watchAllOfType<T extends Equatable>() {
    return _getProperBox<T>()?.watch().cast<T>();
  }
}
