import 'package:flutter/material.dart';

class OnboardingText extends StatelessWidget {
  final String titleText;
  final String subText;

  const OnboardingText({
    super.key,
    required this.titleText,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            titleText,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 42),
          SizedBox(
            width: 299,
            height: 48,
            child: Text(
              subText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingImage extends StatelessWidget {
  final String assetPath;

  const OnboardingImage({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2),
        Center(child: Image.asset(assetPath, width: 213, height: 277.78)),
      ],
    );
  }
}
