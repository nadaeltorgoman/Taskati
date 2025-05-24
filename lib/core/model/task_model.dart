import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)

class TaskModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String date;
  @HiveField(4)
  final String startDate;
  @HiveField(5)
  final String endDate;
  @HiveField(6)
  final bool isCompleted;
  @HiveField(7)
  final int color;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.date,
    this.isCompleted = false,
    this.color = 0xFF6200EE, // Default color (purple)
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
    String? startDate,
    String? endDate,
    bool? isCompleted,
    int? color,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCompleted: isCompleted ?? this.isCompleted,
      color: color ?? this.color,
    );
  }
}
