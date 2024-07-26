import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/state_managers/email_verification_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //bool _emailVerificationInProgress = false;
  final TextEditingController _emailTEController = TextEditingController();

  // Future<void> sentOtpToEmail() async {
  //   _emailVerificationInProgress = true;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   final NetworkResponse response = await NetworkCaller().getRequest(
  //     Urls.sentOtpToEmail(
  //       _emailTEController.text.trim(),
  //     ),
  //   );
  //   _emailVerificationInProgress = false;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   if (response.isSuccess) {
  //     if (mounted) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => OtpVerificationScreen(
  //             email: _emailTEController.text.trim(),
  //           ),
  //         ),
  //       );
  //     } else {
  //       if (mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text('Email verification failed'),
  //           ),
  //         );
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Email Address ',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 1),
                Text(
                  'A 6 digit verification pin will be send to your email address',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your password...';
                    }
                    return null;
                  },
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<EmailVerificationController>(
                    builder: (emailVerification) {
                      return Visibility(
                        visible: emailVerification.emailVerificationInProgress == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            emailVerification.sentOtpToEmail(_emailTEController.text.trim());
                          },
                          child: const Text('Send'),
                        ),
                      );
                    }
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an account?',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            letterSpacing: 0.5,
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Sign In',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
