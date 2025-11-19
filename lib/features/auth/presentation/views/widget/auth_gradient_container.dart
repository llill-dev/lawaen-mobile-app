import 'package:flutter/material.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class AuthGradientContainer extends StatelessWidget {
  final Widget child;
  const AuthGradientContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ColorManager.onBoardingGradient,
        ),
      ),
      child: child,
    );
  }
}
