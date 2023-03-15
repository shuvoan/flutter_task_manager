import 'package:flutter/material.dart';

class AppTextFiledWiget extends StatelessWidget {
  const AppTextFiledWiget({
    Key? key,
    required this.hintText,
    required this.controller,
    this.obscureText,
    this.maxLines,
    this.validator,
    this.readOnly,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final int? maxLines;
  final  Function(String?)? validator;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
     // autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: obscureText ?? false,
      maxLines: maxLines ?? 1,
      readOnly: readOnly ?? false,
      validator: (value){
            if(validator!=null){
              return validator!(value);
            }return null;
      },
      decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: hintText,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          )),
    );
  }
}
