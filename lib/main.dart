import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/storage.dart';

import 'presentation/auth/login_screen.dart';
import 'presentation/dashboard/dashboard_screen.dart';

import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final token =
      await Storage.getToken();

  runApp(
    MyApp(
      token: token,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({
    super.key,
    this.token,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KELUH.IN',

      debugShowCheckedModeBanner:
          false,

      theme: AppTheme.lightTheme,

      routes: AppRoutes.routes,

      home:
          token != null
              ? const DashboardScreen()
              : const LoginScreen(),
    );
  }
}