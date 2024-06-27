import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/style/style.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
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
                  'Pin Verification',
                  style: head1Text(colorBlack),
                ),
                const SizedBox(height: 1),
                Text(
                  'A 6 digit verification pin will be send to your email address',
                  style: head6Text(colorBlack),
                ),
                const SizedBox(height: 24),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  pinTheme: appOTPStyle(),
                  animationType: AnimationType.slide,
                  animationDuration: const Duration(milliseconds: 500),
                  enableActiveFill: true,
                  onCompleted: (value) {

                  },
                  onChanged: (value) {

                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () {},
                    style: appButtonStyle(),
                    child: successButtonChild('Verify'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
