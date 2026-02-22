// pages/register_page.dart
import 'package:flutter/material.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/l10n/app_localizations.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  bool get isFormFilled =>
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmpasswordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
    _confirmpasswordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, toolbarHeight: 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 41),
              MainText(
                text: AppLocalizations.of(context)!.register,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 23),
              InputField(
                titleText: AppLocalizations.of(context)!.username,
                hintText: AppLocalizations.of(context)!.usernamePlaceholder,
                controller: _usernameController,
              ),
              SizedBox(height: 25),
              InputField(
                titleText: AppLocalizations.of(context)!.password,
                hintText: ".............",
                controller: _passwordController,
                isPassword: true,
              ),
              SizedBox(height: 25),
              InputField(
                titleText: AppLocalizations.of(context)!.confirmPassword,
                hintText: ".............",
                controller: _confirmpasswordController,
                isPassword: true,
              ),
              SizedBox(height: 40),
              MainBtn(
                title: AppLocalizations.of(context)!.register,
                isActive: isFormFilled,
                onPressed: () {},
              ),
              SizedBox(height: 18),
              // Spacer(),
              LogRegFooter(isRegister: true),
            ],
          ),
        ),
      ),
    );
  }
}
