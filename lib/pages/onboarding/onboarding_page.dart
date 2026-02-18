import 'package:flutter/material.dart';
import 'package:todo/common_widgets.dart';
import 'package:todo/pages/login_page.dart';
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
        toolbarHeight: MediaQuery.of(context).size.height * 0.01,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
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
                        text: "SKIP",
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.44),
                      ),
                    ),
                    SizedBox(
                      height: 280,
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
                            assetPath:
                                "assets/images/firstOnboarding_photo.png",
                          ),
                          OnboardingImage(
                            assetPath:
                                "assets/images/secondOnboarding_photo.png",
                          ),
                          OnboardingImage(
                            assetPath:
                                "assets/images/thirdOnboarding_photo.png",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 51),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PageIndicator(isActive: currentIndex == 0),
                        SizedBox(width: 12),
                        PageIndicator(isActive: currentIndex == 1),
                        SizedBox(width: 12),
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
                            titleText: "Manage your tasks",
                            subText:
                                "You can easily manage all of your daily tasks in DoMe for free",
                          ),
                          OnboardingText(
                            titleText: "Create daily routine",
                            subText:
                                "In Uptodo  you can create your personalized routine to stay productive",
                          ),
                          OnboardingText(
                            titleText: "Orgonaize your tasks",
                            subText:
                                "You can organize your daily tasks by adding your tasks into separate categories",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Button(
                eleBtnTitle: currentIndex == pageCount - 1
                    ? "Get Started"
                    : "Next",
                textBtnTitle: "back",
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
