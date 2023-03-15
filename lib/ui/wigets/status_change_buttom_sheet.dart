import 'package:flutter/material.dart';
import 'package:task_manager/main.dart';

import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utils/snackbar_message.dart';
import 'app_elevated_button.dart';

showChangeTaskStatus(String currentStatues,String taskId, VoidCallback onTaskChangeCompleted) {
  String currentValues = currentStatues;

  showModalBottomSheet(
      context: TaskManagerApp.globalKey.currentContext!,
      builder: (context) {
        return StatefulBuilder(builder: (context, changeState) {
          return Column(
            children: [
              RadioListTile(
                  value: 'New',
                  groupValue: currentValues,
                  title: const Text('New'),
                  onChanged: (state) {
                    currentValues = state as String;
                    changeState(() {});
                  }),
              RadioListTile(
                  value: 'Completed',
                  groupValue: currentValues,
                  title: const Text('Completed'),
                  onChanged: (state) {
                    currentValues = state as String;
                    changeState(() {});
                  }),
              RadioListTile(
                  value: 'Cancelled',
                  groupValue: currentValues,
                  title: const Text('Cancelled'),
                  onChanged: (state) {
                    currentValues = state as String;
                    changeState(() {});
                  }),
              RadioListTile(
                  value: 'Progress',
                  groupValue: currentValues,
                  title: const Text('Progress'),
                  onChanged: (state) {
                    currentValues = state as String;
                    changeState(() {});
                  }),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppElevatedButton(
                    child: const Text('Change Status'),
                    onTap: () async {
                      final response = await NetworkUtils().getMethod(
                          Urls.changeTaskStatues(taskId, currentValues));
                      if (response != null) {
                        onTaskChangeCompleted();
                        Navigator.pop(context);
                      } else {
                        showSnackBarMessenger(
                            context, "Change State failed ! Try again", true);
                      }
                    }),
              )
            ],
          );
        });
      });
}