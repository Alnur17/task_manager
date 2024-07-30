import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/screens/update_task_status_sheet_screen.dart';
import 'package:task_manager/ui/state_managers/task_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/user_profile_appbar.dart';

import '../../data/models/task_list_model.dart';
import '../widgets/task_list_title.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  final TaskController _taskController = Get.find<TaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        initializerForCancelledTask();
      },
    );
  }

  void initializerForCancelledTask() {
    _taskController.getTask('Cancelled');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileAppbar(),
            Expanded(
              child: GetBuilder<TaskController>(builder: (_) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: _taskController.getTaskInProgress
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.separated(
                          itemCount:
                              _taskController.tasksListModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskListTile(
                              data: _taskController.tasksListModel.data![index],
                              onDeleteTap: () {
                                _taskController.deleteTask(_taskController
                                    .tasksListModel.data![index].sId!);
                              },
                              onEditTap: () {
                                showStatusUpdateBottomSheet(_taskController
                                    .tasksListModel.data![index]);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              height: 4,
                            );
                          },
                        ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void showStatusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheetScreen(
          task: task,
          onUpdate: () {
            initializerForCancelledTask();
          },
        );
      },
    );
  }
}
