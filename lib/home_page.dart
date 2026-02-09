import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:todo/addTaskPage.dart';

import 'package:todo/model_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoItem> TodoItems = [];
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
              builder: (context) => AddtaskPage(TodoItems: TodoItems),
            );
            setState(() {});
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
              child: TodoItems.isEmpty
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
                          Text(
                            'What do you want to do today?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Tap + to add your tasks',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(top: 80),
                      itemCount: TodoItems.length,
                      itemBuilder: (context, index) {
                        final task = TodoItems[index];
                        String timeText = "";

                        DateTime now = DateTime.now();
                        if (task.time.year == now.year &&
                            task.time.month == now.month &&
                            task.time.day == now.day) {
                          timeText =
                              "Today ${task.time.hour}:${task.time.minute.toString().padLeft(2, '0')}";
                        } else {
                          timeText =
                              "${task.time.day}/${task.time.month} ${task.time.hour}:${task.time.minute.toString().padLeft(2, '0')}";
                        }
                        IconData taskIcon(String category) {
                          const icons = {
                            'Grocery': FontAwesomeIcons.breadSlice,
                            'Work': Icons.work_outline,
                            'Sport': Icons.fitness_center_outlined,
                            'Design': Icons.brush_outlined,
                            'University': Icons.school_outlined,
                            'Social': Icons.people_outline,
                            'Music': Icons.music_note_outlined,
                            'Health': Icons.favorite_outline,
                            'Movie': Icons.movie_outlined,
                            'Home': Icons.home_outlined,
                            'Create New': Icons.add_circle_outline,
                          };

                          return icons[category] ?? Icons.category_outlined;
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff363636),
                            ),
                            width: MediaQuery.of(context).size.width * 1,
                            height: 72,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      task.dueTime.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffAFAFAF),
                                      ),
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
                                                taskIcon(task.category),
                                                color: TodoItem.getIconColor(
                                                  task.category,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                task.category,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
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

                                              Text(
                                                task.priority.toString(),
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                ),
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
                  Text(
                    'Index',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
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
