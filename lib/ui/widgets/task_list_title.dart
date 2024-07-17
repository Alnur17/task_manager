import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/ui/utils/capitalization_utils.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key,
    required this.data,
    required this.onDeleteTap,
    required this.onEditTap,
  });

  final TaskData data;
  final VoidCallback onDeleteTap, onEditTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 12,right: 12),
      title: Text(data.title ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(data.description ?? ''),
          const SizedBox(height: 4),
          Text(data.createdDate ?? ''),
          Row(
            children: [
              Chip(
                label: Text(
                  CapitalizationUtils.capitalize(data.status ?? 'New'),
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: _getStatusColor(data.status),
              ),
              const Spacer(),
              IconButton(
                onPressed: onDeleteTap,
                icon: const Icon(Icons.delete_forever_outlined),
                color: Colors.red.shade300,
              ),
              IconButton(
                  onPressed: onEditTap,
                  icon: const Icon(Icons.edit),
                  color: Colors.blue.shade300),
            ],
          ),
        ],
      ),
    );
  }
  Color _getStatusColor(String? status) {
    switch (status) {
      case 'InProgress':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
