import 'package:get/get.dart';
import 'package:task_manager/ui/state_managers/email_verification_controller.dart';
import 'package:task_manager/ui/state_managers/login_controller.dart';
import 'package:task_manager/ui/state_managers/otp_verification_controller.dart';
import 'package:task_manager/ui/state_managers/profile_controller.dart';
import 'package:task_manager/ui/state_managers/registration_controller.dart';
import 'package:task_manager/ui/state_managers/reset_password_controller.dart';
import 'package:task_manager/ui/state_managers/summary_count_controller.dart';
import 'package:task_manager/ui/state_managers/task_controller.dart';
import 'package:task_manager/ui/state_managers/task_status_controller.dart';

import 'add_new_task_controller.dart';

class ControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
    Get.put<RegistrationController>(RegistrationController());
    Get.put<OtpVerificationController>(OtpVerificationController());
    Get.put<ResetPasswordController>(ResetPasswordController());
    Get.put<EmailVerificationController>(EmailVerificationController());
    Get.put<SummaryCountController>(SummaryCountController());
    Get.put<TaskController>(TaskController());
    Get.put<AddNewTaskController>(AddNewTaskController());
    Get.put<ProfileController>(ProfileController());
    Get.put<TaskStatusController>(TaskStatusController());
  }
}