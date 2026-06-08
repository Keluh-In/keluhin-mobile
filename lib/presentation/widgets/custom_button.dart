import 'package:flutter/material.dart';

import 'package:keluhin_mobile_app/core/constants/app_colors.dart';
import 'package:keluhin_mobile_app/core/constants/app_radius.dart';
import 'package:keluhin_mobile_app/core/constants/app_spacing.dart';
import 'package:keluhin_mobile_app/core/constants/app_typography.dart';

class CustomButton extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  final bool loading;

  final Color? backgroundColor;

  final Color? textColor;

  final double height;

  final double borderRadius;

  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
    this.backgroundColor,
    this.textColor,
    this.height = 52,
    this.borderRadius = AppRadius.md,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundColor ??
                  AppColors.primary,

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              borderRadius,
            ),
          ),

          elevation: 0,
        ),

        onPressed:
            loading
                ? null
                : onPressed,

        child:
            loading
                ? const SizedBox(
                  width: 22,
                  height: 22,
                  child:
                      CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.white,
                  ),
                )
                : Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,

                  children: [
                    if (icon != null) ...[
                      Icon(
                        icon,
                        color:
                            textColor ??
                                AppColors.white,
                      ),

                      const SizedBox(
                        width: AppSpacing.space2,
                      ),
                    ],

                    Text(
                      text,
                      style: AppTypography.button.copyWith(
                        color:
                            textColor ??
                                AppColors.white,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}