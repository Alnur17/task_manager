import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/task_list_title.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  TaskListModel _tasksListModel = TaskListModel();
  bool _getCanceledTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        getCanceledTasks();
      },
    );
  }

  Future<void> getCanceledTasks() async {
    _getCanceledTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.cancelledTasks);
    if (response.isSuccess) {
      _tasksListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Canceled tasks failed to load')));
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
            const UserProfileBanner(),
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
