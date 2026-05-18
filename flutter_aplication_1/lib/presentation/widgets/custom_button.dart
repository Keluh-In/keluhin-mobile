import 'package:flutter/material.dart';

import 'package:flutter_aplication_1/core/constants/app_colors.dart';

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
    this.height = 55,
    this.borderRadius = 12,
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
                    color: Colors.white,
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
                                Colors
                                    .white,
                      ),

                      const SizedBox(
                        width: 8,
                      ),
                    ],

                    Text(
                      text,
                      style: TextStyle(
                        color:
                            textColor ??
                                Colors
                                    .white,

                        fontSize: 16,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}