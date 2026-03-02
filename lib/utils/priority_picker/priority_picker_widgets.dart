// utils/priority_picker/priority_picker_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/theme/app_color.dart';

class PriorityContainer extends StatelessWidget {
  final int text;
  final bool isSelected;
  final VoidCallback onTap;

  const PriorityContainer({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64.w,
        height: 64.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.secondaryColor : Color(0xff272727),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flag_outlined, color: Colors.white, size: 24.sp),
            SizedBox(height: 4.h),
            Text(
              text.toString(),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.87),
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
