import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class UpdateTaskStatusSheetScreen extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;

  const UpdateTaskStatusSheetScreen(
      {super.key, required this.task, required this.onUpdate});

  @override
  State<UpdateTaskStatusSheetScreen> createState() =>
      _UpdateTaskStatusSheetScreenState();
}

class _UpdateTaskStatusSheetScreenState
    extends State<UpdateTaskStatusSheetScreen> {
  List<String> taskStatusList = ['New', 'InProgress', 'Cancelled', 'Completed'];
  late String _selectedTask;
  final bool _updateTaskStatus = false;

  @override
  void initState() {
    super.initState();
    _selectedTask = widget.task.status!;
  }

  Future<void> updateTask(String taskId, taskStatus) async {
    _updateTaskStatus == true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.updateTasks(taskId, taskStatus));
    _updateTaskStatus == false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      widget.onUpdate();
      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Update status has been failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Update Status',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskStatusList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    _selectedTask = taskStatusList[index];
                    setState(() {});
                  },
                  title: Text(taskStatusList[index]),
                  trailing: _selectedTask == taskStatusList[index]
                      ? const Icon(Icons.check)
                      : null,
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Visibility(
              visible: _updateTaskStatus == false,
              replacement: const Center(child: CircularProgressIndicator()),
              child: ElevatedButton(
                onPressed: () {
                  updateTask(widget.task.sId!, _selectedTask);
                },
                child: const Text('Update'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
