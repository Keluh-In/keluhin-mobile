import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/app_colors.dart';
import '../constants/app_status.dart';

class Helper {
  // FORMAT DATE
  static String formatDate(
    dynamic date,
  ) {
    try {
      DateTime parsedDate =
          DateTime.parse(
        date.toString(),
      );

      return DateFormat(
        'dd MMM yyyy',
      ).format(parsedDate);
    } catch (e) {
      return '-';
    }
  }

  // STATUS COLOR
  static Color statusColor(
    String status,
  ) {
    switch (status.toLowerCase()) {
      case AppStatus.menunggu:
        return AppColors.warning;

      case AppStatus.diproses:
        return AppColors.info;

      case AppStatus.selesai:
        return AppColors.success;

      case AppStatus.ditolak:
        return AppColors.danger;

      default:
        return Colors.grey;
    }
  }

  // SUCCESS MESSAGE
  static void successMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(message),

        backgroundColor:
            AppColors.success,
      ),
    );
  }

  // ERROR MESSAGE
  static void errorMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(message),

        backgroundColor:
            AppColors.danger,
      ),
    );
  }

  // LOADING DIALOG
  static void showLoading(
    BuildContext context,
  ) {
    showDialog(
      context: context,

      barrierDismissible: false,

      builder:
          (_) => const Center(
            child:
                CircularProgressIndicator(),
          ),
    );
  }

  // CLOSE DIALOG
  static void closeDialog(
    BuildContext context,
  ) {
    Navigator.pop(context);
  }
}