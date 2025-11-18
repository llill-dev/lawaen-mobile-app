import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class AddItemContainer extends StatelessWidget {
  const AddItemContainer({super.key, required this.isServices});

  final bool isServices;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.green.withValues(alpha: 0.30),
      padding: EdgeInsets.all(8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle_outline, color: ColorManager.primary, size: 18.w),
          8.horizontalSpace,
          Text(
            LocaleKeys.addItemType
                .tr(namedArgs: {'type': isServices ? LocaleKeys.services.tr() : LocaleKeys.menu.tr()}),
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorManager.primary),
          ),
        ],
      ),
    );
  }
}
