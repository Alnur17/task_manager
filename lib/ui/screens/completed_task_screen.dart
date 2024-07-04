import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/task_list_title.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class CompletedTaskScreen extends StatelessWidget {
  const CompletedTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileBanner(),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8,bottom: 8),
                  child: ListView.separated(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const TaskListTile(
                        title: 'This is the new task title',
                        subTitle: 'This is the new task subtitle',
                        date: '25.05.2024',
                        taskStatus: 'Completed',
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
