import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/dialog.dart';
import 'package:taskati/features/Home/widgets/task_card.dart';

class ListOfTasks extends StatelessWidget {
  final String selectedDate;
  const ListOfTasks({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: LocalStorage.taskBox.listenable(),
        builder: (context, box, child) {
          List<TaskModel> tasks = [];
          for (var task in box.values) {
            if (selectedDate == task.date) {
              tasks.add(task);
            }
          }
          if (tasks.isEmpty) {
            return Center(
              child: Lottie.asset('assets/images/empty.json', width: 400),
            );
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                background:
                    tasks[index].isCompleted
                        ? unCompletedTask(context)
                        : completeTask(context),
                secondaryBackground: deleteTask(context),
                onDismissed: (direction) {
                  // Immediately remove from local list to prevent the error
                  final dismissedTask = tasks[index];

                  if (direction == DismissDirection.startToEnd) {
                    // Mark as done or uncompleted
                    if (dismissedTask.isCompleted) {
                      box.put(
                        dismissedTask.id,
                        dismissedTask.copyWith(isCompleted: false),
                      );
                      showSnackBar(
                        context,
                        'Task marked as uncompleted',
                        type: DialogType.success,
                      );
                    } else {
                      box.put(
                        dismissedTask.id,
                        dismissedTask.copyWith(isCompleted: true),
                      );
                      showSnackBar(
                        context,
                        'Task marked as completed',
                        type: DialogType.success,
                      );
                    }
                  } else if (direction == DismissDirection.endToStart) {
                    // Delete task
                    box.delete(dismissedTask.id);
                    showSnackBar(
                      context,
                      'Task deleted successfully',
                      type: DialogType.success,
                    );
                  }
                },
                child: TaskCard(task: tasks[index]),
              );
            },
          );
        },
      ),
    );
  }

  Container deleteTask(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(right: 10),
      color: AppColors.errorColor,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.delete),
          Gap(10),
          Text('Delete', style: AppTextStyles.subtitle(context)),
        ],
      ),
    );
  }

  Container completeTask(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 10),
      color: AppColors.successColor,
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.check),
          Gap(10),
          Text('Mark as done', style: AppTextStyles.subtitle(context)),
        ],
      ),
    );
  }

  Container unCompletedTask(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 10),
      color: AppColors.primaryColor,
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.close),
          Gap(10),
          Text('Mark as uncompleted', style: AppTextStyles.subtitle(context)),
        ],
      ),
    );
  }
}
