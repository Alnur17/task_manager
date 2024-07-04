import 'package:flutter/material.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/screens/bottom_nav_base_screen.dart';
import 'package:task_manager/ui/screens/auth/email_verification_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

import '../../../data/models/network_response.dart';
import '../../../data/utils/urls.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoginInProgress = false;

  Future<void> userLogIn() async {
    _isLoginInProgress  = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> responseBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,
    };

    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.login, responseBody);
    _isLoginInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavBaseScreen(),
          ),
              (route) => false,
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Incorrect email or password')));
      }
    }
  }

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
                  'Welcome Back',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Please login to continue',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your email...';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your password...';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _isLoginInProgress == false,
                    replacement: const Center(child: CircularProgressIndicator(),),
                    child: ElevatedButton(
                      onPressed: () {
                        if(!_formKey.currentState!.validate()){
                          return;
                        }
                        userLogIn();
                      },
                      child: const Text('Sing In'),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmailVerificationScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            letterSpacing: 0.5,
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Register Now',
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
