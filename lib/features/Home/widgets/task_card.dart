import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color:
            task.isCompleted
                ? AppColors.successColor
                : task.color == 0
                ? AppColors.primaryColor
                : task.color == 1
                ? AppColors.redColor
                : AppColors.orangeColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: AppTextStyles.subtitle(
                    context,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const Gap(5),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: AppColors.white,
                      size: 18,
                    ),
                    const Gap(5),
                    Text(
                      '${task.startDate} - ${task.endDate}',
                      style: AppTextStyles.subtitle(
                        context,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Text(
                  task.description,
                  style: AppTextStyles.subtitle(
                    context,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 50, width: 1, color: AppColors.white),
          const Gap(4),
          // Transform.rotate(
          //   angle: 0.5,
          //   child: Text(
          //     'Status',
          //     style: const TextStyle(color: Colors.grey),
          //   ),
          // ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task.isCompleted ? 'DONE' : 'TODO',
              style: AppTextStyles.caption(context, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
