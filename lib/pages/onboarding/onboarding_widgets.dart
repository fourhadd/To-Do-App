// pages/onboarding/onboarding_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingText extends StatelessWidget {
  final String titleText;
  final String subText;

  const OnboardingText({
    super.key,
    required this.titleText,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            titleText,
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 42.h),
          SizedBox(
            width: 299.w,
            height: 48.h,
            child: Text(
              subText,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingImage extends StatelessWidget {
  final String assetPath;

  const OnboardingImage({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        Center(
          child: Image.asset(
            assetPath,
            width: 213.w,
            height: 278.h, // round 277.78 -> 278
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

class PageIndicator extends StatelessWidget {
  final bool isActive;
  const PageIndicator({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26.28.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: isActive
            ? Colors.white.withValues(alpha: 0.87)
            : Color(0xffAFAFAF),
        borderRadius: BorderRadius.circular(56.r),
      ),
    );
  }
}
