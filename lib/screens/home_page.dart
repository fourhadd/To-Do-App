import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/addTaskPage.dart';
import 'package:todo/common_widgets.dart';
import 'package:todo/model_todo.dart';
import 'package:todo/screens/task_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoItem> todos = TodoItem.tasks();
  List<TodoItem> tasks = [];
  @override
  void initState() {
    loadTasksFromPrefs();
    super.initState();
  }

  Future<void> loadTasksFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final rawData = prefs.getString("tasks");
    final jsonDecodedData = rawData == null
        ? null
        : json.decode(rawData) as List<dynamic>;
    final List<TodoItem> tasks = jsonDecodedData == null
        ? []
        : jsonDecodedData.map((e) => TodoItem.fromJson(e)).toList();

    setState(() {
      this.tasks = tasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, toolbarHeight: 1),
      backgroundColor: Colors.black,
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        color: const Color(0xff363636),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(icon: Icons.home_outlined, label: "Home"),
            navItem(icon: Icons.calendar_month_outlined, label: "Calendar"),
            navItem(icon: Icons.person_outline_outlined, label: "Profile"),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          onPressed: () async {
            await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Color(0xff363636),
              context: context,
              builder: (context) => AddtaskPage(TodoItems: todos),
            );
            setState(() {});
            await loadTasksFromPrefs();
          },
          backgroundColor: Color(0xff8687E7),
          shape: CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: tasks.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              "assets/images/checklist_photo.png",
                              width: 227,
                              height: 227,
                            ),
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
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(top: 80),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 16,
                            left: 24,
                            right: 24,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              final delete = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TaskInfo(
                                    task: task,
                                    index: index,
                                    tasks: tasks,
                                  ),
                                ),
                              );
                              if (delete == true) {
                                setState(() {
                                  tasks.removeAt(index);
                                });
                                final prefs =
                                    await SharedPreferences.getInstance();
                                final String encodedData = json.encode(
                                  tasks.map((e) => e.toJson()).toList(),
                                );
                                await prefs.setString("tasks", encodedData);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff363636),
                              ),
                              width: MediaQuery.of(context).size.width * 1,
                              height: 72,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        shape: CircleBorder(),
                                        value: task.isDone,
                                        onChanged: (value) {
                                          setState(() {
                                            task.isDone = value!;
                                          });
                                        },
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MainText(
                                            text: task.title,
                                            fontSize: 16,
                                          ),
                                          SizedBox(height: 6),
                                          MainText(
                                            text: task.formattedDueTime,
                                            fontSize: 14,
                                            color: Colors.white.withValues(
                                              alpha: 0.87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: TodoItem.getContainerColor(
                                              task.category,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  TodoItem.getTaskIcon(
                                                    task.category,
                                                  ),
                                                  color: TodoItem.getIconColor(
                                                    task.category,
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                MainText(
                                                  text: task.category,
                                                  fontSize: 14,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(0xff8687E7),
                                              width: 1.5,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.flag_outlined,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(width: 5),
                                                MainText(
                                                  text: task.priority
                                                      .toString(),
                                                  fontSize: 13,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Positioned(
              top: 10,
              left: 24,
              right: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {},
                  ),
                  MainText(text: "Index", fontSize: 20),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
