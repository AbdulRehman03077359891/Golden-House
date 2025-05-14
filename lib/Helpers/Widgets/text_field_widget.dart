import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatelessWidget {
  final double? width;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final String? hintText, labelText;
  final Widget? suffixIcon, prefixIcon;
  final Color? fillColor,
      labelColor,
      textColor,
      suffixIconColor,
      hintColor,
      cursorColor;
  final Color errorBorderColor, focusBorderColor, borderColor;
  final bool hidePassword;
  final TextInputType? keyboardType;
  final int? lines;
  final double curve;
  final TextCapitalization textCapitalization;
  final Function(String)? change;

  const TextFieldWidget(
      {super.key,
      this.width,
      this.controller,
      this.validate,
      this.hintText,
      this.curve = 0,
      this.prefixIcon,
      this.fillColor = Colors.white,
      required this.focusBorderColor,
      required this.borderColor,
      this.hidePassword = false,
      this.suffixIcon,
      this.errorBorderColor = Colors.red,
      this.suffixIconColor,
      this.keyboardType,
      this.labelText,
      this.labelColor,
      this.lines = 1,
      this.textColor,
      this.textCapitalization = TextCapitalization.none,
      this.hintColor,
      this.change,
      this.cursorColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        onChanged: change,
        textCapitalization: textCapitalization,
        style: TextStyle(color: textColor),
        minLines: lines,
        maxLines: lines,
        keyboardType: keyboardType,
        obscureText: hidePassword,
        controller: controller,
        validator: validate,
        cursorColor: cursorColor,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          labelStyle: TextStyle(color: labelColor),
          labelText: labelText,
          hintText: hintText,
          hintStyle: GoogleFonts.oxygen(
              color: hintColor, fontWeight: FontWeight.w400, fontSize: 14),
          suffixIcon: suffixIcon,
          suffixIconColor: suffixIconColor,
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: fillColor,

          // Always visible border
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(curve),
            borderSide: BorderSide(
              color: borderColor, // This will now always be visible
              width: 1.0,
            ),
          ),

          // Focused border when tapped
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(curve),
            borderSide: BorderSide(
              color: focusBorderColor,
              width: 1.0,
            ),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(curve),
            borderSide: BorderSide(
              color: errorBorderColor,
              width: 1.0,
            ),
          ),

          // Error border (if validation fails)
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(curve),
            borderSide: BorderSide(
              color: errorBorderColor,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
