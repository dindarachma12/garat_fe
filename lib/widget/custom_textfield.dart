import 'package:flutter/material.dart';
import 'package:flutter_tm/widget/styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    required this.textInputAction,
    required this.textInputType,
    required this.hint,
    this.isObscure = false,
    this.hasSuffix = false,
    this.onPressed,
    super.key,
  });

  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String hint;
  final bool isObscure;
  final bool hasSuffix;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyles.body.copyWith(color: Colors.black),
      keyboardType: textInputType,
      textInputAction: textInputAction,
      obscureText: isObscure,
      decoration: InputDecoration(
        suffixIcon: hasSuffix
            ? IconButton(
                onPressed: onPressed,
                icon: Icon(
                  isObscure ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: AppColors.red,
            ),
            borderRadius: BorderRadius.circular(10.0)),
        hintText: hint,
        hintStyle: TextStyles.light,
      ),
    );
  }
}
