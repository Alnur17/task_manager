import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../screens/auth/login_screen.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  bool _setPasswordInProgress = false;

  bool get setPasswordInProgress => _setPasswordInProgress;

  TextEditingController get passwordTEController => _passwordTEController;

  TextEditingController get confirmPasswordTEController =>
      _confirmPasswordTEController;

  Future<void> resetPassword(String email, otp) async {
    _setPasswordInProgress = true;
    update();

    Map<String, dynamic> responseBody = {
      "email": email,
      "OTP": otp,
      "password": _passwordTEController.text,
    };
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.resetPassword, responseBody);
    _setPasswordInProgress = false;
    update();
    if (response.isSuccess) {
      Get.snackbar('Successful', 'Password reset successful');
      Get.offAll(() => LoginScreen());
    } else {
      Get.snackbar('Failed', 'Password reset failed');
    }
  }
}
