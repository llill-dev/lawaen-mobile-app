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
      decoration: BoxDecoration(color: Color(0xffDCFCE7), borderRadius: BorderRadius.circular(10.r)),
      child: Text(
        note,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.black),
      ),
    ).horizontalPadding(padding: 16.w);
  }
}
