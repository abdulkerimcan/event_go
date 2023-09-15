import 'package:eventgo/core/init/cache/local_manager.dart';
import 'package:eventgo/core/init/theme/app_theme.dart';
import 'package:eventgo/features/auth/login/view/login_view.dart';
import 'package:eventgo/features/edit_profile/view/edit_profile_view.dart';
import 'package:eventgo/features/tabs/tabbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  _init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalManager.preferencesInit();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: const EditProfileView(),
    );
  }
}
