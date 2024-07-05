import 'package:flutter/material.dart';
import 'package:task_manager/data/models/auth_utility.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';

class UserProfileBanner extends StatelessWidget {
  const UserProfileBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      tileColor: Colors.blue,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          AuthUtility.userInfo.data?.photo ?? 'Unknown',
        ),
        onBackgroundImageError: (_, __) =>
            const Icon(Icons.person_off_outlined),
      ),
      title: Text(
        '${AuthUtility.userInfo.data?.firstName ?? ''}  ${AuthUtility.userInfo.data?.lastName ?? ''}',
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      subtitle: Text(
        AuthUtility.userInfo.data?.email ?? 'Unknown',
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      trailing: IconButton(
        onPressed: () {
          AuthUtility.clearUserInfo();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        },
        icon: const Icon(Icons.logout_outlined),
      ),
    );
  }
}
