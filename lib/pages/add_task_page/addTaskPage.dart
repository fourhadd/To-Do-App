// pages/add_task_page/addTaskPage.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/theme/app_color.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/l10n/app_localizations.dart';
import 'package:todo/models/model_todo.dart';
import 'package:todo/pages/add_task_page/add_task_widgets.dart';

class AddtaskPage extends StatefulWidget {
  final List<TodoItem> TodoItems;
  const AddtaskPage({super.key, required this.TodoItems});

  @override
  State<AddtaskPage> createState() => _AddtaskPageState();
}

class _AddtaskPageState extends State<AddtaskPage> {
  void addTask(TodoItem TodoItem) {
    widget.TodoItems.add(TodoItem);
  }

  late final OutlineInputBorder border;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: BorderSide(color: AppColor.inputBorder, width: 1.w),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24.w,
            right: 24.w,
            top: 24.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: AppLocalizations.of(context)!.addTask,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
              ),
              SizedBox(height: 15.h),
              TextField(
                controller: _titleController,
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.taskTitlePlaceholder,
                  hintStyle: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                  enabledBorder: border,
                  focusedBorder: border,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: _descriptionController,
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(
                    context,
                  )!.descriptionPlaceholder,
                  hintStyle: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: border,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              TaskOptionButtons(
                titleController: _titleController,
                descriptionController: _descriptionController,
                onClose: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }
}
