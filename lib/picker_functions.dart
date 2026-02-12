import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../model_todo.dart';
import '../common_widgets.dart';

Future<DateTime?> selectDate(BuildContext context) {
  DateTime? selectedDate = DateTime.now();
  return showDialog<DateTime>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: Color(0xff363636),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TableCalendar(
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2100),
                    focusedDay: selectedDate!,
                    selectedDayPredicate: (day) => isSameDay(day, selectedDate),
                    onDaySelected: (day, focusedDay) {
                      setState(() {
                        selectedDate = day;
                      });
                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Color(0xff272727),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      outsideTextStyle: TextStyle(color: Colors.grey),
                      defaultDecoration: BoxDecoration(
                        color: Color(0xff272727),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      outsideDecoration: BoxDecoration(
                        color: Color(0xff363636),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(6),
                      ),

                      weekendDecoration: BoxDecoration(
                        color: Color(0xff272727),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Color(0xFF8687E7),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      defaultTextStyle: TextStyle(color: Colors.white),
                      weekendTextStyle: TextStyle(color: Colors.white),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      weekendStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      headerMargin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(color: Color(0xff363636)),
                      formatButtonVisible: false,
                      titleCentered: true,
                      leftChevronIcon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      rightChevronIcon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 23),
                  Button(
                    eleBtnTitle: "Choose Time",
                    textBtnTitle: "Cancel",
                    nextPress: () async {
                      {
                        TimeOfDay? pickedTime = await selecTime(context);
                        if (pickedTime != null) {
                          DateTime finalDateTime = DateTime(
                            selectedDate!.year,
                            selectedDate!.month,
                            selectedDate!.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                          Navigator.pop(context, finalDateTime);
                        } else {
                          Navigator.pop(context);
                        }
                      }
                      ;
                    },
                    backPress: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Future<int?> selectPriority(BuildContext context) async {
  int selectedPriority = 1;

  int? result = await showDialog<int>(
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
  return result;
}

Future<TimeOfDay?> selecTime(BuildContext context) async {
  TimeOfDay selectedTime = TimeOfDay.now();

  TimeOfDay? result = await showDialog<TimeOfDay>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Color(0xff363636),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 200,
                child: CupertinoTheme(
                  data: CupertinoThemeData(brightness: Brightness.dark),
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hm,
                    initialTimerDuration: Duration(
                      hours: selectedTime.hour,
                      minutes: selectedTime.minute,
                    ),
                    onTimerDurationChanged: (duration) {
                      selectedTime = TimeOfDay(
                        hour: duration.inHours,
                        minute: duration.inMinutes.remainder(60),
                      );
                    },
                  ),
                ),
              ),
              Button(
                eleBtnTitle: "Save",
                textBtnTitle: "Cancel",
                nextPress: () => Navigator.pop(context, selectedTime),
                backPress: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
    },
  );

  return result;
}

Future<String?> selectCategory(BuildContext context) async {
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
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 24),
        backgroundColor: Color(0xff363636),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
              SizedBox(height: 15),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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
                    onTap: () {
                      Navigator.pop(context, category.toString());
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: TodoItem.getContainerColor(category),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            TodoItem.getTaskIcon(category),
                            color: TodoItem.getIconColor(category),
                            size: 35,
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
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );

  return selectedCategory;
}
