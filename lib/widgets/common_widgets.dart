// widgets/common_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:todo/theme/app_color.dart';

class MainBtn extends StatelessWidget {
  final String title;

  final VoidCallback? onPressed;
  const MainBtn({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 62.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String titleText;
  final String hintText;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;

  const InputField({
    super.key,
    required this.titleText,
    required this.hintText,
    this.isPassword = false,
    this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: const BorderSide(color: Color(0xff979797), width: 0.8),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.87),
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 1.sw,
          height: 50.h,
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            obscureText: isPassword,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: border,
              enabledBorder: border,
              focusedBorder: border,
              disabledBorder: border,
              fillColor: const Color(0xff1D1D1D),
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: isPassword ? 20.sp : 16.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xff535353),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  final String textBtnTitle;
  final String eleBtnTitle;
  final VoidCallback nextPress;
  final VoidCallback backPress;

  const Button({
    super.key,
    required this.eleBtnTitle,
    required this.textBtnTitle,
    required this.nextPress,
    required this.backPress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: backPress,
          child: Text(
            textBtnTitle.toUpperCase(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.44),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: nextPress,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          child: Text(
            eleBtnTitle.toUpperCase(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class MainText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const MainText({
    super.key,
    this.text = 'Index',
    this.color = Colors.white,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
      ),
    );
  }
}
