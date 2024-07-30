import 'dart:ui';

import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class TaskStatusController extends GetxController {
  final bool _taskStatusInProgress = false;

  bool get taskStatusInProgress => _taskStatusInProgress;

  Future<void> updateTaskStatus(
      String taskId, String taskStatus, VoidCallback onUpdate) async {
    _taskStatusInProgress == true;
    update();
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatus(taskId, taskStatus));
    _taskStatusInProgress == false;
    update();
    if (response.isSuccess) {
      onUpdate();
      Get.back();
    } else {
      Get.snackbar('Failed', 'Update status has been failed');
    }
  }
}
