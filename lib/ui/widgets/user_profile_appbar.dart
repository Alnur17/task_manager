import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/auth_utility.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

class UserProfileAppbar extends StatelessWidget {
  final bool? isUpdateScreen;

  const UserProfileAppbar({super.key, this.isUpdateScreen});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.blue,
        title: GestureDetector(
          onTap: () {
            if ((isUpdateScreen ?? false) == false) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpdateProfileScreen(),
                  ));
            }
          },
          child: Row(
            children: [
              Visibility(
                visible: (isUpdateScreen ?? false) == false,
                child: Row(
                  children: [
                    CachedNetworkImage(
                       imageUrl: AuthUtility.userInfo.data?.photo ?? '',
                      placeholder: (_, __) => const Icon(Icons.account_circle_outlined),
                      errorWidget: (_, __, ___) => const Icon(Icons.account_circle_outlined),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AuthUtility.userInfo.data?.firstName ?? ''}  ${AuthUtility.userInfo.data?.lastName ?? ''}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    AuthUtility.userInfo.data?.email ?? 'Unknown',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              AuthUtility.clearUserInfo();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ]);
  }
}
