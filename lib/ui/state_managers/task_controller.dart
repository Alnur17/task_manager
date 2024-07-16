import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class TaskController extends GetxController {
  TaskListModel _tasksListModel = TaskListModel();
  bool _getTaskInProgress = false;

  bool get getTaskInProgress => _getTaskInProgress;
  TaskListModel get tasksListModel => _tasksListModel;

  Future<bool> getTask(String taskName) async {
    _getTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.tasks(taskName));
    _getTaskInProgress = false;
    if (response.isSuccess) {
      _tasksListModel = TaskListModel.fromJson(response.body!);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
