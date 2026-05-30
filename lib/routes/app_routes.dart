import 'package:flutter/material.dart';

import '../presentation/auth/login_screen.dart';
import '../presentation/auth/register_screen.dart';

import '../presentation/dashboard/dashboard_screen.dart';

import '../presentation/complaints/create_complaint_screen.dart';
import '../presentation/complaints/complaint_list_screen.dart';

import '../presentation/profile/profile_screen.dart';

class AppRoutes {
  // ROUTE NAMES
  static const String login =
      '/login';

  static const String register =
      '/register';

  static const String dashboard =
      '/dashboard';

  static const String complaints =
      '/complaints';

  static const String createComplaint =
      '/create-complaint';

  static const String profile =
      '/profile';

  // ROUTES
  static Map<String, WidgetBuilder>
      routes = {
    login: (context) =>
        const LoginScreen(),

    register: (context) =>
        const RegisterScreen(),

    dashboard: (context) =>
        const DashboardScreen(),

    complaints: (context) =>
        const ComplaintListScreen(),

    createComplaint: (context) =>
        const CreateComplaintScreen(),

    profile: (context) =>
        const ProfileScreen(),
  };
}