import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  int selectedColor = 0;

  @override
  void initState() {
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    startTimeController.text = DateFormat('hh:mm a').format(DateTime.now());
    endTimeController.text = DateFormat(
      'hh:mm a',
    ).format(DateTime.now().add(const Duration(hours: 1)));
    super.initState();
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
        title: const Text('Add Task'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MainButton(title: 'Create Task', onPressed: () {}, width: 160),
      ),
    );
  }

  Column title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Title',
          style: AppTextStyles.subtitle(
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        const Gap(5),
        TextFormField(
          controller: titleController,
          decoration: const InputDecoration(hintText: 'Enter title'),
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
          style: AppTextStyles.subtitle(
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        const Gap(5),
        TextFormField(
          controller: descriptionController,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Enter description'),
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
          style: AppTextStyles.subtitle(
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
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
      initialDate: DateTime.now(),
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
            style: AppTextStyles.subtitle(
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          const Gap(5),
          TextFormField(
            readOnly: true,
            onTap: () async {
              var pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
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
            style: AppTextStyles.subtitle(
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          const Gap(5),
          TextFormField(
            readOnly: true,
            onTap: () async {
              var pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
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
          style: AppTextStyles.subtitle(
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
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
                          ? AppColors.orangeColor
                          : AppColors.redColor,
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
