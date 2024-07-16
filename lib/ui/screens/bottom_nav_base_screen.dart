import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/canceled_task_screen.dart';
import 'package:task_manager/ui/screens/completed_task_screen.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';
import 'package:task_manager/ui/screens/in_progress_task_screen.dart';

import '../widgets/bottom_nav_item.dart';
import 'add_new_task_screen.dart';

class BottomNavBaseScreen extends StatefulWidget {
  const BottomNavBaseScreen({super.key});

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {
  int _selectedScreenIndex = 0;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    InProgressTaskScreen(),
    CanceledTaskScreen(),
    CompletedTaskScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(
              icon: Icons.note_outlined,
              label: '   New   ', // space are given intentional
              isSelected: _selectedScreenIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            BottomNavItem(
              icon: Icons.pending_outlined,
              label: 'In Progress',
              isSelected: _selectedScreenIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            //const SizedBox(width: 16),
            const Spacer(
              flex: 4,
            ),
            BottomNavItem(
              icon: Icons.cancel_outlined,
              label: 'Cancelled',
              isSelected: _selectedScreenIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            // const SizedBox(width: 16),
            BottomNavItem(
              icon: Icons.done,
              label: 'Completed',
              isSelected: _selectedScreenIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
