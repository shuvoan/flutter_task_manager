import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utils/snackbar_message.dart';
import '../wigets/screen_background_widet.dart';
import '../wigets/status_change_buttom_sheet.dart';
import '../wigets/task_list_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({Key? key}) : super(key: key);

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  TaskModel cancelledTaskModel=TaskModel();
  bool inProgress=false;

  @override
  void initState() {

    super.initState();
    getAllNewTask();
  }

  Future<void> getAllNewTask() async {
    inProgress=true;
    setState(() { });
    final response= await NetworkUtils().getMethod(Urls.cancelledTaskURl);
    if(response !=null ){
      cancelledTaskModel=TaskModel.fromJson(response);
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
                      itemCount: cancelledTaskModel.data?.length,
                      ///reverse: true,
                      itemBuilder: (context,index){
                        return TaskListItem(
                          type: 'Cancelled',
                          subject: cancelledTaskModel.data?[index].title?? 'unknown',
                          labelColorSet: Colors.red,
                          date: cancelledTaskModel.data?[index].createdDate?? 'unknown',
                          description: cancelledTaskModel.data?[index].description?? 'unknown',
                          onEditPress: (){
                            showChangeTaskStatus(
                                'Cancelled',
                                cancelledTaskModel.data?[index].sId ?? '',(){
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
