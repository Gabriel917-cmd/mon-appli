import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  const CustomTextfield({

    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      prefix: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey,size: 15,):null,
      suffix: suffixIcon != null ? Icon(suffixIcon, color: Colors.grey,size: 15,):null,
      controller: controller,
      placeholder: hintText,
      obscureText: isPassword,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}