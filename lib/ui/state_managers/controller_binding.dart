import 'package:get/get.dart';
import 'package:task_manager/ui/state_managers/email_verification_controller.dart';
import 'package:task_manager/ui/state_managers/login_controller.dart';
import 'package:task_manager/ui/state_managers/summary_count_controller.dart';
import 'package:task_manager/ui/state_managers/task_controller.dart';

import 'add_new_task_controller.dart';

class ControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
    Get.put<EmailVerificationController>(EmailVerificationController());
    Get.put<SummaryCountController>(SummaryCountController());
    Get.put<TaskController>(TaskController());
    Get.put<AddNewTaskController>(AddNewTaskController());
    //Get.put<UpdateProfileController>(UpdateProfileController());
    //Get.put<UpdateTaskStatusController>(UpdateTaskStatusController());
  }
}