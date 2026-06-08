import 'package:flutter/material.dart';
import 'package:keluhin_mobile_app/core/constants/app_colors.dart';
import 'package:keluhin_mobile_app/core/constants/app_spacing.dart';
import 'package:keluhin_mobile_app/core/constants/app_text.dart';
import 'package:keluhin_mobile_app/core/constants/app_typography.dart';

import 'package:keluhin_mobile_app/core/utils/helper.dart';

import '../../data/repositories/auth_repository.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  bool loading = false;

  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  final AuthRepository repository =
    AuthRepository();

  Future register() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController
            .text.isEmpty) {
      Helper.errorMessage(
        context,
        AppText.requiredField,
      );

      return;
    }

    if (passwordController.text !=
        confirmPasswordController.text) {
      Helper.errorMessage(
        context,
        'Password tidak sama',
      );

      return;
    }

    setState(() {
      loading = true;
    });

    bool success =
        await repository.register(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      loading = false;
    });

    if (!mounted) return;

    if (success) {
      Helper.successMessage(
        context,
        AppText.successRegister,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const LoginScreen(),
        ),
      );
    } else {
      Helper.errorMessage(
        context,
        AppText.failedRegister,
      );
    }
  }

@override
void dispose() {
  nameController.dispose();
  emailController.dispose();
  passwordController.dispose();
  confirmPasswordController.dispose();
  super.dispose();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor:
        AppColors.background,

      appBar: AppBar(
        elevation: 0,
        title: const Text(
          AppText.register,
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(AppSpacing.space5),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            const SizedBox(height: AppSpacing.space5),

            Text(
              'Buat Akun Baru',
              style: AppTypography.heading2,
            ),

            const SizedBox(height: AppSpacing.space2),

            Text(
              'Daftar untuk mulai membuat pengaduan',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.ink500),
            ),

            const SizedBox(height: AppSpacing.space10),

            // NAME
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: AppText.fullName,
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: AppSpacing.space5),

            // EMAIL
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: AppText.email,
                prefixIcon: Icon(Icons.email),
              ),
            ),

            const SizedBox(height: AppSpacing.space5),

           // PASSWORD
TextField(
  controller: passwordController,
  obscureText: isPasswordHidden,
  decoration: InputDecoration(
    labelText: AppText.password,
    prefixIcon: const Icon(
      Icons.lock,
    ),
    suffixIcon: IconButton(
      icon: Icon(
        isPasswordHidden
            ? Icons.visibility_off
            : Icons.visibility,
      ),
      onPressed: () {
        setState(() {
          isPasswordHidden =
              !isPasswordHidden;
        });
      },
    ),
    border: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(12),
    ),
  ),
),

            const SizedBox(height: AppSpacing.space5),

            // CONFIRM PASSWORD
TextField(
  controller:
      confirmPasswordController,
  obscureText:
      isConfirmPasswordHidden,
  decoration: InputDecoration(
    labelText:
        AppText.confirmPassword,
    prefixIcon: const Icon(
      Icons.lock_outline,
    ),
    suffixIcon: IconButton(
      icon: Icon(
        isConfirmPasswordHidden
            ? Icons.visibility_off
            : Icons.visibility,
      ),
      onPressed: () {
        setState(() {
          isConfirmPasswordHidden =
              !isConfirmPasswordHidden;
        });
      },
    ),
    border: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(12),
    ),
  ),
),

            const SizedBox(height: AppSpacing.space8),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : register,
                child: loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(AppText.register),
              ),
            ),

            const SizedBox(height: AppSpacing.space6),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .center,
              children: [
                const Text(
                  'Sudah punya akun?',
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: const Text(
                    AppText.login,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}