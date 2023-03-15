import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/auth_utils.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/screens/forget_with_email_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_bar.dart';
import 'package:task_manager/ui/screens/signup_screen.dart';
import 'package:task_manager/ui/utils/snackbar_message.dart';
import 'package:task_manager/ui/wigets/screen_background_widet.dart';

import '../utils/text_styles.dart';
import '../wigets/app_elevated_button.dart';
import '../wigets/app_text_filed_wiget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailETController= TextEditingController();
  final TextEditingController _passwordETController= TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  bool _inprogress= false;

  Future<void> login() async {
    _inprogress=true;
    setState(() {  });
    final result= await NetworkUtils().postMethod(Urls.loginUrl,
        body: {
          'email':_emailETController.text.trim(),
          'password':_passwordETController.text,
        },
        onUnAuthorize: (){
          showSnackBarMessenger(context, 'username or password incorrect!',true);
        }
    ) ;
    _inprogress=false;
    setState(() {  });
    if(result!= null && result['status']== 'success'){
      await AuthUtils.saveUserData(
          result['data']['firstName'].toString(),
          result['data']['lastName'].toString(),
          result['data']['photo'].toString(),
          result['data']['mobile'].toString(),
          result['token'].toString(),
          result['data']['email'].toString(),
    );
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) => const MainBottomNavBar()), (
          route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Get Started With', style: screenTitleTextStyle),
                const SizedBox(
                  height: 24,
                ),
                AppTextFiledWiget(
                  controller: _emailETController,
                  hintText: "Email",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextFiledWiget(
                    obscureText: true,
                    hintText: 'Password',
                    controller: _passwordETController,
                  validator: (value) {
                    if ((value?.isEmpty ?? true) &&
                        ((value?.length ?? 0) < 6)) {
                      return 'Enter your valid password and more then 6 letter';
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 16,
                ),
                if(_inprogress)Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )else
                AppElevatedButton(
                  onTap: () async {
                    if(_formKey.currentState!.validate()){
                     login();
                    }
                  },
                  child: const Icon(Icons.arrow_circle_right_outlined),
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgetWithEmailScreen()));
                      },
                      child: const Text(
                        'Forget Password?',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
