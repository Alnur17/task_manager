import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/ui/state_managers/task_status_controller.dart';

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
  final List<String> _taskStatusList = [
    'New',
    'InProgress',
    'Cancelled',
    'Completed'
  ];
  late String _selectedTask;
  final TaskStatusController _taskStatusController =
      Get.put(TaskStatusController());

  @override
  void initState() {
    super.initState();
    _selectedTask = widget.task.status!;
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
              itemCount: _taskStatusList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    _selectedTask = _taskStatusList[index];
                    setState(() {});
                  },
                  title: Text(_taskStatusList[index]),
                  trailing: _selectedTask == _taskStatusList[index]
                      ? const Icon(Icons.check)
                      : null,
                );
              },
            ),
          ),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: GetBuilder<TaskStatusController>(builder: (_) {
                return Visibility(
                  visible:
                      _taskStatusController.taskStatusInProgress ==
                          false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: ElevatedButton(
                    onPressed: () {
                      _taskStatusController.updateTaskStatus(
                          widget.task.sId!, _selectedTask, widget.onUpdate);
                    },
                    child: const Text('Update'),
                  ),
                );
              })),
        ],
      ),
    );
  }
}
