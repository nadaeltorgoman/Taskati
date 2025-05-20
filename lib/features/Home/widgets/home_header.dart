import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${LocalStorage.getData(LocalStorage.name)}',
              style: AppTextStyles.title(color: AppColors.primaryColor),
            ),
            Text(
              'Have a great day!',
              style: AppTextStyles.subtitle(color: AppColors.black),
            ),
          ],
        ),
        CircleAvatar(
          radius: 30,
          backgroundImage:
              LocalStorage.getData(LocalStorage.imagePath) != null
                  ? FileImage(
                    File(LocalStorage.getData(LocalStorage.imagePath)),
                  )
                  : AssetImage(AppImages.user),
        ),
      ],
    );
  }
}
