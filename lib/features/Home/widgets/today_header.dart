import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/functions/navigator.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/features/tasks/pages/add_task.dart';

class TodayHeader extends StatelessWidget {
  final String selectedDate;
  const TodayHeader({super.key, required this.selectedDate});

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
                context,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            Text(
              'Today',
              style: AppTextStyles.subtitle(
                context,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: MainButton(
            title: '+ Add Task',
            onPressed: () {
              context.push(AddTask(selectedDate: selectedDate));
            },
          ),
        ),
      ],
    );
  }
}
