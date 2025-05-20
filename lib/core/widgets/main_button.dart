import 'package:flutter/material.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

class MainButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final double? width;
  final double? height;
  const MainButton({super.key, required this.title, required this.onPressed, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: AppColors.primaryColor,
        ),
        child: Text(
          title,
          style: AppTextStyles.subtitle(color: AppColors.white),
        ),
      ),
    );
  }
}
