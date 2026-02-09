import 'package:flutter/material.dart';
import 'package:todo/model_todo.dart';
import 'package:todo/picker_functions.dart';

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
  String? _selectedCategory;
  int? _selectedPriority;
  DateTime? _dueTime;

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
              Text(
                "Add Task",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white),
                // autofocus: true,
                decoration: InputDecoration(
                  hintText: "Do math homework",
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
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: const TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: border,
                ),
              ),
              SizedBox(height: 20),

              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.timer_outlined, color: Colors.white),
                    onPressed: () async {
                      DateTime? pickedDate = await selectDate(context);

                      if (pickedDate != null) {
                        setState(() {
                          _dueTime = pickedDate;
                        });
                      }
                    },
                  ),

                  SizedBox(width: 20),
                  IconButton(
                    onPressed: () async {
                      _selectedCategory = await selectCategory(context);
                    },
                    icon: Icon(Icons.sell_outlined, color: Colors.white),
                  ),

                  SizedBox(width: 20),
                  IconButton(
                    onPressed: () async {
                      _selectedPriority = await selectPriority(context);
                    },
                    icon: Icon(Icons.flag_outlined, color: Colors.white),
                  ),
                  Spacer(),

                  IconButton(
                    onPressed: () async {
                      if (_titleController.text.trim().isEmpty) return;
                      final newTask = TodoItem(
                        id: DateTime.now().millisecondsSinceEpoch,
                        title: _titleController.text,
                        category: _selectedCategory ?? "work",
                        priority: _selectedPriority ?? 1,
                        description: _descriptionController.text,
                        time: DateTime.now(),
                        dueTime: _dueTime ?? DateTime.now(),
                      );
                      widget.TodoItems.add(newTask);

                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.send_outlined,
                      color: Color(0xFF8687E7),
                      size: 28,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
