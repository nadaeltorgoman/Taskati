import 'package:hive_flutter/adapters.dart';
import 'package:taskati/core/model/task_model.dart';

class LocalStorage {

  static late Box _box;
  static late Box<TaskModel> taskBox;
  static const String name = 'name';
  static const String imagePath = 'imagePath';
  // Initialize Hive
  static Future<void> init() async {
  try {
    // Check if boxes are already open
    if (Hive.isBoxOpen('user')) {
      _box = Hive.box('user');
    } else {
      _box = await Hive.openBox('user');
    }
    
    if (Hive.isBoxOpen('tasks')) {
      taskBox = Hive.box<TaskModel>('tasks');
    } else {
      taskBox = await Hive.openBox<TaskModel>('tasks');
    }
  } catch (e) {
    print('Error in local storage init: $e');
    rethrow;
  }
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

  // Save task to local storage
  static saveTask(String key, TaskModel task) {
    taskBox.put(key, task);
  }

  // update task in local storage
  static updateTask(String key, TaskModel task) {
    taskBox.put(key, task);
  }

  // Get task from local storage
  static TaskModel? getTask(String key) {
    return taskBox.get(key);
  }
}
