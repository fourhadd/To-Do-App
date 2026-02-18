import 'package:flutter/material.dart';
import 'package:todo/common_widgets.dart';
import 'package:todo/models/model_todo.dart';
import 'package:todo/pages/task_info/task_info_widgets.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Color(0xff1D1D1D),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Color(0xff1D1D1D),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(Icons.repeat, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 13),
            taskTitle(task: task),
            SizedBox(height: 38),
            taskInfo(
              leadingIcon: Icons.timer_outlined,
              titleText: 'Task Time :',
              trailingText: task.formattedDueTime,
            ),
            taskInfo(
              leadingIcon: Icons.sell_outlined,
              titleText: 'Task Category :',
              trailingText: task.category,
              trailingIcon: CategoryConfig.getIcon(task.category),
              trailingIconColor: CategoryConfig.getIconColor(task.category),
            ),
            taskInfo(
              leadingIcon: Icons.flag_outlined,
              titleText: 'Task Priority :',
              trailingText: task.priority.toString(),
              trailingIcon: Icons.flag_outlined,
              trailingIconColor: Colors.white,
            ),
            taskInfo(
              leadingIcon: Icons.fork_left_outlined,
              titleText: 'Task Date :',
              trailingText: "Add Sub-Task",
            ),

            TextButton.icon(
              onPressed: () async {
                Navigator.pop(context, true);
              },
              icon: Icon(Icons.delete_outline, color: Colors.red, size: 35),
              label: MainText(
                text: "Delete Task",
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
