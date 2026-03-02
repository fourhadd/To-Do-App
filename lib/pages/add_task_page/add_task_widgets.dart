// pages/add_task_page/add_task_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/model_todo.dart';
import 'package:todo/theme/app_color.dart';
import 'package:todo/utils/category_picker/category_picker.dart';
import 'package:todo/utils/date_picker/date_picker.dart';
import 'package:todo/utils/priority_picker/priority_picker.dart';
import 'package:todo/utils/provider.dart';

class TaskOptionButtons extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final VoidCallback onClose;

  const TaskOptionButtons({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    DateTime? _dueTime;
    String? _selectedCategory;
    int? _selectedPriority;

    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.timer_outlined,
                color: Colors.white,
                size: 28.sp,
              ),
              onPressed: () async {
                DateTime? pickedDate = await selectDate(context);
                if (pickedDate != null) {
                  setState(() {
                    _dueTime = pickedDate;
                  });
                }
              },
            ),
            SizedBox(width: 20.w),
            IconButton(
              onPressed: () async {
                final category = await selectCategory(context);
                if (category != null) {
                  setState(() {
                    _selectedCategory = category;
                  });
                }
              },
              icon: Icon(Icons.sell_outlined, color: Colors.white, size: 28.sp),
            ),
            SizedBox(width: 20.w),
            IconButton(
              onPressed: () async {
                final priority = await selectPriority(context);
                if (priority != null) {
                  setState(() {
                    _selectedPriority = priority;
                  });
                }
              },
              icon: Icon(Icons.flag_outlined, color: Colors.white, size: 28.sp),
            ),
            Spacer(),
            IconButton(
              onPressed: () async {
                if (titleController.text.trim().isEmpty) return;

                final newTask = TodoItem(
                  id: DateTime.now().millisecondsSinceEpoch,
                  title: titleController.text,
                  category: _selectedCategory ?? "default",
                  priority: _selectedPriority ?? 1,
                  description: descriptionController.text,
                  time: DateTime.now(),
                  dueTime: _dueTime ?? DateTime.now(),
                  isDone: false,
                );

                await context.read<TodoProvider>().saveTasks(newTask);
                await context.read<TodoProvider>().loadTasksFromPrefs();

                onClose();
              },
              icon: Icon(
                Icons.send_outlined,
                color: AppColor.secondaryColor,
                size: 28.sp,
              ),
            ),
          ],
        );
      },
    );
  }
}
