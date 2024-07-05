import 'package:flutter/material.dart';
import 'package:task_manager/data/models/auth_utility.dart';

class UserProfileBanner extends StatelessWidget {
  const UserProfileBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      tileColor: Colors.blue,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          AuthUtility.userInfo.data?.photo ?? 'Unknown',),
        onBackgroundImageError: (_, __) => const Icon(Icons.person_off_outlined),
      ),
      title: Text(
        '${AuthUtility.userInfo.data?.firstName ?? ''}  ${AuthUtility.userInfo.data?.lastName}',
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      subtitle:  Text(
        AuthUtility.userInfo.data?.email ?? 'Unknown',
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
