import 'dart:ui';

import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class UpdateTaskStatusController extends GetxController {
  bool _updateTaskStatusInProgress = false;

  bool get updateTaskStatusInProgress => _updateTaskStatusInProgress;

  Future<void> updateTaskStatus(
      String taskId, String taskStatus, VoidCallback onUpdate) async {
    _updateTaskStatusInProgress == true;
    update();
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatus(taskId, taskStatus));
    _updateTaskStatusInProgress == false;
    update();
    if (response.isSuccess) {
      onUpdate();
      Get.back();
    } else {
      Get.snackbar('Failed', 'Update status has been failed');
    }
  }
}
