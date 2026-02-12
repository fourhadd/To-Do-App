import 'package:flutter/material.dart';
import 'package:todo/common_widgets.dart';
import 'package:todo/model_todo.dart';

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
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Checkbox(
                  shape: CircleBorder(),
                  value: task.isDone,
                  onChanged: (value) {
                    setState(() {
                      task.isDone = value!;
                    });
                  },
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainText(
                        text: task.title,
                        fontSize: 20,
                        color: Colors.white.withValues(alpha: 0.87),
                      ),

                      MainText(
                        text: task.description,
                        fontSize: 16,
                        color: Color(0xffAFAFAF),
                      ),
                    ],
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit, color: Colors.white, size: 25),
                ),
              ),
            ),
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
              trailingIcon: TodoItem.getTaskIcon(task.category),
              trailingIconColor: TodoItem.getIconColor(task.category),
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
      width: MediaQuery.of(context).size.width * 1,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 34.0),
        child: ListTile(
          leading: Icon(leadingIcon, color: Colors.white),
          title: Text(
            titleText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.87),
            ),
          ),
          trailing: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Color(0xff363636),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  trailingIcon != Icons.add
                      ? Row(
                          children: [
                            Icon(trailingIcon, color: trailingIconColor),
                            SizedBox(width: 10),
                            Text(
                              trailingText,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : MainText(text: trailingText, fontSize: 14),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
