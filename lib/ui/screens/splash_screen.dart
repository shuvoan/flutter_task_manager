import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/data/auth_utils.dart';
import 'package:task_manager/ui/screens/login.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_bar.dart';

import '../wigets/screen_background_widet.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      checkUserAuthState();
    });

  }

  Future<void> checkUserAuthState() async {
    final bool result=await  AuthUtils.checkLoginState();
    if(result){
      await AuthUtils.getAuthData();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => MainBottomNavBar()), (
              route) => false);
    }else{
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => LoginScreen()), (
              route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
      child: Center(
          child: SvgPicture.asset(
        'assets/images/logo.svg',
        width: 150,
        fit: BoxFit.scaleDown,
      )),
    ));
  }
}
