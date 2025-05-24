import 'package:flutter/material.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

enum DialogType { success, error, warning }

showSnackBar(
  BuildContext context,
  String message, {
  DialogType type = DialogType.error,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: AppTextStyles.body(context)),
      backgroundColor:
          type == DialogType.error
              ? AppColors.redColor
              : (type == DialogType.warning
                  ? AppColors.warningColor
                  : AppColors.successColor),
      duration: Duration(seconds: 2),
    ),
  );
}
