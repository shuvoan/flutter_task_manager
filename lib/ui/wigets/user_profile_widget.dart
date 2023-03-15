import 'package:flutter/material.dart';
import 'package:task_manager/data/auth_utils.dart';
import 'package:task_manager/ui/screens/login.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>const UpdateProfileScreen()));
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      tileColor: Colors.green,
      title:  Text('${AuthUtils.firstName ?? ''} ${AuthUtils.lastName ?? ''}'),
      subtitle:  Text(AuthUtils.email??'Unkonow'),
      trailing: IconButton(
        onPressed: () async{
         await AuthUtils.clearData();
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
             builder: (context) => LoginScreen()), (route) => false);
        },
        icon:const Icon(Icons.login_outlined,color: Colors.white,),
      ),
    );
  }
}
