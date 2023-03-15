import 'package:flutter/material.dart';

class AppTextWithSingIn extends StatelessWidget {
  const AppTextWithSingIn({
    Key? key, required this.ontap,
  }) : super(key: key);
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Have account?"),
        TextButton(
            onPressed:ontap,
            child: const Text(
              'Sign in',
              style: TextStyle(
                color: Colors.green,
              ),
            ))
      ],
    );
  }
}