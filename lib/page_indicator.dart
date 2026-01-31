import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final bool isActive;
  const PageIndicator({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26.28,
      height: 4,
      decoration: BoxDecoration(
        color: isActive
            ? Colors.white.withValues(alpha: 0.87)
            : Color(0xffAFAFAF),
        borderRadius: BorderRadius.circular(56),
      ),
    );
  }
}
