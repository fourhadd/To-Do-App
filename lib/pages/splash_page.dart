// pages/splash_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/utils/prefs_helper.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/pages/home_page/home_page.dart';
import '../login/login_page.dart';
import 'package:todo/pages/onboarding/onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkQuery();
  }

  void checkQuery() async {
    bool onboardComplete = await PrefsHelper.isOnboardingComplete();
    bool isLoggedIn = await PrefsHelper.isLoggedIn();

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    if (!onboardComplete) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingPage()),
      );
    } else if (!isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/uptodo.png",
              width: 113.w,
              height: 113.h,
            ),
            MainText(
              text: "UpTodo",
              fontSize: 40.sp,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
