import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/user_profile_appbar.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/task_list_title.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  TaskListModel _tasksListModel = TaskListModel();
  bool _getCanceledTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        getCompletedTasks();
      },
    );
  }

  Future<void> getCompletedTasks() async {
    _getCanceledTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.completedTasks);
    if (response.isSuccess) {
      _tasksListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Completed tasks failed to load')));
      }
    }
    _getCanceledTaskInProgress = false;
    if (mounted) {
      setState(() {});
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
              child: _getCanceledTaskInProgress
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemCount: _tasksListModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskListTile(
                          data: _tasksListModel.data![index], onDeleteTap: () {  }, onEditTap: () {  },
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
}
