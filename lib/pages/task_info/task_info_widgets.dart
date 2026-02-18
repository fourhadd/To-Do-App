import 'package:flutter/material.dart';
import 'package:todo/common_widgets.dart';
import 'package:todo/models/model_todo.dart';
import 'package:todo/theme/app_color.dart';

class taskInfo extends StatelessWidget {
  final IconData leadingIcon;
  final String titleText;
  final Widget? trailing;
  final IconData trailingIcon;
  final Color trailingIconColor;
  final String trailingText;

  taskInfo({
    super.key,
    required this.leadingIcon,
    required this.titleText,
    this.trailing,
    this.trailingIcon = Icons.add,
    this.trailingIconColor = Colors.black,
    required this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 34.0),
        child: ListTile(
          leading: Icon(leadingIcon, color: Colors.white),
          title: Text(
            titleText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.87),
            ),
          ),
          trailing: Container(
            height: 45,
            decoration: BoxDecoration(
              color: AppColor.cardColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  trailingIcon != Icons.add
                      ? Row(
                          children: [
                            Icon(trailingIcon, color: trailingIconColor),
                            SizedBox(width: 10),
                            Text(
                              trailingText,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : MainText(text: trailingText, fontSize: 14),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class taskTitle extends StatelessWidget {
  const taskTitle({super.key, required this.task});

  final TodoItem task;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Checkbox(
          shape: CircleBorder(),
          value: task.isDone,
          onChanged: (value) {},
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: task.title,
                fontSize: 20,
                color: Colors.white.withValues(alpha: 0.87),
              ),

              MainText(
                text: task.description,
                fontSize: 16,
                color: Color(0xffAFAFAF),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.edit, color: Colors.white, size: 25),
        ),
      ),
    );
  }
}
