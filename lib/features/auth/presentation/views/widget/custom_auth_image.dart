import 'package:flutter/material.dart';
import 'package:lawaen/app/resources/assets_manager.dart';

class CustomAuthImage extends StatelessWidget {
  const CustomAuthImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Image.asset(ImageManager.onboarding));
  }
}
