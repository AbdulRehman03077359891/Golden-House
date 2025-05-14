
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class E1Button extends StatelessWidget {
  final Gradient gradient;
  final Color textColor;
  final String text;
  final double size;
  final VoidCallback? onPressed;
  final Color? shadowColor;
  final double elevation;

  const E1Button({
    super.key,
    required this.gradient, // Replaced backColor with gradient
    required this.text,
    required this.textColor,
    this.onPressed,
    this.shadowColor,
    this.size = 16.0,
    this.elevation = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: gradient, // Apply the gradient
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          if (shadowColor != null)
            BoxShadow(
              color: shadowColor!,
              blurRadius: elevation,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          backgroundColor: Colors.transparent, // Make button transparent
          shadowColor: Colors.transparent, // Disable native shadow
          elevation: 0, // Remove default elevation
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Text(
            text,
            style: GoogleFonts.oxygen(
              color: onPressed == null ? Colors.grey : textColor,
              fontSize: size,
              fontWeight: FontWeight.w400
            ),
          ),
        ),
      ),
    );
  }
}
