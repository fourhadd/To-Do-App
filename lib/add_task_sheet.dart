import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/common_widgets.dart';
import 'package:todo/home_page.dart';
import 'package:todo/model_todo.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: const BorderSide(color: Color(0xff979797), width: 1),
  );
  List<TodoItem> preTasks = TodoItem.tasks();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<List<TodoItem>> getTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawData = prefs.getString("tasks");
    final jsonDecodedData = rawData == null ? null : (json.decode(rawData) as List<dynamic>);
    final List<TodoItem> tasks = jsonDecodedData == null
        ? []
        : jsonDecodedData.map((e) => TodoItem.fromJson(e)).toList();

    return tasks;
  }

  Future<void> saveTask(TodoItem todoItem) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final rawData = prefs.getString("tasks");
    final jsonDecodedData = rawData == null ? null : (json.decode(rawData) as List<dynamic>);
    final List<TodoItem> tasks = jsonDecodedData == null
        ? []
        : jsonDecodedData.map((e) => TodoItem.fromJson(e)).toList();

    tasks.add(todoItem);
    final jsonEncodedData = json.encode(tasks.map((e) => e.toJson()).toList());
    log(jsonEncodedData.toString());
    prefs.setString("tasks", jsonEncodedData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 24, right: 24, top: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 15),
              TextField(
                style: const TextStyle(color: Colors.white),
                // autofocus: true,
                decoration: InputDecoration(
                  hintText: "Do math homework",
                  hintStyle: const TextStyle(color: Colors.white54, fontWeight: FontWeight.w400),
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: const TextStyle(color: Colors.white54, fontWeight: FontWeight.w400),
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
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.dark(
                                primary: Color(0xFF8687E7),
                                onPrimary: Colors.white,
                                surface: Color(0xff363636),
                                onSurface: Colors.white,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (pickedDate != null) {
                        setState(() {
                          _dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                        });
                      }
                    },
                  ),

                  SizedBox(width: 20),
                  IconButton(
                    onPressed: () {
                      selectCategory(context, preTasks);
                    },
                    icon: Icon(Icons.sell_outlined, color: Colors.white),
                  ),

                  SizedBox(width: 20),
                  IconButton(
                    onPressed: () {
                      selectPriority(context);
                    },
                    icon: Icon(Icons.flag_outlined, color: Colors.white),
                  ),
                  Spacer(),

                  IconButton(
                    onPressed: () async {
                      await saveTask(
                        TodoItem(
                          id: DateTime.now().millisecondsSinceEpoch,
                          title: "Math Homework",
                          category: "Market",
                          priority: "10",
                          description: "Marketden corek almaq",
                          time: DateTime.now().add(Duration(hours: 2)),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.send_outlined, color: Color(0xFF8687E7), size: 28),
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

  void selectPriority(BuildContext context) {
    int selectedPriority = 1;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              insetPadding: EdgeInsets.all(24),
              backgroundColor: Color(0xff363636),
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(4)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),

                  Center(
                    child: Text(
                      'Task Priority',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 2),

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 1,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [Expanded(child: Divider(color: Color(0xff979797), thickness: 1))],
                          ),
                          SizedBox(height: 22),
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            alignment: WrapAlignment.start,
                            children: List.generate(10, (index) {
                              int currentNum = index + 1;
                              return PriorityContainer(
                                text: currentNum,
                                isSelected: selectedPriority == currentNum,
                                onTap: () {
                                  setDialogState(() {
                                    selectedPriority = currentNum;
                                  });
                                },
                              );
                            }),
                          ),

                          SizedBox(height: 18),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Button(
                              eleBtnTitle: "Save",
                              textBtnTitle: "Cancel",
                              nextPress: () {
                                Navigator.pop(context, selectedPriority);
                              },
                              backPress: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
