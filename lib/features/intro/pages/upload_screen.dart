import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/navigator.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/dialog.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/features/Home/pages/home_page.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? pathImage;
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text(
              'Done',
              style: AppTextStyles.subtitle(context),
            ),
            onPressed: () {
              if (pathImage != null && nameController.text.isNotEmpty) {
                LocalStorage.saveData(LocalStorage.name, nameController.text);
                LocalStorage.saveData(LocalStorage.imagePath, pathImage!);
                context.pushReplacement(const HomePage());

                showSnackBar(
                  context,
                  'Profile updated successfully',
                  type: DialogType.success,
                );
              } else if (pathImage == null && nameController.text.isNotEmpty) {
                showSnackBar(context, 'Please select an image');
              } else if (pathImage != null && nameController.text.isEmpty) {
                showSnackBar(context, 'Please enter your name');
              } else {
                showSnackBar(
                  context,
                  'Please select an image and enter your name',
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showUpBottomSheet(context);
                },
                child: Stack(
                  children: [
                    pathImage != null
                        ? ClipOval(
                          child: Image.file(
                            File(pathImage ?? ''),
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                        : ClipOval(
                          child: Image.asset(
                            AppImages.user,
                            width: 200,
                            height: 200,
                            color: AppColors.primaryColor,
                            colorBlendMode: BlendMode.multiply,
                          ),
                        ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: AppColors.primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(20),
              Divider(height: 1, color: AppColors.lightGray),
              Gap(20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Enter your name'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showUpBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Upload Image',
                style: AppTextStyles.title(context, fontWeight: FontWeight.w400),
              ),
              MainButton(title: 'Take a Photo', onPressed: onPressedCamera),
              const Gap(5),
              MainButton(
                title: 'Choose from Gallery',
                onPressed: onPressedGallery,
              ),
            ],
          ),
        );
      },
    );
  }

  onPressedCamera() {
    Navigator.pop(context);
    ImagePicker imagePicker = ImagePicker();
    imagePicker.pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        // Handle the selected image
        setState(() {
          pathImage = value.path;
          context.pop();
        });
      }
    });
  }

  onPressedGallery() async {
    ImagePicker imagePicker = ImagePicker();
    await imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        // Handle the selected image
        setState(() {
          pathImage = value.path;
        });
        context.pop();
      }
    });
  }
}
