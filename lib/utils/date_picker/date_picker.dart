// utils/date_picker/date_picker.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/l10n/app_localizations.dart';
import 'package:todo/theme/app_color.dart';
import 'package:todo/utils/time_picker/time_picker.dart';

Future<DateTime?> selectDate(BuildContext context) {
  DateTime? selectedDate = DateTime.now();
  return showDialog<DateTime>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: AppColor.cardColor,
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
                        color: AppColor.cardColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(6),
                      ),

                      weekendDecoration: BoxDecoration(
                        color: Color(0xff272727),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      selectedDecoration: BoxDecoration(
                        color: AppColor.secondaryColor,
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
                      decoration: BoxDecoration(color: AppColor.cardColor),
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
                    eleBtnTitle: AppLocalizations.of(context)!.chooseTime,
                    textBtnTitle: AppLocalizations.of(context)!.cancel,
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
