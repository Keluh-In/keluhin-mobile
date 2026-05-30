import 'package:flutter/material.dart';
import 'package:keluhin_mobile_app/core/constants/app_colors.dart';
import 'package:keluhin_mobile_app/core/constants/app_text.dart';

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
            const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 20),

            const Text(
              'Buat Akun Baru',
              style: TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Daftar untuk mulai membuat pengaduan',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 40),

            // NAME
            TextField(
              controller:
                  nameController,
              decoration:
                  InputDecoration(
                labelText:
                    AppText.fullName,
                prefixIcon:
                    const Icon(
                  Icons.person,
                ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // EMAIL
            TextField(
              controller:
                  emailController,
              keyboardType:
                  TextInputType
                      .emailAddress,
              decoration:
                  InputDecoration(
                labelText:
                    AppText.email,
                prefixIcon:
                    const Icon(
                  Icons.email,
                ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // PASSWORD
            TextField(
              controller:
                  passwordController,
              obscureText: true,
              decoration:
                  InputDecoration(
                labelText:
                    AppText.password,
                prefixIcon:
                    const Icon(
                  Icons.lock,
                ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // CONFIRM PASSWORD
            TextField(
              controller:
                  confirmPasswordController,
              obscureText: true,
              decoration:
                  InputDecoration(
                labelText: AppText
                    .confirmPassword,
                prefixIcon:
                    const Icon(
                  Icons.lock_outline,
                ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.primary,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
                onPressed:
                    loading
                        ? null
                        : register,
                child:
                    loading
                        ? const CircularProgressIndicator(
                          color:
                              Colors.white,
                        )
                        : const Text(
                          AppText.register,
                          style:
                              TextStyle(
                            fontSize:
                                16,
                            color:
                                Colors
                                    .white,
                          ),
                        ),
              ),
            ),

            const SizedBox(height: 25),

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