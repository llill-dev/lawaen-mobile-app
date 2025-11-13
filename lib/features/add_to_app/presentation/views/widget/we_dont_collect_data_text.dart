import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';

class WeDontCollectDataText extends StatelessWidget {
  const WeDontCollectDataText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "We do not collect or store any private or sensitive data, the application only accesses the site on your device.",
      style: Theme.of(context).textTheme.headlineSmall,
      textAlign: TextAlign.center,
    ).horizontalPadding(padding: 16.w);
  }
}
