import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/auth_utils.dart';
import 'package:task_manager/ui/utils/text_styles.dart';
import 'package:task_manager/ui/wigets/app_elevated_button.dart';
import 'package:task_manager/ui/wigets/app_text_filed_wiget.dart';
import 'package:task_manager/ui/wigets/user_profile_widget.dart';

import '../wigets/screen_background_widet.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailETController = TextEditingController();
  final TextEditingController _firstNameETController = TextEditingController();
  final TextEditingController _lastNameETController = TextEditingController();
  final TextEditingController _mobileETController = TextEditingController();
  final TextEditingController _passwordETController = TextEditingController();

  XFile? pickedImage;

  @override
  void initState() {
    super.initState();
    _emailETController.text = AuthUtils.email ?? '';
    _firstNameETController.text = AuthUtils.firstName ?? '';
    _lastNameETController.text = AuthUtils.lastName ?? '';
    _mobileETController.text = AuthUtils.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileWidget(),
            Expanded(
                child: ScreenBackground(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        'Update Profile',
                        style: screenTitleTextStyle,
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          pickedImage = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (pickedImage != null) {
                            setState(() {});
                          }
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  )),
                              child: const Text('Photo'),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    )),
                                child: Text(
                                  pickedImage?.name ?? '',
                                  maxLines: 1,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AppTextFiledWiget(
                        hintText: 'Email',
                        controller: _emailETController,
                        readOnly: true,
                      ),
                      const SizedBox(height: 8),
                      AppTextFiledWiget(
                          hintText: 'First Name',
                          controller: _firstNameETController),
                      const SizedBox(height: 8),
                      AppTextFiledWiget(
                          hintText: 'Last Name',
                          controller: _lastNameETController),
                      const SizedBox(height: 8),
                      AppTextFiledWiget(
                          hintText: 'Mobile', controller: _mobileETController),
                      const SizedBox(height: 8),
                      AppTextFiledWiget(
                          hintText: 'Password',
                          obscureText: true,
                          controller: _passwordETController),
                      const SizedBox(height: 16),
                      AppElevatedButton(
                          child: const Icon(Icons.arrow_circle_right_outlined),
                          onTap: () {})
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
