import 'package:flutter/material.dart';

import 'app/app.dart';
import 'modules/modules.dart';
import 'routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yuso Transport',
      home: const SignInScreen(),
      routes: AppRoutes.routes,
      theme: AppTheme.darkMode,
    );
  }
}
