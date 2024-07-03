import 'package:flutter/material.dart';

class UserProfileBanner extends StatelessWidget {
  const UserProfileBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 16),
      tileColor: Colors.blue,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
      ),
      title: Text('User Name',style: TextStyle(color: Colors.white,fontSize: 14),),
      subtitle: Text('email address',style: TextStyle(color: Colors.white,fontSize: 12),),
    );
  }
}