import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class ClaimAndImNotRobortButtons extends StatefulWidget {
  const ClaimAndImNotRobortButtons({super.key});

  @override
  State<ClaimAndImNotRobortButtons> createState() => _ClaimAndImNotRobortButtonsState();
}

class _ClaimAndImNotRobortButtonsState extends State<ClaimAndImNotRobortButtons> {
  bool acceptImNotRobort = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: buildContainer(),
            child: Row(
              children: [
                Checkbox(
                  value: acceptImNotRobort,
                  onChanged: (value) {
                    setState(() {
                      acceptImNotRobort = value!;
                    });
                  },
                  checkColor: ColorManager.primary,
                  activeColor: ColorManager.blackSwatch[3],
                ),
                Text("I'm not robot", style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: buildContainer(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(IconManager.claim),
                4.horizontalSpace,
                Text("claim", style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
          ),
        ),
      ],
    ).horizontalPadding(padding: 16.w);
  }

  BoxDecoration buildContainer() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      color: ColorManager.white,
      border: Border.all(color: ColorManager.primary, width: 2),
      boxShadow: [BoxShadow(color: ColorManager.primary, blurRadius: 4.r, offset: const Offset(0, 4))],
    );
  }
}
