import 'package:flutter/material.dart';
import 'package:task_manager/ui/wigets/screen_background_widet.dart';

import '../../data/models/task_model.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utils/snackbar_message.dart';
import '../wigets/status_change_buttom_sheet.dart';
import '../wigets/task_list_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  TaskModel completedTaskModel=TaskModel();
  bool inProgress=false;

  @override
  void initState() {

    super.initState();
    getAllNewTask();
  }

  Future<void> getAllNewTask() async {
    inProgress=true;
    setState(() { });
    final response= await NetworkUtils().getMethod(Urls.completedTaskURl);
    if(response !=null ){
      completedTaskModel=TaskModel.fromJson(response);
    }else{
      showSnackBarMessenger(context, "Unable to fatch completed task ! try again",true);
    }
    inProgress=false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
        child: Column(
          children: [

            Expanded(
                child:inProgress ?const Center(
                  child: CircularProgressIndicator(),
                ): RefreshIndicator(
                  onRefresh: ()async{
                    getAllNewTask();
                  },
                  child: ListView.builder(
                      itemCount: completedTaskModel.data?.length,
                      ///reverse: true,
                      itemBuilder: (context,index){
                        return TaskListItem(
                          type: 'Completed',
                          subject: completedTaskModel.data?[index].title?? 'unknown',
                          labelColorSet: Colors.green,
                          date: completedTaskModel.data?[index].createdDate?? 'unknown',
                          description: completedTaskModel.data?[index].description?? 'unknown',
                          onEditPress: (){
                            showChangeTaskStatus(
                              'Completed',
                                completedTaskModel.data?[index].sId ?? '',(){
                              getAllNewTask();
                            });
                          },
                          onDeletePress: (){},
                        );
                      }),
                )
            )
          ],
        ));
  }
}
