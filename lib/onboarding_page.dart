import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/common_widgets.dart';
import 'package:todo/login_page.dart';
import 'package:todo/page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  Future<void> onboardComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
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
                      child: Text(
                        "SKIP",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withValues(alpha: 0.44),
                        ),
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
                          onboardimage(
                            assetPath:
                                "assets/images/firstOnboarding_photo.png",
                          ),
                          onboardimage(
                            assetPath:
                                "assets/images/secondOnboarding_photo.png",
                          ),
                          onboardimage(
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
                          onboardingText(
                            titleText: "Manage your tasks",
                            subText:
                                "You can easily manage all of your daily tasks in DoMe for free",
                          ),
                          onboardingText(
                            titleText: "Create daily routine",
                            subText:
                                "In Uptodo  you can create your personalized routine to stay productive",
                          ),
                          onboardingText(
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

class onboardingText extends StatelessWidget {
  final String titleText;
  final String subText;

  const onboardingText({
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

class onboardimage extends StatelessWidget {
  final String assetPath;
  const onboardimage({super.key, required this.assetPath});

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
