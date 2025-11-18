import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/refresh_cubit/refresh_cubit.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_item_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/services_manager_screen.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class ServicesContainer extends StatelessWidget {
  final ServicesModel item;
  final int index;

  const ServicesContainer({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ColorManager.blackSwatch[4]!, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${LocaleKeys.name.tr()}: ${item.name}", style: Theme.of(context).textTheme.displayMedium),
          Divider(color: ColorManager.blackSwatch[4], thickness: 2),
          Text("${LocaleKeys.price.tr()}: ${item.price}", style: Theme.of(context).textTheme.displayMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              8.horizontalSpace,
              GestureDetector(
                child: const Icon(Icons.delete, color: ColorManager.red),
                onTap: () {
                  getIt<AddItemCubit>().deleteItem(index);
                  getIt<RefreshCubit>().refresh();
                },
              ),
            ],
          ),
        ],
      ),
    ).horizontalPadding(padding: 16.w);
  }
}
