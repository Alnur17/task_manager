import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class AddNewTaskController extends GetxController{
  bool _addNewTaskInProgress = false;

  bool get addNewTaskInProgress => _addNewTaskInProgress;

  Future<void> addNewTask(String title, String description) async {
    _addNewTaskInProgress = true;
    update();

    Map<String, dynamic> responseBody = {
      "title": title,
      "description": description,
      "status": "New"
    };

    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.createTask, responseBody);
    _addNewTaskInProgress = false;
    update();
    if (response.isSuccess) {
      Get.snackbar('Success', 'Task added successfully');
    } else {
      Get.snackbar('Failed', 'Fail to add task! try again.');
    }
  }
}