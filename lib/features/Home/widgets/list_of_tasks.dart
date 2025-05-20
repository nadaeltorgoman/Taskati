import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

class ListOfTasks extends StatelessWidget {
  const ListOfTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color:
                  index == 0
                      ? AppColors.primaryColor
                      : index == 1
                      ? AppColors.redColor
                      : AppColors.orangeColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Flutter Task - ${index + 1}',
                        style: AppTextStyles.subtitle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                            '09:00 AM - 10:00 AM',
                            style: AppTextStyles.subtitle(color: Colors.white),
                          ),
                        ],
                      ),
                      const Gap(5),
                      Text(
                        'Description of task',
                        style: AppTextStyles.subtitle(color: AppColors.white),
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
                    'TODO',
                    style: AppTextStyles.caption(color: AppColors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
