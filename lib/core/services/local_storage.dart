import 'package:hive_flutter/adapters.dart';

class LocalStorage {

  // Singleton pattern
  // static final LocalStorage _instance = LocalStorage._internal();
  // factory LocalStorage() {
  //   return _instance;
  // }
  // LocalStorage._internal();

  static late Box _box;
  static const String name = 'name';
  static const String imagePath = 'imagePath';
  // Initialize Hive
  static init(){
    _box = Hive.box('user');
  }


  // Save data to local storage
  static saveData(String key, String value) {
    _box.put(key, value);
  }

  // Get data from local storage
  static getData(String key) {
    return _box.get(key);
  }

  // Delete data from local storage
  static deleteData(String key) {
    _box.delete(key);
  }
}
