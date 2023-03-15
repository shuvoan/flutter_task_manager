import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/utils/snackbar_message.dart';
import 'package:task_manager/ui/wigets/app_elevated_button.dart';
import 'package:task_manager/ui/wigets/screen_background_widet.dart';

import '../wigets/dashboard_item.dart';
import '../wigets/status_change_buttom_sheet.dart';
import '../wigets/task_list_item.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  TaskModel newTaskModel = TaskModel();
  bool inProgress = false;

  @override
  void initState() {
    super.initState();
    getAllNewTask();
  }

  Future<void> getAllNewTask() async {
    inProgress = true;
    setState(() {});
    final response = await NetworkUtils().getMethod(Urls.newTaskURl);
    if (response != null) {

      newTaskModel = TaskModel.fromJson(response);
    } else {
      showSnackBarMessenger(
          context, "Unable to fatch new task ! try again", true);
    }
    inProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
        child: Column(
      children: [
        Row(
          children: const [
            Expanded(
              child: DashboardItem(

              typeOfTask: 'New',
                numberOfTask: 23,

              ),
            ),
            Expanded(
              child: DashboardItem(
                typeOfTask: 'Completed',
                numberOfTask: 23,
              ),
            ),
            Expanded(
              child: DashboardItem(
                typeOfTask: 'Cancelled',
                numberOfTask: 23,
              ),
            ),
            Expanded(
              child: DashboardItem(
                typeOfTask: 'Progress',
                numberOfTask: 23,
              ),
            ),
          ],
        ),
        Expanded(
            child: inProgress
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      getAllNewTask();
                    },
                    child: ListView.builder(
                        itemCount: newTaskModel.data?.length,

                        ///reverse: true,
                        itemBuilder: (context, index) {
                          return TaskListItem(
                            type: 'New',
                            subject:
                                newTaskModel.data?[index].title ?? 'unknown',
                            labelColorSet: Colors.lightBlueAccent,
                            date: newTaskModel.data?[index].createdDate ??
                                'unknown',
                            description:
                                newTaskModel.data?[index].description ??
                                    'unknown',
                            onEditPress: () {
                              showChangeTaskStatus(
                                'New',
                                  newTaskModel.data?[index].sId ?? '',(){
                                    getAllNewTask();
                              });
                            },
                            onDeletePress: () {},
                          );
                        }),
                  ))
      ],
    ));
  }


}
