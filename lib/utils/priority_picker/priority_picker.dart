import 'package:flutter/material.dart';
import 'package:todo/common_widgets.dart';
import 'package:todo/theme/app_color.dart';

Future<int?> selectPriority(BuildContext context) async {
  int selectedPriority = 1;

  int? result = await showDialog<int>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            insetPadding: EdgeInsets.all(24),
            backgroundColor: AppColor.cardColor,
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

class PriorityContainer extends StatelessWidget {
  final int text;
  final bool isSelected; // Əlavə olundu
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
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.secondaryColor : Color(0xff272727),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flag_outlined, color: Colors.white),
            SizedBox(height: 4),
            Text(
              text.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
