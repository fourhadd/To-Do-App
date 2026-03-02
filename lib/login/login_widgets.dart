// login/login_widgets.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/l10n/app_localizations.dart';
import 'package:todo/login/login_page.dart';
import 'package:todo/login/register_page.dart';
import 'package:todo/theme/app_color.dart';

class LogRegFooter extends StatelessWidget {
  final bool isRegister;

  const LogRegFooter({super.key, this.isRegister = false});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(color: AppColor.inputBorder, thickness: 1.w),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                t.or,
                style: TextStyle(fontSize: 16.sp, color: AppColor.inputBorder),
              ),
            ),
            Expanded(
              child: Divider(color: AppColor.inputBorder, thickness: 1.w),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Container(
          height: 48.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: AppColor.primaryColor, width: 1.w),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/google_icon.png",
                width: 24.w,
                height: 24.h,
              ),
              SizedBox(width: 10.w),
              Text(
                isRegister ? t.registerWithGoogle : t.loginWithGoogle,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white.withValues(alpha: 0.87),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          height: 48.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: AppColor.primaryColor, width: 1.w),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  color: const Color(0xff283544),
                ),
                child: Icon(Icons.apple, color: Colors.white, size: 20.sp),
              ),
              SizedBox(width: 10.w),
              Text(
                isRegister ? t.registerWithApple : t.loginWithApple,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white.withValues(alpha: 0.87),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 46.h),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => isRegister ? LoginPage() : Register(),
              ),
            );
          },
          child: RichText(
            text: TextSpan(
              text: t.alreadyHaveAccount,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white.withValues(alpha: 0.87),
              ),
              children: [
                TextSpan(
                  text: isRegister ? t.login : t.register,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
