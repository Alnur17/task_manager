import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/screens/update_task_status_sheet_screen.dart';
import 'package:task_manager/ui/widgets/user_profile_appbar.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../state_managers/task_controller.dart';
import '../widgets/task_list_title.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final TaskController _taskController = Get.find<TaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        initializerForCompletedTask();
      },
    );
  }

  void initializerForCompletedTask() {
    _taskController.getTask('Completed');
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteTasks(taskId));
    if (response.isSuccess) {
      _taskController.tasksListModel.data!.removeWhere(
        (element) => element.sId == taskId,
      );
      if (mounted) {
        setState(() {});
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Deletion of task has been failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileAppbar(),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: GetBuilder<TaskController>(
                builder: (_) {
                  return _taskController.getTaskInProgress
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.separated(
                          itemCount: _taskController.tasksListModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskListTile(
                              data: _taskController.tasksListModel.data![index],
                              onDeleteTap: () {
                                deleteTask(_taskController.tasksListModel.data![index].sId!);
                              },
                              onEditTap: () {
                                showStatusUpdateBottomSheet(
                                    _taskController.tasksListModel.data![index]);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              height: 4,
                            );
                          },
                        );
                }
              ),
            )),
          ],
        ),
      ),
    );
  }

  void showStatusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheetScreen(
          task: task,
          onUpdate: () {
            initializerForCompletedTask();
          },
        );
      },
    );
  }
}
