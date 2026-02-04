import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:todo/common_widgets.dart';
import 'package:todo/model_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> todos = Todo.tasks();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Color(0xff979797), width: 1),
    );
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
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Color(0xff363636),
              builder: (BuildContext context) {
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
                                icon: Icon(
                                  Icons.timer_outlined,
                                  color: Colors.white,
                                ),
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
                                      _dateController.text =
                                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                    });
                                  }
                                },
                              ),

                              SizedBox(width: 20),
                              IconButton(
                                onPressed: () {
                                  selectCategory(context, todos);
                                },
                                icon: Icon(
                                  Icons.sell_outlined,
                                  color: Colors.white,
                                ),
                              ),

                              SizedBox(width: 20),
                              IconButton(
                                onPressed: () {
                                  selectPriority(context);
                                },
                                icon: Icon(
                                  Icons.flag_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(),

                              Icon(
                                Icons.send_outlined,
                                color: Color(0xFF8687E7),
                                size: 28,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                );
              },
            );
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
              child: todos.isEmpty
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
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final task = todos[index];
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          timeText,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffAFAFAF),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 14,
                                    top: 23,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Todo.getContainerColor(
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
                                                color: Todo.getIconColor(
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
                                      SizedBox(width: 10),
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
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.flag_outlined,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 5),

                                              Text(
                                                task.priority,
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

Future<void> selectCategory(BuildContext context, List<Todo> tasks) async {
  final List<String> categories = [
    'Grocery',
    'Work',
    'Sport',
    'Design',
    'University',
    'Social',
    'Music',
    'Health',
    'Movie',
    'Home',
    'Create New',
  ];
  String? selectedCategory = await showDialog<String>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 24),
            backgroundColor: Color(0xff363636),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(4),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Choose Category",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Color(0xff979797),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 49,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final String category = categories[index];

                          return GestureDetector(
                            onTap: () => Navigator.pop(context, category),
                            child: Column(
                              children: [
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: Todo.getContainerColor(category),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Todo.getTaskIcon(category),
                                      color: Todo.getIconColor(category),
                                      size: 35,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  category,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30),

                    MainBtn(
                      title: "Add Category",
                      isActive: true,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(4),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),

                Center(
                  child: Text(
                    'Task Priority',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 2),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Color(0xff979797),
                                thickness: 1,
                              ),
                            ),
                          ],
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
                              ;
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
