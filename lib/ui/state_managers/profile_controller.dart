import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/login_model.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../utils/auth_utility.dart';

class ProfileController extends GetxController {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _updateProfileInProgress = false;

  bool get updateProfileInProgress => _updateProfileInProgress;

  TextEditingController get emailTEController => _emailTEController;

  TextEditingController get firstNameTEController => _firstNameTEController;

  TextEditingController get lastNameTEController => _lastNameTEController;

  TextEditingController get mobileTEController => _mobileTEController;

  TextEditingController get passwordTEController => _passwordTEController;

  Future<void> updateProfile(UserData userData) async {
    _updateProfileInProgress == true;
    update();

    Map<String, dynamic> responseBody = {
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "photo": '',
    };
    if (_passwordTEController.text.isNotEmpty) {
      responseBody["password"] = _passwordTEController.text;
    }

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.profileUpdate, responseBody);
    _updateProfileInProgress = false;
    update();
    if (response.isSuccess) {
      userData.firstName = _firstNameTEController.text.trim();
      userData.lastName = _lastNameTEController.text.trim();
      userData.mobile = _mobileTEController.text.trim();
      AuthUtility.updateUserInfo(userData);
      _passwordTEController.clear();
      Get.snackbar('Success', 'Profile updated successfully');
    } else {
      Get.snackbar('Failed', 'Failed to update profile');
    }
  }
}
