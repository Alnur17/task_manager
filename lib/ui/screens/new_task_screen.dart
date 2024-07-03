import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/summery_card.dart';
import 'package:task_manager/ui/widgets/task_list_title.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              tileColor: Colors.blue,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
              ),
              title: Text('User Name',style: TextStyle(color: Colors.white,fontSize: 14),),
              subtitle: Text('email address',style: TextStyle(color: Colors.white,fontSize: 12),),
            ),
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
                return const TaskListTile();
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
    );
  }
}
