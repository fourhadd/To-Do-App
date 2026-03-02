// pages/onboarding/onboarding_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/l10n/app_localizations.dart';
import 'package:todo/login/login_page.dart';
import 'package:todo/pages/onboarding/onboarding_widgets.dart';
import 'package:todo/utils/prefs_helper.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  Future<void> onboardComplete() async {
    await PrefsHelper.setOnboardingComplete(true);
  }

  int currentIndex = 0;
  final int pageCount = 3;
  final PageController _imageController = PageController();
  final PageController _textController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 10.h,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () async {
                  await onboardComplete();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
                  );
                },
                child: MainText(
                  text: AppLocalizations.of(context)!.skip,
                  fontSize: 16.sp,
                  color: Colors.white.withValues(alpha: 0.44),
                ),
              ),
              SizedBox(
                height: 280.h,
                child: PageView(
                  controller: _imageController,
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                    _textController.jumpToPage(index);
                  },
                  children: [
                    OnboardingImage(
                      assetPath: "assets/images/firstOnboarding_photo.png",
                    ),
                    OnboardingImage(
                      assetPath: "assets/images/secondOnboarding_photo.png",
                    ),
                    OnboardingImage(
                      assetPath: "assets/images/thirdOnboarding_photo.png",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 51.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PageIndicator(isActive: currentIndex == 0),
                  SizedBox(width: 12.w),
                  PageIndicator(isActive: currentIndex == 1),
                  SizedBox(width: 12.w),
                  PageIndicator(isActive: currentIndex == 2),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: PageView(
                  controller: _textController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  children: [
                    OnboardingText(
                      titleText: AppLocalizations.of(context)!.manageTasksTitle,
                      subText: AppLocalizations.of(context)!.manageTasksDesc,
                    ),
                    OnboardingText(
                      titleText: AppLocalizations.of(
                        context,
                      )!.createRoutineTitle,
                      subText: AppLocalizations.of(context)!.createRoutineDesc,
                    ),
                    OnboardingText(
                      titleText: AppLocalizations.of(
                        context,
                      )!.organizeTasksTitle,
                      subText: AppLocalizations.of(context)!.organizeTasksDesc,
                    ),
                  ],
                ),
              ),
              Spacer(),
              Button(
                eleBtnTitle: currentIndex == pageCount - 1
                    ? AppLocalizations.of(context)!.getStarted
                    : AppLocalizations.of(context)!.next,
                textBtnTitle: AppLocalizations.of(context)!.back,
                nextPress: () async {
                  if (currentIndex == pageCount - 1) {
                    await onboardComplete();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,
                    );
                  } else {
                    _imageController.jumpToPage(currentIndex + 1);
                  }
                },
                backPress: () {
                  if (currentIndex > 0) {
                    _imageController.jumpToPage(currentIndex - 1);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
