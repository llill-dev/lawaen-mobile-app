import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class NoteContainer extends StatelessWidget {
  final String note;
  const NoteContainer({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: ColorManager.green.withValues(alpha: .25),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorManager.green.withValues(alpha: .30), width: 2),
      ),
      child: Text(
        note,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.primary),
      ),
    ).horizontalPadding(padding: 16.w);
  }
}
