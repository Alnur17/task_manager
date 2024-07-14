import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';

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
      title: Text(data.title ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.description ?? ''),
          Text(data.createdDate ?? ''),
          Row(
            children: [
              Chip(
                label: Text(
                  data.status?.toUpperCase() ?? 'new',
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
      case 'inProgress':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
