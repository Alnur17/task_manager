import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';



class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          screenBackground(context),
          Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Set Password',
                  style: head1Text(colorWhite),
                ),
                const SizedBox(height: 1),
                Text(
                  'Minimum length password 8 Character with letter and number combination',
                  style: head6Text(colorWhite),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  decoration: appInputDecoration('Password'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: appInputDecoration('Confirm Password'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () {},
                    style: appButtonStyle(),
                    child: successButtonChild('Confirm'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
