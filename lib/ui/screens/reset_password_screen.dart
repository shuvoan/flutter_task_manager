import 'package:flutter/material.dart';
import 'package:task_manager/ui/wigets/app_text_filed_wiget.dart';
import 'package:task_manager/ui/wigets/screen_background_widet.dart';

import '../utils/text_styles.dart';
import '../wigets/app_elevated_button.dart';
import '../wigets/app_text_with signin.dart';
import 'login.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Set Password",
                  style: screenTitleTextStyle,
                ),
                const SizedBox(height: 8),
                Text(
                    'Minimum length password 8 character with Letter and number combination',
                    style: screenSubtitleTextStyle),
                const SizedBox(height: 24),
                AppTextFiledWiget(
                    obscureText: true,
                    hintText: 'Password',
                    controller: TextEditingController()),
                const SizedBox(
                  height: 8,
                ),
                AppTextFiledWiget(
                    obscureText: true,
                    hintText: 'Confirm Password',
                    controller: TextEditingController()),
                const SizedBox(height: 16),
                AppElevatedButton(
                    child: const Text('Confirm'),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false);
                    }),
                const SizedBox(
                  height: 24,
                ),
                AppTextWithSingIn(ontap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
