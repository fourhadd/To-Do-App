import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/pages/add_task/addTaskPage.dart';
import 'package:todo/common_widgets.dart';
import 'package:todo/pages/homePage/home_page_widgets.dart';
import 'package:todo/pages/profile_info_page.dart';
import 'package:todo/pages/task_info/task_info_page.dart';
import 'package:todo/theme/app_color.dart';
import 'package:todo/utils/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TodoProvider>().loadTasksFromPrefs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();
    final tasks = provider.tasks;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        actionsPadding: EdgeInsets.symmetric(horizontal: 24),
        leadingWidth: 80,
        backgroundColor: Colors.black,
        title: MainText(text: "Index", fontSize: 20),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileInfo()),
            );
          },
          iconSize: 30,
          color: Colors.white.withValues(alpha: 0.87),
        ),
        actions: [
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
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        color: AppColor.cardColor,
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
              backgroundColor: AppColor.cardColor,
              context: context,
              builder: (context) => AddtaskPage(TodoItems: provider.todos),
            );
          },
          backgroundColor: AppColor.secondaryColor,
          shape: CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
      body: SafeArea(
        child: tasks.isEmpty
            ? emptyScreen()
            : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 16),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
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
                          final confirmDelete = await showDialog<bool>(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),
                              child: deleteQueryDialog(task: task),
                            ),
                          );
                          if (confirmDelete == true) {
                            await context.read<TodoProvider>().deleteTask(task);
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.cardColor,
                        ),
                        height: 72,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  shape: CircleBorder(),
                                  value: task.isDone,
                                  onChanged: (value) {
                                    context.read<TodoProvider>().toggleTask(
                                      task.id,
                                      value!,
                                    );
                                  },
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MainText(text: task.title, fontSize: 16),
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
                            Row(
                              children: [
                                TaskCategoryView(task: task),
                                SizedBox(width: 16),
                                TaskPriorityView(task: task),
                                SizedBox(width: 10),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
