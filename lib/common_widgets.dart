import 'package:flutter/material.dart';
import 'package:todo/home_page.dart';
import 'package:todo/login_page.dart';
import 'package:todo/register.dart';

class MainBtn extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback? onPressed;
  const MainBtn({
    super.key,
    required this.title,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: 62,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive
              ? Color(0xff8875FF)
              : Color(0xff8875FF).withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: isActive
                ? Colors.white
                : Colors.white.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}

class InputField extends StatefulWidget {
  final String titleText;
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;

  const InputField({
    super.key,
    required this.titleText,
    required this.hintText,
    this.isPassword = false,
    this.controller,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Color(0xff979797), width: 0.8),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.titleText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.87),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: TextField(
            controller: widget.controller,
            obscureText: widget.isPassword,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: border,
              enabledBorder: border,
              focusedBorder: border,
              disabledBorder: border,
              fillColor: const Color(0xff1D1D1D),
              filled: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: widget.isPassword ? 20 : 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xff535353),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class LogRegFooter extends StatefulWidget {
  bool isRegister;
  LogRegFooter({super.key, this.isRegister = false});

  @override
  State<LogRegFooter> createState() => _LogRegFooterState();
}

class _LogRegFooterState extends State<LogRegFooter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Color(0xff979797), thickness: 1)),
            Text(
              " or ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff979797),
              ),
            ),
            Expanded(child: Divider(color: Color(0xff979797), thickness: 1)),
          ],
        ),
        SizedBox(height: 24),
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false,
            );
          },
          child: Container(
            height: 48,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Color(0xff8875FF), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/google_icon.png",
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: 10),
                Text(
                  widget.isRegister
                      ? "Register with Google"
                      : "Login with Google",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.87),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 48,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Color(0xff8875FF), width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xff283544),
                ),
                child: Icon(Icons.apple, color: Colors.white, size: 20),
              ),
              SizedBox(width: 10),
              Text(
                widget.isRegister ? "Register with Apple" : "Login with Apple",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(alpha: 0.87),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 46),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (widget.isRegister) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
                  );
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                    (route) => false,
                  );
                }
              },
              child: RichText(
                text: TextSpan(
                  text: widget.isRegister
                      ? "Already have an account? "
                      : "Don't have an account? ",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.87),
                    fontSize: 12,
                  ),
                  children: [
                    TextSpan(
                      text: widget.isRegister ? "Login" : "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class Button extends StatelessWidget {
  final String textBtnTitle;
  final String eleBtnTitle;
  final VoidCallback nextPress;
  final VoidCallback backPress;

  const Button({
    super.key,
    required this.eleBtnTitle,
    required this.textBtnTitle,
    required this.nextPress,
    required this.backPress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: backPress,
          child: Text(
            textBtnTitle.toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.44),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: nextPress,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff8875FF),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Text(
            eleBtnTitle.toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class PriorityContainer extends StatelessWidget {
  final int text;
  final bool isSelected; // Əlavə olundu
  final VoidCallback onTap;
  const PriorityContainer({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff8687E7) : Color(0xff272727),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flag_outlined, color: Colors.white),
            SizedBox(height: 4),
            Text(
              text.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
