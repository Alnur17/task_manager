import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/ui/screens/update_task_status_sheet_screen.dart';
import 'package:task_manager/ui/state_managers/summary_count_controller.dart';
import 'package:task_manager/ui/state_managers/task_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/summery_card.dart';
import 'package:task_manager/ui/widgets/task_list_title.dart';
import 'package:task_manager/ui/widgets/user_profile_appbar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final SummaryCountController _summaryCountController =
      Get.find<SummaryCountController>();
  final TaskController _taskController = Get.find<TaskController>();

  @override
  void initState() {
    super.initState();
    //call after widgets binding meaning after life-cycle ends or after build methods run
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        initializerForNewTask();
      },
    );
  }

  void initializerForNewTask() {
    _summaryCountController.getSummaryCount();
    _taskController.getTask('New');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileAppbar(),
            GetBuilder<SummaryCountController>(
              builder: (_) {
                return Visibility(
                  visible: _summaryCountController.getSummaryCountInProgress ==
                      false,
                  replacement: const LinearProgressIndicator(),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _summaryCountController
                                .summaryCountModel.data?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return SummeryCard(
                            number: _summaryCountController
                                    .summaryCountModel.data?[index].sum ??
                                0,
                            title: _summaryCountController
                                    .summaryCountModel.data?[index].sId ??
                                'New',
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: GetBuilder<TaskController>(
                builder: (_) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      initializerForNewTask();
                    },
                    child: _taskController.getTaskInProgress
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.separated(
                            itemCount:
                                _taskController.tasksListModel.data?.length ??
                                    0,
                            itemBuilder: (context, index) {
                              return TaskListTile(
                                data:
                                    _taskController.tasksListModel.data![index],
                                onDeleteTap: () {
                                  _taskController.deleteTask(_taskController
                                      .tasksListModel.data![index].sId!);
                                },
                                onEditTap: () {
                                  showStatusUpdateBottomSheet(
                                    _taskController.tasksListModel.data![index],
                                  );
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                height: 4,
                              );
                            },
                          ),
                  );
                },
              ),
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
            initializerForNewTask();
          },
        );
      },
    );
  }
}
