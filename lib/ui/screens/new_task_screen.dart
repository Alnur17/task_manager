import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/summery_card.dart';
import 'package:task_manager/ui/widgets/task_list_title.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileBanner(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: SummeryCard(
                    number: 123,
                    title: 'New',
                  )),
                  Expanded(
                      child: SummeryCard(
                    number: 456,
                    title: 'Pending',
                  )),
                  Expanded(
                      child: SummeryCard(
                    number: 789,
                    title: 'Canceled',
                  )),
                  Expanded(
                      child: SummeryCard(
                    number: 101,
                    title: 'Completed',
                  )),
                ],
              ),
            ),
            Expanded(
                child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const TaskListTile(title: 'This is the new task title', subTitle: 'This is the new task subtitle', date: '25.05.2024', taskStatus: 'New',);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 4,
                );
              },
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
