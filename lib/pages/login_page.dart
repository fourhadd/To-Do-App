// pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/l10n/app_localizations.dart';
import 'package:todo/pages/home_page/home_page.dart';
import 'package:todo/utils/prefs_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> isLogin() async {
    await PrefsHelper.setLoggedIn(true);
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isFormFilled =>
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, toolbarHeight: 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 41),
                      MainText(
                        text: AppLocalizations.of(context)!.login,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 53),
                      InputField(
                        titleText: AppLocalizations.of(context)!.username,
                        hintText: AppLocalizations.of(
                          context,
                        )!.usernamePlaceholder,
                        controller: _usernameController,
                      ),
                      SizedBox(height: 25),
                      InputField(
                        titleText: AppLocalizations.of(context)!.password,
                        hintText: "........",
                        controller: _passwordController,
                      ),
                      SizedBox(height: 69),
                      MainBtn(
                        title: AppLocalizations.of(context)!.login,
                        isActive: isFormFilled,
                        onPressed: () async {
                          await isLogin();

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                LogRegFooter(isRegister: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
