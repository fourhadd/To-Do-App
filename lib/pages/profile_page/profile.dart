// pages/profile_page/profile.dart
import 'package:flutter/material.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/l10n/app_localizations.dart';
import 'package:todo/pages/add_task_page/addTaskPage.dart';
import 'package:todo/pages/home_page/home_page_widgets.dart';
import 'package:todo/pages/login_page.dart';
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
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 20),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.1,
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
        width: 64,
        height: 64,
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
          child: Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Center(
                child: MainText(text: AppLocalizations.of(context)!.profile),
              ),
              SizedBox(height: 24),
              Container(
                width: 85,
                height: 85,
                child: CircleAvatar(backgroundColor: AppColor.homeBg),
              ),
              SizedBox(height: 10),
              MainText(text: "Martha Hays"),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TaskFilterButton(isDoneOrLeft: true),
                  TaskFilterButton(isDoneOrLeft: false),
                ],
              ),
              SizedBox(height: 32),
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
                  SizedBox(height: 8),

                  MainText(
                    text: AppLocalizations.of(context)!.accountSection,
                    color: AppColor.profileTextTitleColor,
                  ),
                  SizedBox(height: 8),

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
                  SizedBox(height: 8),
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
                  SizedBox(height: 17),
                  GestureDetector(
                    onTap: () {
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
                  SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
