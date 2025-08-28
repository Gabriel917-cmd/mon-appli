import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String text;
  final bool isLoading;
  final VoidCallback onPressed;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    super.key, required Color backgroundColor, required Color textColor, required int height, required int borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 100),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,),
        )
            : Text(text, style: const TextStyle(fontWeight: FontWeight.bold),)
    );
  }
}