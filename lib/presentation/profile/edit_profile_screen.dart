import 'package:flutter/material.dart';

import 'package:keluhin_mobile_app/core/constants/app_colors.dart';
import 'package:keluhin_mobile_app/core/constants/app_spacing.dart';
import 'package:keluhin_mobile_app/core/constants/app_text.dart';
import 'package:keluhin_mobile_app/core/utils/helper.dart';

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
    // Border/radius mengikuti inputDecorationTheme (token radius-md).
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
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
            const EdgeInsets.all(AppSpacing.space5),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // PROFILE ICON
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor:
                    AppColors.primary.withValues(alpha: 0.1),

                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.space8),

            // NAME
            TextField(
              controller: nameController,
              decoration: decoration(
                AppText.fullName,
                Icons.person,
              ),
            ),

            const SizedBox(height: AppSpacing.space5),

            // EMAIL
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: decoration(
                AppText.email,
                Icons.email,
              ),
            ),

            const SizedBox(height: AppSpacing.space5),

            // PASSWORD
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: decoration(
                'Password Baru (Opsional)',
                Icons.lock,
              ),
            ),

            const SizedBox(height: AppSpacing.space8),

            // BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : updateProfile,
                child: loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(AppText.update),
              ),
            ),
          ],
        ),
      ),
    );
  }
}