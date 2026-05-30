import 'package:flutter/material.dart';

import 'package:keluhin_mobile_app/core/constants/app_colors.dart';
import 'package:keluhin_mobile_app/core/constants/app_text.dart';
import 'package:keluhin_mobile_app/core/utils/helper.dart';
import '../../core/utils/storage.dart';

import '../../data/repositories/profile_repository.dart';

import '../auth/login_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {
  final ProfileRepository repository =
      ProfileRepository();

  Map<String, dynamic>? user;

  bool loading = true;

  @override
  void initState() {
    super.initState();

    getProfile();
  }

  Future getProfile() async {
    try {
      final data =
          await repository.getProfile();

      setState(() {
        user = data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });

      if (!mounted) return;

      Helper.errorMessage(
        context,
        'Gagal mengambil profile',
      );
    }
  }

  Future logout() async {
    try {
      await Storage.logout();

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder:
              (_) => const LoginScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      Helper.errorMessage(
        context,
        'Logout gagal',
      );
    }
  }

  Widget buildMenu({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Card(
      elevation: 1,

      margin: const EdgeInsets.only(
        bottom: 14,
      ),

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              (color ??
                      AppColors.primary)
                  // ignore: deprecated_member_use
                  .withOpacity(0.1),

          child: Icon(
            icon,
            color:
                color ??
                AppColors.primary,
          ),
        ),

        title: Text(title),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),

        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor:
          AppColors.background,

      appBar: AppBar(
        elevation: 0,
        title: const Text(
          AppText.profile,
        ),
      ),

      body: RefreshIndicator(
        onRefresh: () => getProfile(),

        child: SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(),

          padding:
              const EdgeInsets.all(20),

          child: Column(
            children: [
              // PROFILE CARD
              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(
                  24,
                ),

                decoration: BoxDecoration(
                  color:
                      AppColors.primary,

                  borderRadius:
                      BorderRadius.circular(
                    22,
                  ),
                ),

                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor:
                          Colors.white,

                      child: Icon(
                        Icons.person,
                        size: 50,
                        color:
                            AppColors
                                .primary,
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    Text(
                      user?['name'] ??
                          '-',
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontSize: 22,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      user?['email'] ??
                          '-',
                      style:
                          const TextStyle(
                        color:
                            Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // MENU
              buildMenu(
                icon: Icons.edit,
                title:
                    AppText.editProfile,

                onTap: () async {
                  final result =
                      await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) =>
                              EditProfileScreen(
                        user: user!,
                      ),
                    ),
                  );

                  if (result == true) {
                    getProfile();
                  }
                },
              ),

              buildMenu(
                icon: Icons.lock,
                title:
                    'Keamanan Akun',

                onTap: () {
                  Helper.successMessage(
                    context,
                    'Fitur segera hadir',
                  );
                },
              ),

              buildMenu(
                icon: Icons.info,
                title: 'Tentang Aplikasi',

                onTap: () {
                  showAboutDialog(
                    context: context,

                    applicationName:
                        AppText.appName,

                    applicationVersion:
                        '1.0.0',

                    children: const [
                      Text(
                        'Aplikasi pengaduan mahasiswa berbasis mobile.',
                      ),
                    ],
                  );
                },
              ),

              buildMenu(
                icon: Icons.logout,
                title: AppText.logout,
                color: Colors.red,

                onTap: logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}