import 'package:eventgo/core/theme/app_theme.dart';
import 'package:eventgo/features/login/view/login_view.dart';
import 'package:eventgo/features/register/view/register_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: const RegisterView(),
    );
  }
}
