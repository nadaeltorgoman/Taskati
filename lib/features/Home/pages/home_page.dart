import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
              // Gap(15),
              SizedBox(height: 15),
              TodayHeader(),
              // Gap(15)
              SizedBox(height: 15),
              DatePicker(
                height: 100,
                width: 70,
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColors.primaryColor,
                selectedTextColor: AppColors.white,
                deactivatedColor: AppColors.black,
                onDateChange: (date) {
                  // Handle date change
                },
              ),
              Gap(20),
              // SizedBox(height: 20),
              ListOfTasks(),
            ],
          ),
        ),
      ),
    );
  }
}
