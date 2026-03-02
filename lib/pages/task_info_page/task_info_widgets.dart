// pages/task_info_page/task_info_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/models/model_todo.dart';
import 'package:todo/theme/app_color.dart';

class taskInfo extends StatelessWidget {
  final IconData leadingIcon;
  final String titleText;
  final Widget? trailing;
  final IconData trailingIcon;
  final Color trailingIconColor;
  final String trailingText;

  taskInfo({
    super.key,
    required this.leadingIcon,
    required this.titleText,
    this.trailing,
    this.trailingIcon = Icons.add,
    this.trailingIconColor = Colors.black,
    required this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: Padding(
        padding: EdgeInsets.only(bottom: 34.h),
        child: ListTile(
          leading: Icon(leadingIcon, color: Colors.white),
          title: Text(
            titleText,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.87),
            ),
          ),
          trailing: Container(
            height: 45.h,
            decoration: BoxDecoration(
              color: AppColor.cardColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  trailingIcon != Icons.add
                      ? Row(
                          children: [
                            Icon(trailingIcon, color: trailingIconColor),
                            SizedBox(width: 10.w),
                            Text(
                              trailingText,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : MainText(text: trailingText, fontSize: 14.sp),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class taskTitle extends StatelessWidget {
  const taskTitle({super.key, required this.task});

  final TodoItem task;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Checkbox(
          shape: CircleBorder(),
          value: task.isDone,
          onChanged: (value) {},
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: task.title,
                fontSize: 20.sp,
                color: Colors.white.withValues(alpha: 0.87),
              ),
              MainText(
                text: task.description,
                fontSize: 16.sp,
                color: Color(0xffAFAFAF),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.edit, color: Colors.white, size: 25.sp),
        ),
      ),
    );
  }
}
