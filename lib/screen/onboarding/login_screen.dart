import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  'Welcome Back',
                  style: head1Text(colorBlack),
                ),
                const SizedBox(height: 1),
                Text(
                  'Please login to continue',
                  style: head6Text(colorBlack),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  decoration: appInputDecoration('Email'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: appInputDecoration('Password'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () {},
                    style: appButtonStyle(),
                    child: successButtonChild('Login'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
