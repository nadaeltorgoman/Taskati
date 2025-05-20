import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/navigator.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? pathImage;
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (pathImage != null) {
              LocalStorage.saveData(LocalStorage.imagePath, pathImage!);
            }
            Navigator.of(context).pop(true);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.light_mode),
            onPressed: () {
              // Handle the done action
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
                          child:
                              LocalStorage.getData(LocalStorage.imagePath) !=
                                      null
                                  ? Image.file(
                                    File(
                                      LocalStorage.getData(
                                        LocalStorage.imagePath,
                                      ),
                                    ),
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  )
                                  : Image.asset(
                                    AppImages
                                        .user, // This should be a String path
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
                          color: AppColors.white,
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
              Row(
                children: [
                  Text(
                    LocalStorage.getData(LocalStorage.name) ?? 'User Name',
                    style: AppTextStyles.subtitle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 22,
                    child: CircleAvatar(
                      backgroundColor: AppColors.white,
                      radius: 20,

                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          ShowUpBottomSheetEditText(context);
                        },
                      ),
                    ),
                  ),
                ],
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
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Upload Image',
                style: AppTextStyles.title(fontWeight: FontWeight.w400),
              ),
              MainButton(
                title: 'Upload from Camera',
                onPressed: onPressedCamera,
              ),
              const Gap(5),
              MainButton(
                title: 'Upload from Gallery',
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
          LocalStorage.saveData(LocalStorage.imagePath, pathImage!);
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
          LocalStorage.saveData(LocalStorage.imagePath, pathImage!);
        });
        context.pop();
      }
    });
  }

  ShowUpBottomSheetEditText(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Name',
                style: AppTextStyles.title(fontWeight: FontWeight.w400),
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Enter name'),
              ),
              const Gap(10),
              MainButton(
                title: 'Update Your Name',
                onPressed: () {
                  LocalStorage.saveData(LocalStorage.name, nameController.text);
                  context.pop();
                  setState(() {
                    nameController.text = '';
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
