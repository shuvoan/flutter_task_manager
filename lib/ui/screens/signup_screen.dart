import 'package:flutter/material.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/utils/snackbar_message.dart';
import 'package:task_manager/ui/utils/text_styles.dart';
import 'package:task_manager/ui/wigets/app_elevated_button.dart';
import 'package:task_manager/ui/wigets/app_text_filed_wiget.dart';
import 'package:task_manager/ui/wigets/screen_background_widet.dart';

import '../wigets/app_text_with signin.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailETController = TextEditingController();
  final TextEditingController firstNameETController = TextEditingController();
  final TextEditingController lastNameETController = TextEditingController();
  final TextEditingController mobileETController = TextEditingController();
  final TextEditingController passwordETController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Join With Us",
                      style: screenTitleTextStyle,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AppTextFiledWiget(
                      hintText: 'Email',
                      controller: emailETController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppTextFiledWiget(
                      hintText: 'First Name',
                      controller: firstNameETController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppTextFiledWiget(
                      hintText: 'Last Name',
                      controller: lastNameETController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppTextFiledWiget(
                      hintText: 'Mobile',
                      controller: mobileETController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your mobile';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppTextFiledWiget(
                      hintText: 'Password',
                      controller: passwordETController,
                      validator: (value) {
                        if ((value?.isEmpty ?? true) &&
                            ((value?.length ?? 0) < 6)) {
                          return 'Enter your password and more then 6 letter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (_inProgress)
                      Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      )
                    else
                      AppElevatedButton(
                          child: const Icon(Icons.arrow_circle_right_outlined),
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              _inProgress = true;
                              setState(() {});
                              final result = await NetworkUtils()
                                  .postMethod(Urls.registrationUrl, body: {
                                'email': emailETController.text.trim(),
                                'firstName': firstNameETController.text.trim(),
                                'lastName': lastNameETController.text.trim(),
                                'mobile': mobileETController.text.trim(),
                                'password': passwordETController.text,
                              });
                              _inProgress = false;
                              setState(() {});
                              if (result != null &&
                                  result['status'] == 'success') {
                                emailETController.clear();
                                firstNameETController.clear();
                                lastNameETController.clear();
                                mobileETController.clear();
                                passwordETController.clear();
                                showSnackBarMessenger(
                                    context, 'Registation Successfully');
                              } else {
                                showSnackBarMessenger(context,
                                    'Registation Failed ! try again', true);
                              }
                            }
                          }),
                    const SizedBox(
                      height: 24,
                    ),
                    AppTextWithSingIn(
                      ontap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
