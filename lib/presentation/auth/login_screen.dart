import 'package:flutter/material.dart';
import 'package:keluhin_mobile_app/core/constants/app_colors.dart';
import 'package:keluhin_mobile_app/core/constants/app_spacing.dart';
import 'package:keluhin_mobile_app/core/constants/app_text.dart';
import 'package:keluhin_mobile_app/core/constants/app_typography.dart';
import 'package:keluhin_mobile_app/core/utils/helper.dart';

import '../../data/repositories/auth_repository.dart';

import 'register_screen.dart';
import '../dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  final AuthRepository repository = AuthRepository();

  Future login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Helper.errorMessage(context, AppText.requiredField);
      return;
    }

    setState(() {
      loading = true;
    });

    bool success = await repository.login(
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      loading = false;
    });

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        ),
      );
    } else {
      Helper.errorMessage(context, AppText.failedLogin);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        title: const Text(AppText.login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.space5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Wordmark logo — pengecualian Bold (700).
            Text(
              'KELUH.IN',
              style: AppTypography.heading1.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.space8),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: AppSpacing.space4),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: AppSpacing.space6),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : login,
                child: loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('LOGIN'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisterScreen(),
                  ),
                );
              },
              child: const Text(AppText.register),
            ),
          ],
        ),
      ),
    );
  }
}