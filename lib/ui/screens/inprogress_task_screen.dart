import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utils/snackbar_message.dart';
import '../wigets/screen_background_widet.dart';
import '../wigets/status_change_buttom_sheet.dart';
import '../wigets/task_list_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({Key? key}) : super(key: key);

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  TaskModel progressTaskModel=TaskModel();
  bool inProgress=false;

  @override
  void initState() {

    super.initState();
    getAllNewTask();
  }

  Future<void> getAllNewTask() async {
    inProgress=true;
    setState(() { });
    final response= await NetworkUtils().getMethod(Urls.progressTaskURl);
    if(response !=null ){
      progressTaskModel=TaskModel.fromJson(response);
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
                      itemCount: progressTaskModel.data?.length,
                      ///reverse: true,
                      itemBuilder: (context,index){
                        return TaskListItem(
                          type: 'Progress',
                          subject: progressTaskModel.data?[index].title?? 'unknown',
                          labelColorSet: Colors.purpleAccent,
                          date: progressTaskModel.data?[index].createdDate?? 'unknown',
                          description: progressTaskModel.data?[index].description?? 'unknown',
                          onEditPress: (){
                            showChangeTaskStatus(
                                'Progress',
                                progressTaskModel.data?[index].sId ?? '',(){
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
