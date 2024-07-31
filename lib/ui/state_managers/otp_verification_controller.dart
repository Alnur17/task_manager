import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../screens/auth/reset_password_screen.dart';

class OtpVerificationController extends GetxController {
  bool _otpVerificationInProgress = false;
  final TextEditingController _otpTEController = TextEditingController();

  bool get otpVerificationInProgress => _otpVerificationInProgress;

  TextEditingController get otpTEController => _otpTEController;

  Future<void> verifyOtp(String email) async {
    _otpVerificationInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.verifyOtp(
        email,
        _otpTEController.text,
      ),
    );
    _otpVerificationInProgress = false;
    update();
    if (response.isSuccess) {
      Get.offAll(
        () => ResetPasswordScreen(
          email: email,
          otp: _otpTEController.text,
        ),
      );
    } else {
      Get.snackbar('Failed', 'Otp verification failed');
    }
  }
}
