import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/functions/navigator.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/features/addTask/pages/add_task.dart';

class TodayHeader extends StatelessWidget {
  const TodayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMd().format(DateTime.now()),
              style: AppTextStyles.subtitle(
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                fontSize: 20,
              ),
            ),
            Text(
              'Today',
              style: AppTextStyles.subtitle(
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
        MainButton(
          title: '+ Add Task',
          onPressed: () {
            context.push(AddTask());
          },
          width: 150,
        ),
      ],
    );
  }
}
