import 'package:shared_preferences/shared_preferences.dart';
class AuthUtils{
  static String? firstName, lastName,profilePic, mobile,token,email;

  static Future<void> saveUserData(String uFirstname, String uLastname,
      String uProfilePic, String uMobile,String uToken,String uemail) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.setString('firstName', uFirstname);
    await sharedPreferences.setString('lastName', uLastname);
    await sharedPreferences.setString('photo', uProfilePic);
    await sharedPreferences.setString('mobile', uMobile);
    await sharedPreferences.setString('token', uToken);
    await sharedPreferences.setString('email', uemail);
    firstName=uFirstname;
    lastName=uLastname;
    profilePic=uProfilePic;
    mobile=uMobile;
    token=uToken;
    email=uemail;
  }

  static Future<bool> checkLoginState() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String? token=sharedPreferences.getString('token');
    if(token==null){
      return false;
    }else{
      return true;
    }
  }
  static Future<void> getAuthData() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      token= sharedPreferences.getString('token');
      firstName= sharedPreferences.getString('firstName');
      lastName= sharedPreferences.getString('lastName');
      profilePic= sharedPreferences.getString('photo');
      mobile= sharedPreferences.getString('mobile');
      email=sharedPreferences.getString('email');
  }

  static Future<void> clearData()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
        sharedPreferences.clear();
  }
}