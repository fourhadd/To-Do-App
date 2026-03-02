// utils/priority_picker/priority_picker.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/l10n/app_localizations.dart';
import 'package:todo/theme/app_color.dart';

Future<int?> selectPriority(BuildContext context) async {
  int selectedPriority = 1;

  int? result = await showDialog<int>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            insetPadding: EdgeInsets.all(24.w),
            backgroundColor: AppColor.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.taskPriority,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.87),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Container(
                    width: 1.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Color(0xff979797),
                                thickness: 1.h,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 22.h),
                        Wrap(
                          spacing: 16.w,
                          runSpacing: 16.h,
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
                        SizedBox(height: 18.h),
                        Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Button(
                            eleBtnTitle: AppLocalizations.of(context)!.save,
                            textBtnTitle: AppLocalizations.of(context)!.cancel,
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

class PriorityContainer extends StatelessWidget {
  final int text;
  final bool isSelected;
  final VoidCallback onTap;
  const PriorityContainer({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64.w,
        height: 64.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.secondaryColor : Color(0xff272727),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flag_outlined, color: Colors.white, size: 24.sp),
            SizedBox(height: 4.h),
            Text(
              text.toString(),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.87),
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
