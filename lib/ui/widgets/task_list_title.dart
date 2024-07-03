import 'package:flutter/material.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Title here'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Subtitle here'),
          const Text('Date'),
          Row(
            children: [
              const Chip(
                label: Text(
                  'New',
                  style: TextStyle(color: Colors.white),
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