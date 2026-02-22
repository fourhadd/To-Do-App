// pages/add_task_page/addTaskPage.dart
import 'package:flutter/material.dart';
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

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: const BorderSide(color: Color(0xff979797), width: 1),
  );

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: AppLocalizations.of(context)!.addTask,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 15),
              TextField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white),
                // autofocus: true,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.taskTitlePlaceholder,
                  hintStyle: const TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(
                    context,
                  )!.descriptionPlaceholder,
                  hintStyle: const TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: border,
                ),
              ),
              SizedBox(height: 20),

              TaskOptionButtons(
                titleController: _titleController,
                descriptionController: _descriptionController,
                onClose: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
