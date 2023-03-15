import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager/ui/screens/completed_task_screen.dart';
import 'package:task_manager/ui/screens/inprogress_task_screen.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';

import '../wigets/user_profile_widget.dart';


class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({Key? key}) : super(key: key);

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _selectedScreen=0;
  final List<Widget> _screens= const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
    InProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: SafeArea(
           child: Column(
             
             children: [
              const UserProfileWidget(),
               Expanded(child: _screens[_selectedScreen]),
             ],
           ),
         ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewTaskScreen()));
        },
        backgroundColor: Colors.green,
        child:const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black38,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        onTap: (index){
         _selectedScreen=index;
         setState(() {});
        },
        elevation: 5,
        currentIndex: _selectedScreen,
        items:const [
          BottomNavigationBarItem(icon: Icon(Icons.new_label_outlined),label: 'New'),
          BottomNavigationBarItem(icon: Icon(Icons.done_outline),label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.close_outlined),label: 'Cancelled'),
          BottomNavigationBarItem(icon: Icon(Icons.scale_outlined),label: 'Process'),
        ],
      ),
    );
  }
}


