import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/summary_count_model.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/screens/update_task_status_sheet_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/summery_card.dart';
import 'package:task_manager/ui/widgets/task_list_title.dart';
import 'package:task_manager/ui/widgets/user_profile_appbar.dart';

import '../../data/utils/urls.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  TaskListModel _tasksListModel = TaskListModel();
  bool _getSummaryCountInProgress = false, _getNewTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    //call after widgets binding meaning after life-cycle ends or after build methods run
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        getSummaryCount();
        getNewTasks();
      },
    );
  }

  Future<void> getSummaryCount() async {
    _getSummaryCountInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Summary data failed to load')));
      }
    }
    _getSummaryCountInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getNewTasks() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newTasks);
    if (response.isSuccess) {
      _tasksListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('New tasks failed to load')));
      }
    }
    _getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteTasks(taskId));
    if (response.isSuccess) {
      _tasksListModel.data!.removeWhere(
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
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileAppbar(),
            _getSummaryCountInProgress
                ? const LinearProgressIndicator()
                : Container(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _summaryCountModel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return SummeryCard(
                            number: _summaryCountModel.data?[index].sum ?? 0,
                            title: _summaryCountModel.data?[index].sId ?? 'New',
                          );
                        },
                      ),
                    ),
                  ),
            Expanded(
                child: RefreshIndicator(
              onRefresh: () async {
                getNewTasks();
                getSummaryCount();
              },
              child: _getNewTaskInProgress
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemCount: _tasksListModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskListTile(
                          data: _tasksListModel.data![index],
                          onDeleteTap: () {
                            deleteTask(_tasksListModel.data![index].sId!);
                          },
                          onEditTap: () {
                            showStatusUpdateBottomSheet(
                                _tasksListModel.data![index]);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 4,
                        );
                      },
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
            getNewTasks();
          },
        );
      },
    );
  }
}
