import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/auth/otp_verification_screen.dart';

class EmailVerificationController extends GetxController {
  bool _emailVerificationInProgress = false;

  bool get emailVerificationInProgress => _emailVerificationInProgress;

  Future<void> sentOtpToEmail(String email) async {
    _emailVerificationInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.sentOtpToEmail(
        email,
      ),
    );
    _emailVerificationInProgress = false;
    update();
    if (response.isSuccess) {
      Get.to(
        () => OtpVerificationScreen(
          email: email,
        ),
      );
    } else {
      Get.snackbar('Failed', 'Email verification failed');
    }
  }
}
