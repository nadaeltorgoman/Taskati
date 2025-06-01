import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/themes.dart';
import 'package:taskati/features/intro/pages/splash_screen.dart';

Future<void> main() async {
   // Ensure that plugin services are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register the adapter
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(TaskModelAdapter());
  }
  
  try {
    await LocalStorage.init();
  } catch (e) {
    print('Error initializing storage: $e');
    
    // Close boxes first if they're open
    try {
      if (Hive.isBoxOpen('user')) {
        await Hive.box('user').close();
      }
      
      if (Hive.isBoxOpen('tasks')) {
        await Hive.box<TaskModel>('tasks').close();
      }
    } catch (closeErr) {
      print('Error closing boxes: $closeErr');
    }
    
    // delete the boxes
    try {
      await Hive.deleteBoxFromDisk('tasks');
      await Hive.deleteBoxFromDisk('user');
    } catch (deleteErr) {
      print('Error deleting boxes: $deleteErr');
    }
    
    await LocalStorage.init();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskati',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      home: const SplashScreen(),
    );
  }
}
