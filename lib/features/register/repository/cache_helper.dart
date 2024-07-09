import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class CacheHelper {
  static void saveData(String key, String value) async {
    final box = GetStorage();
    await box.write(key, value);
  }

  static Future<String?> getData(String key) async {
    final box = GetStorage();
    await box.initStorage;

    String? saved = box.read(key);
    // print('${saved ?? 'No TOKEN'} have been cached');
    return saved;
  }

  static void clearData(String key) async {
    final box = GetStorage();
    await box.remove(key);
  }

  static Future<void> saveList(String key, List<dynamic> list) async {
    final box = GetStorage();
    String jsonString = jsonEncode(list);
    await box.write(key, jsonString);
  }

  static Future<List<dynamic>?> getList(String key) async {
    final box = GetStorage();
    await box.initStorage;

    String? jsonString = box.read(key);
    if (jsonString != null) {
      List<dynamic> list = jsonDecode(jsonString);
      return list;
    } else {
      return null;
    }
  }
}
