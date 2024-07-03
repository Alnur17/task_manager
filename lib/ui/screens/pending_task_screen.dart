import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/task_list_title.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class PendingTaskScreen extends StatelessWidget {
  const PendingTaskScreen({super.key});

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
                      return const TaskListTile();
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
