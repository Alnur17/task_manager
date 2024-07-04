import 'package:flutter/material.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key, required this.title, required this.subTitle, required this.date, required this.taskStatus,
  });
  final String title;
  final String subTitle;
  final String date;
  final String taskStatus;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(subTitle),
           Text(date),
          Row(
            children: [
               Chip(
                label: Text(
                  taskStatus,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blue,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete_forever_outlined),
                color: Colors.red.shade300,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  color: Colors.blue.shade300),
            ],
          ),
        ],
      ),
    );
  }
}