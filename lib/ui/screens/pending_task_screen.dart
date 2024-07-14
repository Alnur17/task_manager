import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/ui/widgets/user_profile_appbar.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/task_list_title.dart';

class PendingTaskScreen extends StatefulWidget {
  const PendingTaskScreen({super.key});

  @override
  State<PendingTaskScreen> createState() => _PendingTaskScreenState();
}

class _PendingTaskScreenState extends State<PendingTaskScreen> {
  TaskListModel _tasksListModel = TaskListModel();
  bool _getPendingTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        getPendingTasks();
      },
    );
  }

  Future<void> getPendingTasks() async {
    _getPendingTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.pendingTasks);
    if (response.isSuccess) {
      _tasksListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pending tasks failed to load')));
      }
    }
    _getPendingTaskInProgress = false;
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
              child: _getPendingTaskInProgress
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemCount: _tasksListModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskListTile(
                          data: _tasksListModel.data![index],
                          onDeleteTap: () {},
                          onEditTap: () {},
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
