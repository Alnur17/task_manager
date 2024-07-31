import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class RegistrationController extends GetxController {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  bool _isSignUpProgress = false;

  bool get isSignUpProgress => _isSignUpProgress;
  TextEditingController get emailTEController => _emailTEController;
  TextEditingController get firstNameTEController => _firstNameTEController;
  TextEditingController get lastNameTEController => _lastNameTEController;
  TextEditingController get mobileTEController => _mobileTEController;
  TextEditingController get passwordTEController => _passwordTEController;

  Future<void> userSignUp() async {
    _isSignUpProgress = true;
    update();

    Map<String, dynamic> responseBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text,
      "photo": "",
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registration, responseBody);
    _isSignUpProgress = false;
    update();
    if (response.isSuccess) {
      _emailTEController.clear();
      _firstNameTEController.clear();
      _lastNameTEController.clear();
      _mobileTEController.clear();
      _passwordTEController.clear();
      Get.snackbar('Success', 'Registration success');
    } else {
      Get.snackbar('Failed', 'Registration failed');
    }
  }
}
