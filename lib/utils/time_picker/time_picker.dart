// utils/time_picker/time_picker.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/l10n/app_localizations.dart';
import 'package:todo/theme/app_color.dart';
import '../../widgets/common_widgets.dart';

Future<TimeOfDay?> selecTime(BuildContext context) async {
  TimeOfDay selectedTime = TimeOfDay.now();

  TimeOfDay? result = await showDialog<TimeOfDay>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColor.cardColor,
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
                eleBtnTitle: AppLocalizations.of(context)!.save,
                textBtnTitle: AppLocalizations.of(context)!.cancel,
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
