import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/themes.dart';
import 'package:taskati/features/intro/pages/splash_screen.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized
  // before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register the adapter
  Hive.registerAdapter(TaskModelAdapter());
  try {
    await LocalStorage.init();
  } catch (e) {
    print('Error initializing storage: $e');
    // Handle gracefully - perhaps delete corrupted boxes
    await Hive.deleteBoxFromDisk('tasks');
    await Hive.deleteBoxFromDisk('user');
    // Try again
    await Hive.openBox('user');
    await Hive.openBox<TaskModel>('tasks');
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
