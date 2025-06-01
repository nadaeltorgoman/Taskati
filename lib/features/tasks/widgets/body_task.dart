import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'package:taskati/core/functions/navigator.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/features/Home/pages/home_page.dart';

class BodyTask extends StatefulWidget {
  final String selectedDate;
  final String? taskId;
  final String? title;
  final String? description;
  final String? date;
  final String? startDate;
  final String? endDate;
  final bool? isCompleted;
  final int? color;
  final bool addTask;
  const BodyTask({
    super.key,
    required this.selectedDate,
    this.taskId,
    this.title,
    this.description,
    this.date,
    this.startDate,
    this.endDate,
    this.isCompleted,
    this.color,
    this.addTask = true,
  });

  @override
  State<BodyTask> createState() => _BodyTaskState();
}

class _BodyTaskState extends State<BodyTask> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  late int selectedColor;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(
      text: widget.addTask ? '' : widget.title,
    );
    descriptionController = TextEditingController(
      text: widget.addTask ? '' : widget.description,
    );
    dateController = TextEditingController(text: widget.selectedDate);

    startTimeController = TextEditingController(
      text:
          widget.addTask
              ? DateFormat('hh:mm a').format(DateTime.now())
              : widget.startDate!,
    );

    endTimeController = TextEditingController(
      text:
          widget.addTask
              ? DateFormat('hh:mm a').format(
                DateFormat('hh:mm a')
                    .parse(DateFormat('hh:mm a').format(DateTime.now()))
                    .add(const Duration(hours: 1)),
              )
              : widget.endDate!,
    );

    selectedColor = widget.addTask ? 0 : widget.color!;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.addTask ? 'Add Task' : 'Edit Task'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(),
                const Gap(10),
                description(),
                const Gap(10),
                date(),
                const Gap(10),
                Row(children: [startTime(), const Gap(10), endTime()]),
                const Gap(10),
                color(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MainButton(
          title: widget.addTask ? 'Add Task' : 'Update Task',
          onPressed: () {
            if (formKey.currentState?.validate() == true) {
              String taskId =
                  widget.addTask
                      ? DateTime.now().millisecondsSinceEpoch.toString()
                      : widget.taskId!;
              widget.addTask
                  ? LocalStorage.saveTask(
                    taskId,
                    TaskModel(
                      id: taskId,
                      title: titleController.text,
                      description: descriptionController.text,
                      date: dateController.text,
                      startDate: startTimeController.text,
                      endDate: endTimeController.text,
                      isCompleted: false,
                      color: selectedColor,
                    ),
                  )
                  : LocalStorage.updateTask(
                    taskId,
                    TaskModel(
                      id: taskId,
                      title: titleController.text,
                      description: descriptionController.text,
                      date: dateController.text,
                      startDate: startTimeController.text,
                      endDate: endTimeController.text,
                      isCompleted: false,
                      color: selectedColor,
                    ),
                  );
              context.pushReplacement(const HomePage());
            }
          },
          width: 160,
        ),
      ),
    );
  }

  Column title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Title',
          style: AppTextStyles.subtitle(context, fontWeight: FontWeight.w500),
        ),
        const Gap(5),
        TextFormField(
          controller: titleController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a title';
            }
            return null;
          },
          decoration: InputDecoration(hintText: 'Enter title'),
        ),
      ],
    );
  }

  Column description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppTextStyles.subtitle(context, fontWeight: FontWeight.w500),
        ),
        const Gap(5),
        TextFormField(
          controller: descriptionController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a description';
            }
            return null;
          },
          maxLines: 3,
          decoration: InputDecoration(hintText: 'Enter description'),
        ),
      ],
    );
  }

  Column date() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: AppTextStyles.subtitle(context, fontWeight: FontWeight.w500),
        ),
        const Gap(5),
        TextFormField(
          readOnly: true,
          controller: dateController,
          onTap: () async {
            await selectTaskDate();
          },
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.calendar_month_outlined),
          ),
        ),
      ],
    );
  }

  Future<void> selectTaskDate() async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate:
          widget.addTask
              ? DateTime.now()
              : DateFormat("yyyy-MM-dd").parse(widget.date!),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      dateController.text = DateFormat("yyyy-MM-dd").format(pickedDate);
    }
  }

  Expanded startTime() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Start Time',
            style: AppTextStyles.subtitle(context, fontWeight: FontWeight.w500),
          ),
          const Gap(5),
          TextFormField(
            readOnly: true,
            onTap: () async {
              var pickedTime = await showTimePicker(
                context: context,
                initialTime:
                    widget.addTask
                        ? TimeOfDay.now()
                        : TimeOfDay.fromDateTime(
                          DateFormat("HH:mm").parse(widget.startDate!),
                        ),
              );

              if (pickedTime != null) {
                startTimeController.text = pickedTime.format(context);
              }
            },
            controller: startTimeController,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.watch_later_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Expanded endTime() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'End Time',
            style: AppTextStyles.subtitle(context, fontWeight: FontWeight.w500),
          ),
          const Gap(5),
          TextFormField(
            readOnly: true,
            onTap: () async {
              var pickedTime = await showTimePicker(
                context: context,
                initialTime:
                    widget.addTask
                        ? TimeOfDay.now()
                        : TimeOfDay.fromDateTime(
                          DateFormat("HH:mm").parse(widget.endDate!),
                        ),
              );

              if (pickedTime != null) {
                endTimeController.text = pickedTime.format(context);
              }
            },
            controller: endTimeController,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.watch_later_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Column color() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: AppTextStyles.subtitle(context, fontWeight: FontWeight.w500),
        ),
        const Gap(5),
        Row(
          children: List.generate(3, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: CircleAvatar(
                  backgroundColor:
                      index == 0
                          ? AppColors.primaryColor
                          : index == 1
                          ? AppColors.redColor
                          : AppColors.orangeColor,
                  child:
                      index == selectedColor
                          ? const Icon(Icons.check, color: AppColors.white)
                          : null,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
