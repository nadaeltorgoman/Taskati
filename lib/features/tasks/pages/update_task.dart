import 'package:flutter/material.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/features/tasks/widgets/body_task.dart';

class UpdateTask extends StatefulWidget {
  final String selectedDate;
  final String taskId;
  const UpdateTask({
    super.key,
    required this.selectedDate,
    required this.taskId,
  });

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  @override
  Widget build(BuildContext context) {
    TaskModel? task = LocalStorage.taskBox.get(widget.taskId);

    if (task == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Task not found')),
        body: Center(child: Text('This task no longer exists')),
      );
    }
    return BodyTask(
      selectedDate: widget.selectedDate,
      taskId: task.id,
      title: task.title,
      description: task.description,
      date: task.date,
      startDate: task.startDate,
      endDate: task.endDate,
      isCompleted: task.isCompleted,
      color: task.color,
      addTask: false,
    );
  }
}
