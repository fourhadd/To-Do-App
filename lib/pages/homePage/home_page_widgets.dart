import 'package:flutter/material.dart';
import 'package:todo/common_widgets.dart';
import 'package:todo/models/model_todo.dart';
import 'package:todo/theme/app_color.dart';
import 'package:todo/utils/category_config/category_config.dart';

class deleteQueryDialog extends StatelessWidget {
  const deleteQueryDialog({super.key, required this.task});

  final TodoItem task;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(4),
      ),
      insetPadding: EdgeInsets.zero,
      backgroundColor: AppColor.cardColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 5),
        child: Container(
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainText(
                text: "Delete Task",
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 10),
              Divider(
                color: Color(0xff979797),
                thickness: 1,
                indent: 8,
                endIndent: 8,
              ),
              SizedBox(height: 24),
              MainText(
                text: "Are You sure you want to delete this task?",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              MainText(
                text: "Task title: " + task.title,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 20),
              Button(
                eleBtnTitle: "Delete",
                textBtnTitle: "Cancel",
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
            width: 227,
            height: 227,
          ),
          SizedBox(height: 10),
          MainText(text: 'What do you want to do today?'),
          SizedBox(height: 10),
          MainText(
            text: 'Tap + to add your tasks',
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.87),
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
        border: Border.all(color: AppColor.secondaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Icon(Icons.flag_outlined, color: Colors.white),
          SizedBox(width: 5),
          MainText(text: task.priority.toString(), fontSize: 13),
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
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Icon(
            CategoryConfig.getIcon(task.category),
            color: CategoryConfig.getIconColor(task.category),
          ),
          SizedBox(width: 5),
          MainText(text: task.category, fontSize: 14),
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
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
