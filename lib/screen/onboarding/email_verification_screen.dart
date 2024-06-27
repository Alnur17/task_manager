import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
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
                  'Your Email Address ',
                  style: head1Text(colorBlack),
                ),
                const SizedBox(height: 1),
                Text(
                  'A 6 digit verification pin will be send to your email address',
                  style: head6Text(colorBlack),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  decoration: appInputDecoration('Email'),
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
