import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/ui/state_managers/profile_controller.dart';
import 'package:task_manager/ui/utils/auth_utility.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/user_profile_appbar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  UserData userData = AuthUtility.userInfo.data!;
  final ProfileController _profileController = Get.put(ProfileController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? imageFile;
  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _profileController.emailTEController.text = userData.email ?? '';
    _profileController.firstNameTEController.text = userData.firstName ?? '';
    _profileController.lastNameTEController.text = userData.lastName ?? '';
    _profileController.mobileTEController.text = userData.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const UserProfileAppbar(
                isUpdateScreen: true,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: GetBuilder<ProfileController>(builder: (_) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Update Profile',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            selectImage();
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8)),
                                  ),
                                  child: const Text(
                                    'Photo',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Visibility(
                                  visible: imageFile != null,
                                  child: Text(
                                    imageFile?.name ?? 'Image not selected',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _profileController.emailTEController,
                          keyboardType: TextInputType.emailAddress,
                          readOnly: true,
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined)),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your email...';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _profileController.firstNameTEController,
                          decoration: const InputDecoration(
                            hintText: 'First Name',
                            prefixIcon: Icon(Icons.drive_file_rename_outline),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your first name...';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _profileController.lastNameTEController,
                          decoration: const InputDecoration(
                            hintText: 'Last Name',
                            prefixIcon: Icon(Icons.drive_file_rename_outline),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your last name...';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _profileController.mobileTEController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: 'Mobile',
                            prefixIcon: Icon(Icons.phone),
                          ),
                          validator: (value) {
                            if ((value?.isEmpty ?? true) ||
                                value!.length < 11) {
                              return 'Please enter your valid mobile...';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _profileController.passwordTEController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          validator: (value) {
                            if ((value?.isEmpty ?? true) ||
                                value!.length <= 5) {
                              return 'Please enter your password more than 6 letters...';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible:
                                _profileController.updateProfileInProgress ==
                                    false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                _profileController.updateProfile(userData);
                              },
                              child: const Text('Update'),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectImage() {
    picker.pickImage(source: ImageSource.gallery).then(
      (xFile) {
        if (xFile != null) {
          imageFile = xFile;
          if (mounted) {
            setState(() {});
          }
        }
      },
    );

    // ImagePicker.platform.getImageFromSource(source: ImageSource.gallery).then(
    //   (xFile) {
    //     if (xFile != null) {
    //       imageFile = xFile;
    //       if(mounted){
    //       setState(() {});
    //       }
    //     }
    //   },
    // );
  }
}
