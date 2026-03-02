// pages/profile_page/profile_page_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/l10n/app_localizations.dart';
import 'package:todo/theme/app_color.dart';

class TaskFilterButton extends StatelessWidget {
  final bool isDoneOrLeft;

  const TaskFilterButton({super.key, this.isDoneOrLeft = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58.h,
      width: 180.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(4.r),
          ),
          backgroundColor: AppColor.cardColor,
        ),
        onPressed: () {},
        child: MainText(
          text: isDoneOrLeft
              ? "10 " + AppLocalizations.of(context)!.taskLeft
              : "10 " + AppLocalizations.of(context)!.taskDone,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}

class profileItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const profileItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.only(bottom: 8.h, top: 0, right: 0, left: 0),
        leading: Icon(icon, color: AppColor.textColor, size: 24.sp),
        title: MainText(text: label, fontSize: 18.sp),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColor.textColor,
          size: 20.sp,
        ),
      ),
    );
  }
}
