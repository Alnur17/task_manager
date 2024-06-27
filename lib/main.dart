import 'package:flutter/material.dart';
import 'package:task_manager/screen/onboarding/email_verification_screen.dart';
import 'package:task_manager/screen/onboarding/login_screen.dart';
import 'package:task_manager/screen/onboarding/pin_verification_screen.dart';
import 'package:task_manager/screen/onboarding/registration_screen.dart';
import 'package:task_manager/screen/onboarding/set_password_screen.dart';
import 'package:task_manager/screen/onboarding/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/' : (context) => const SplashScreen(),
        '/login' : (context) => const LoginScreen(),
        '/registration' : (context) => const RegistrationScreen(),
        '/emailVerification' : (context) => const EmailVerificationScreen(),
        '/pinVerification' : (context) => const PinVerificationScreen(),
        '/setPassword' : (context) => const SetPasswordScreen(),
      },
    );
  }
}

