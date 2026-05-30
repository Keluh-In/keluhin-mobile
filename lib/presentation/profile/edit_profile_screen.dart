import 'package:flutter/material.dart';

import 'package:flutter_aplication_1/core/constants/app_colors.dart';
import 'package:flutter_aplication_1/core/constants/app_text.dart';
import 'package:flutter_aplication_1/core/utils/helper.dart';

import '../../data/repositories/profile_repository.dart';

class EditProfileScreen
    extends StatefulWidget {
  final Map<String, dynamic> user;

  const EditProfileScreen({
    super.key,
    required this.user,
  });

  @override
  State<EditProfileScreen>
      createState() =>
          _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {
  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool loading = false;

  final ProfileRepository repository =
      ProfileRepository();

  @override
  void initState() {
    super.initState();

    setInitialData();
  }

  void setInitialData() {
    nameController.text =
        widget.user['name'] ?? '';

    emailController.text =
        widget.user['email'] ?? '';
  }

  Future updateProfile() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty) {
      Helper.errorMessage(
        context,
        AppText.requiredField,
      );

      return;
    }

    setState(() {
      loading = true;
    });

    bool success =
        await repository.updateProfile(
      name: nameController.text,
      email: emailController.text,
      password:
          passwordController.text.isEmpty
              ? null
              : passwordController.text,
    );

    setState(() {
      loading = false;
    });

    if (!mounted) return;

    if (success) {
      Helper.successMessage(
        context,
        'Profile berhasil diperbarui',
      );

      Navigator.pop(context, true);
    } else {
      Helper.errorMessage(
        context,
        'Gagal memperbarui profile',
      );
    }
  }

  InputDecoration decoration(
    String label,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,

      prefixIcon: Icon(icon),

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      appBar: AppBar(
        elevation: 0,
        title: const Text(
          AppText.editProfile,
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // PROFILE ICON
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor:
                    AppColors.primary
                        // ignore: deprecated_member_use
                        .withOpacity(0.1),

                child: const Icon(
                  Icons.person,
                  size: 50,
                  color:
                      AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: 35),

            // NAME
            TextField(
              controller:
                  nameController,

              decoration: decoration(
                AppText.fullName,
                Icons.person,
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

              decoration: decoration(
                AppText.email,
                Icons.email,
              ),
            ),

            const SizedBox(height: 20),

            // PASSWORD
            TextField(
              controller:
                  passwordController,

              obscureText: true,

              decoration: decoration(
                'Password Baru (Opsional)',
                Icons.lock,
              ),
            ),

            const SizedBox(height: 35),

            // BUTTON
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
                        : updateProfile,

                child:
                    loading
                        ? const CircularProgressIndicator(
                          color:
                              Colors.white,
                        )
                        : const Text(
                          AppText.update,
                          style:
                              TextStyle(
                            color:
                                Colors
                                    .white,
                            fontSize:
                                16,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}