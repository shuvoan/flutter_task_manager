import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/otp_verification_screen.dart';

import 'package:task_manager/ui/wigets/app_elevated_button.dart';
import 'package:task_manager/ui/wigets/app_text_filed_wiget.dart';
import 'package:task_manager/ui/wigets/app_text_with%20signin.dart';
import 'package:task_manager/ui/wigets/screen_background_widet.dart';
import '../utils/text_styles.dart';

class ForgetWithEmailScreen extends StatefulWidget {
  const ForgetWithEmailScreen({Key? key}) : super(key: key);

  @override
  State<ForgetWithEmailScreen> createState() => _ForgetWithEmailScreenState();
}

class _ForgetWithEmailScreenState extends State<ForgetWithEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Email Address",
                  style: screenTitleTextStyle,
                ),
                const SizedBox(height: 8),
                Text(
                    'A 6 digit verification pin will sent to your email address',
                    style: screenSubtitleTextStyle),
                const SizedBox(height: 24),
                AppTextFiledWiget(
                    hintText: "Email", controller: TextEditingController()),
                const SizedBox(
                  height: 16,
                ),
                AppElevatedButton(
                    child: const Icon(Icons.arrow_circle_right_outlined),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const OtpVerificationScreen()));
                    }),
                const SizedBox(
                  height: 24,
                ),
                AppTextWithSingIn(ontap: () {
                  Navigator.pop(context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
