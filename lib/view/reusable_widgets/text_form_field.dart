import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textForm(
    {required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    Widget? suffixIcon,
    required TextInputType keyboardType,
    String? Function(String?)? validator}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    keyboardType: keyboardType,
    obscureText: obscureText,
    decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.all(15.h),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: const BorderSide(color: Colors.white)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.7),
        )),
  );
}
