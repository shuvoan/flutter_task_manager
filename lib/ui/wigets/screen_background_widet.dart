import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScreenBackground extends StatelessWidget {
  final Widget child;
  const ScreenBackground({Key? key,required this.child ,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize =MediaQuery.of(context).size;
    return Stack(
      children: [
        SvgPicture.asset('assets/images/background.svg',
          fit: BoxFit.cover,
          width: screenSize.width, height: screenSize.height,
        ),
        child
      ],
    );
  }
}