import 'package:flutter/material.dart';
import 'package:todo/theme/app_color.dart';

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
