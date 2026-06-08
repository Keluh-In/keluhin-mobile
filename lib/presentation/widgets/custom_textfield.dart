import 'package:flutter/material.dart';

import 'package:keluhin_mobile_app/core/constants/app_colors.dart';
import 'package:keluhin_mobile_app/core/constants/app_spacing.dart';
import 'package:keluhin_mobile_app/core/constants/app_typography.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  final String hintText;

  final String? labelText;

  final IconData? prefixIcon;

  final bool obscureText;

  final int maxLines;

  final TextInputType keyboardType;

  final String? Function(String?)? validator;

  final VoidCallback? onTap;

  final bool readOnly;

  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final field = TextFormField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      onTap: onTap,
      readOnly: readOnly,
      style: AppTypography.body,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppColors.ink400)
            : null,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space4,
          vertical: AppSpacing.space3,
        ),
        // Border/focus/error mengikuti inputDecorationTheme (token).
      ),
    );

    if (labelText == null) return field;

    // Label di atas field — 14px / 600 / ink-800 (design system).
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText!,
          style: AppTypography.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.ink800,
          ),
        ),
        const SizedBox(height: AppSpacing.space2),
        field,
      ],
    );
  }
}
