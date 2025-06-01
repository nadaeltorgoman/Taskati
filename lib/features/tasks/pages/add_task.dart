import 'package:flutter/material.dart';
import 'package:taskati/features/tasks/widgets/body_task.dart';

class AddTask extends StatefulWidget {
  final String selectedDate;
  const AddTask({super.key, required this.selectedDate});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  

  @override
  Widget build(BuildContext context) {
    return BodyTask(selectedDate: widget.selectedDate);
  }
}
