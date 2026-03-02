// pages/profile_page/profile.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/pages/auth/auth_provider.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/l10n/app_localizations.dart';
import 'package:todo/pages/add_task_page/addTaskPage.dart';
import 'package:todo/pages/home_page/home_page_widgets.dart';
import 'package:todo/login/login_page.dart';
import 'package:todo/pages/profile_page/language_page.dart';
import 'package:todo/pages/profile_page/profile_page_widgets.dart';
import 'package:todo/theme/app_color.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 20.h),
      bottomNavigationBar: Container(
        height: 0.1.sh,
        color: AppColor.cardColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(
              icon: Icons.home_outlined,
              label: AppLocalizations.of(context)!.index,
            ),
            navItem(
              icon: Icons.calendar_month_outlined,
              label: AppLocalizations.of(context)!.calendar,
            ),
            navItem(
              icon: Icons.access_time,
              label: AppLocalizations.of(context)!.focuse,
            ),
            navItem(
              icon: Icons.person_outline_outlined,
              label: AppLocalizations.of(context)!.profile,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 64.w,
        height: 64.h,
        child: FloatingActionButton(
          onPressed: () async {
            await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: AppColor.cardColor,
              context: context,
              builder: (context) => AddtaskPage(TodoItems: []),
            );
          },
          backgroundColor: AppColor.secondaryColor,
          shape: CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: 28.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Center(
                child: MainText(text: AppLocalizations.of(context)!.profile),
              ),
              SizedBox(height: 24.h),
              Container(
                width: 85.w,
                height: 85.h,
                child: CircleAvatar(backgroundColor: AppColor.homeBg),
              ),
              SizedBox(height: 10.h),
              MainText(text: auth.username),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TaskFilterButton(isDoneOrLeft: true),

                  TaskFilterButton(isDoneOrLeft: false),
                ],
              ),
              SizedBox(height: 32.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainText(
                    text: AppLocalizations.of(context)!.settingsSection,
                    color: AppColor.profileTextTitleColor,
                  ),
                  profileItem(
                    icon: Icons.language,
                    label: AppLocalizations.of(context)!.language,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: false,
                        builder: (context) => LanguagePage(),
                      );
                    },
                  ),
                  SizedBox(height: 8.h),
                  MainText(
                    text: AppLocalizations.of(context)!.accountSection,
                    color: AppColor.profileTextTitleColor,
                  ),
                  SizedBox(height: 8.h),
                  profileItem(
                    icon: Icons.person_outline_outlined,
                    label: AppLocalizations.of(context)!.changeAccountName,
                  ),
                  profileItem(
                    icon: Icons.vpn_key_sharp,
                    label: AppLocalizations.of(context)!.changeAccountPassword,
                  ),
                  profileItem(
                    icon: Icons.camera_alt_outlined,
                    label: AppLocalizations.of(context)!.changeAccountImage,
                  ),
                  MainText(text: "DoMe", color: AppColor.profileTextTitleColor),
                  SizedBox(height: 8.h),
                  profileItem(
                    icon: Icons.grid_view_outlined,
                    label: AppLocalizations.of(context)!.aboutUs,
                  ),
                  profileItem(
                    icon: Icons.info_outline,
                    label: AppLocalizations.of(context)!.faq,
                  ),
                  profileItem(
                    icon: Icons.bolt_outlined,
                    label: AppLocalizations.of(context)!.helpFeedback,
                  ),
                  profileItem(
                    icon: Icons.thumb_up_alt_outlined,
                    label: AppLocalizations.of(context)!.supportUs,
                  ),
                  SizedBox(height: 17.h),
                  GestureDetector(
                    onTap: () async {
                      await context.read<AuthProvider>().logout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      );
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Icon(Icons.logout, color: AppColor.warning),
                      title: MainText(
                        text: AppLocalizations.of(context)!.logOut,
                        color: AppColor.warning,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
