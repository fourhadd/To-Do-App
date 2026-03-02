// pages/home_page/home_page_widgets.dart
import 'package:flutter/material.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/l10n/app_localizations.dart';
import 'package:todo/models/model_todo.dart';
import 'package:todo/theme/app_color.dart';
import 'package:todo/utils/category_config/category_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class deleteQueryDialog extends StatelessWidget {
  const deleteQueryDialog({super.key, required this.task});

  final TodoItem task;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      insetPadding: EdgeInsets.zero,
      backgroundColor: AppColor.cardColor,
      child: Padding(
        padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 10.h, bottom: 5.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MainText(
              text: AppLocalizations.of(context)!.deleteTask,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 10.h),
            Divider(
              color: Color(0xff979797),
              thickness: 1,
              indent: 8.w,
              endIndent: 8.w,
            ),
            SizedBox(height: 24.h),
            MainText(
              text: AppLocalizations.of(context)!.deleteConfirmation,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
            MainText(
              text:
                  AppLocalizations.of(context)!.deleteConfirmationSub +
                  task.title,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 20.h),
            Button(
              eleBtnTitle: AppLocalizations.of(context)!.deleteTask,
              textBtnTitle: AppLocalizations.of(context)!.cancel,
              nextPress: () {
                Navigator.pop(context, true);
              },
              backPress: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class emptyScreen extends StatelessWidget {
  const emptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/checklist_photo.png",
            width: 227.w,
            height: 227.h,
          ),
          SizedBox(height: 10.h),
          MainText(text: AppLocalizations.of(context)!.emptyStateTitle),
          SizedBox(height: 10.h),
          MainText(
            text: AppLocalizations.of(context)!.emptyStateDesc,
            fontSize: 16.sp,
            color: Colors.white.withOpacity(0.87),
          ),
        ],
      ),
    );
  }
}

class TaskPriorityView extends StatelessWidget {
  const TaskPriorityView({super.key, required this.task});

  final TodoItem task;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.secondaryColor, width: 1.5.w),
        borderRadius: BorderRadius.circular(5.r),
      ),
      padding: EdgeInsets.all(5.w),
      child: Row(
        children: [
          Icon(Icons.flag_outlined, color: Colors.white, size: 16.sp),
          SizedBox(width: 5.w),
          MainText(text: task.priority.toString(), fontSize: 13.sp),
        ],
      ),
    );
  }
}

class TaskCategoryView extends StatelessWidget {
  const TaskCategoryView({super.key, required this.task});

  final TodoItem task;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CategoryConfig.getContainerColor(task.category),
        borderRadius: BorderRadius.circular(5.r),
      ),
      padding: EdgeInsets.all(5.w),
      child: Row(
        children: [
          Icon(
            CategoryConfig.getIcon(task.category),
            color: CategoryConfig.getIconColor(task.category),
            size: 16.sp,
          ),
          SizedBox(width: 5.w),
          MainText(text: task.category, fontSize: 14.sp),
        ],
      ),
    );
  }
}

class navItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const navItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 30.sp),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
