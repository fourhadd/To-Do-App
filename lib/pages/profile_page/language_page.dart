// pages/profile_page/language_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/theme/app_color.dart';
import 'package:todo/utils/provider.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
          color: AppColor.cardColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                languageSelection(
                  language: "Azerbaijani",
                  onTap: () {
                    context.read<TodoProvider>().setLocale(const Locale('az'));
                  },
                ),
                languageSelection(
                  language: "English",
                  onTap: () {
                    context.read<TodoProvider>().setLocale(const Locale('en'));
                  },
                ),
                languageSelection(
                  language: "Russian",
                  onTap: () {
                    context.read<TodoProvider>().setLocale(const Locale('ru'));
                  },
                ),
                languageSelection(
                  language: "Turkish",
                  onTap: () {
                    context.read<TodoProvider>().setLocale(const Locale('tr'));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class languageSelection extends StatelessWidget {
  final String language;
  final VoidCallback onTap;
  const languageSelection({
    super.key,
    required this.language,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: getFlag(language),
      title: MainText(text: language, fontSize: 16.sp),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: 8.h),
    );
  }

  getFlag(String language) {
    double size = 40.w;
    switch (language) {
      case "Azerbaijani":
        return Image.asset(
          "assets/images/Azerbaijan_flag.png",
          width: size,
          height: size,
        );
      case "English":
        return Image.asset(
          "assets/images/English_flag.png",
          width: size,
          height: size,
        );
      case "Russian":
        return Image.asset(
          "assets/images/Russian_flag.png",
          width: size,
          height: size,
        );
      case "Turkish":
        return Image.asset(
          "assets/images/Turkish_flag.png",
          width: size,
          height: size,
        );
      default:
        return SizedBox(width: size, height: size);
    }
  }
}
