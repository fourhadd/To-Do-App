// login/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/login/login_widgets.dart';
import 'package:todo/pages/auth/auth_provider.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/l10n/app_localizations.dart';
import 'package:todo/pages/home_page/home_page.dart';

class LoginPage extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  LoginPage({
    super.key,
    TextEditingController? usernameController,
    TextEditingController? passwordController,
  }) : usernameController = usernameController ?? TextEditingController(),
       passwordController = passwordController ?? TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, toolbarHeight: 1.h),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 0.6.sh,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 41.h),
                      MainText(
                        text: t.login,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 53.h),
                      InputField(
                        controller: widget.usernameController,
                        titleText: t.username,
                        hintText: t.usernamePlaceholder,
                        onChanged: (val) => auth.updateUsername(val),
                      ),
                      SizedBox(height: 25.h),
                      InputField(
                        controller: widget.passwordController,
                        titleText: t.password,
                        hintText: "........",
                        isPassword: true,
                        onChanged: (val) => auth.updatePassword(val),
                      ),
                      SizedBox(height: 69.h),
                      MainBtn(
                        title: t.login,
                        onPressed: () async {
                          final error = await auth.login(context);
                          if (error == null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomePage(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
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
