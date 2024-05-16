import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget reusedButton(
    {required String child,
    required Color backGroundColor,
    IconData? iconData,
    required double width,
    required Widget widget,
    required double fontSize,
    required Color fontColor,
    required Color borderColor,
    required double radius,
    required void Function() onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 45.h,
      alignment: Alignment.center,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backGroundColor,
          border: Border.all(width: 2, color: borderColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget,
          Text(
            child,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                color: fontColor),
          ),
        ],
      ),
    ),
  );
}
