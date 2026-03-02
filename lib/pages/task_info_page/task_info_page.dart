// pages/task_info_page/task_info_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/l10n/app_localizations.dart';
import 'package:todo/models/model_todo.dart';
import 'package:todo/pages/task_info_page/task_info_widgets.dart';
import 'package:todo/utils/category_config/category_config.dart';

class TaskInfo extends StatefulWidget {
  final TodoItem task;
  final int index;
  final List<TodoItem> tasks;

  const TaskInfo({
    super.key,
    required this.task,
    required this.index,
    required this.tasks,
  });

  @override
  State<TaskInfo> createState() => _TaskInfoState();
}

class _TaskInfoState extends State<TaskInfo> {
  late TodoItem task;

  @override
  void initState() {
    task = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, toolbarHeight: 1),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: Color(0xff1D1D1D),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: Color(0xff1D1D1D),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Icon(Icons.repeat, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 13.h),
            taskTitle(task: task),
            SizedBox(height: 38.h),
            taskInfo(
              leadingIcon: Icons.timer_outlined,
              titleText: AppLocalizations.of(context)!.taskTimeLabel,
              trailingText: task.formattedDueTime,
            ),
            taskInfo(
              leadingIcon: Icons.sell_outlined,
              titleText: AppLocalizations.of(context)!.taskCategoryLabel,
              trailingText: task.category,
              trailingIcon: CategoryConfig.getIcon(task.category),
              trailingIconColor: CategoryConfig.getIconColor(task.category),
            ),
            taskInfo(
              leadingIcon: Icons.flag_outlined,
              titleText: AppLocalizations.of(context)!.taskPriorityLabel,
              trailingText: task.priority.toString(),
              trailingIcon: Icons.flag_outlined,
              trailingIconColor: Colors.white,
            ),
            taskInfo(
              leadingIcon: Icons.fork_left_outlined,
              titleText: AppLocalizations.of(context)!.taskTimeLabel,
              trailingText: AppLocalizations.of(context)!.addSubTask,
            ),
            TextButton.icon(
              onPressed: () => Navigator.pop(context, true),
              icon: Icon(Icons.delete_outline, color: Colors.red, size: 35.sp),
              label: MainText(
                text: AppLocalizations.of(context)!.deleteTask,
                fontSize: 16.sp,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
