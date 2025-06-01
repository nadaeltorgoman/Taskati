import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/features/Home/widgets/home_header.dart';
import 'package:taskati/features/Home/widgets/list_of_tasks.dart';
import 'package:taskati/features/Home/widgets/today_header.dart';
import 'package:taskati/features/profile/pages/edit_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfile()),
                  );
                  if (result == true) {
                    setState(() {});
                  }
                },
                child: HomeHeader(),
              ),
              SizedBox(height: 15),
              TodayHeader(selectedDate: selectedDate),
              SizedBox(height: 15),
              DatePicker(
                height: 100,
                width: 60,
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                monthTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                dayTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                dateTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                selectionColor: AppColors.primaryColor,
                selectedTextColor: AppColors.white,
                onDateChange: (date) {
                  setState(() {
                    selectedDate = DateFormat('yyyy-MM-dd').format(date);
                  });
                },
              ),
              Gap(20),
              ListOfTasks(selectedDate: selectedDate),
            ],
          ),
        ),
      ),
    );
  }
}
