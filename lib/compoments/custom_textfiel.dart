import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? errorText;
  final bool filled;
  final Color fillColor;
  final VoidCallback onSuffixPressed;

  const CustomTextfield({
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    required this.filled,
    required this.fillColor,
    required this.onSuffixPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoTextField(
          prefix: prefixIcon != null
              ? Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Icon(prefixIcon, color: Colors.grey, size: 20),
          )
              : null,
          suffix: suffixIcon != null
              ? Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: onSuffixPressed,
              child: Icon(suffixIcon, color: Colors.grey, size: 20),
            ),
          )
              : null,
          controller: controller,
          placeholder: hintText,
          obscureText: isPassword,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: filled ? fillColor : null,
            border: Border.all(
              color: errorText != null ? Colors.red : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // Affichage du message d'erreur
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 12.0),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}