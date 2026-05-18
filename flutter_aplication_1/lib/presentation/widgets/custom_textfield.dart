import 'package:flutter/material.dart';

class CustomTextField
    extends StatelessWidget {
  final TextEditingController
      controller;

  final String hintText;

  final String? labelText;

  final IconData? prefixIcon;

  final bool obscureText;

  final int maxLines;

  final TextInputType keyboardType;

  final String? Function(String?)?
      validator;

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
    this.keyboardType =
        TextInputType.text,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      obscureText: obscureText,

      maxLines: maxLines,

      keyboardType: keyboardType,

      validator: validator,

      onTap: onTap,

      readOnly: readOnly,

      decoration: InputDecoration(
        hintText: hintText,

        labelText: labelText,

        prefixIcon:
            prefixIcon != null
                ? Icon(prefixIcon)
                : null,

        suffixIcon: suffixIcon,

        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            12,
          ),
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            12,
          ),

          borderSide:
              BorderSide(
            color:
                Colors.grey.shade300,
          ),
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            12,
          ),

          borderSide:
              const BorderSide(
            color: Colors.blue,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}