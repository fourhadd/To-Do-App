// login/register_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/login/login_widgets.dart';
import 'package:todo/pages/auth/auth_provider.dart';
import 'package:todo/pages/home_page/home_page.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/l10n/app_localizations.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, toolbarHeight: 1.h),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 41.h),

              MainText(
                text: t.register,
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
              ),

              SizedBox(height: 23.h),

              InputField(
                controller: _usernameController,
                titleText: t.username,
                hintText: t.usernamePlaceholder,
                onChanged: auth.updateUsername,
              ),

              SizedBox(height: 25.h),

              InputField(
                controller: _passwordController,
                titleText: t.password,
                hintText: ".............",
                isPassword: true,
                onChanged: auth.updatePassword,
              ),

              SizedBox(height: 25.h),

              InputField(
                controller: _confirmController,
                titleText: t.confirmPassword,
                hintText: ".............",
                isPassword: true,
                onChanged: auth.updateConfirmPassword,
              ),

              SizedBox(height: 40.h),
              MainBtn(
                title: t.register,
                onPressed: () async {
                  final error = await auth.register(context);
                  if (error == null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 18.h),
              LogRegFooter(isRegister: true),
            ],
          ),
        ),
      ),
    );
  }
}
