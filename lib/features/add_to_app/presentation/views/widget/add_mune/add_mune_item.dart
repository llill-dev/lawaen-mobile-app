import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/refresh_cubit/refresh_cubit.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_item_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_services/add_item_container.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/drop_down_item.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class AddMuneItem extends StatelessWidget {
  final bool isServices;

  AddMuneItem({super.key, this.isServices = false});

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(color: ColorManager.black.withValues(alpha: 0.25), offset: const Offset(0, 2), blurRadius: 4),
        ],
      ),
      child: Column(
        children: [
          AddItemContainer(isServices: isServices),
          24.verticalSpace,
          TextFiledItem(title: LocaleKeys.name.tr(), hintText: LocaleKeys.serviceNameHint.tr(), controller: nameCtrl),
          12.verticalSpace,
          TextFiledItem(title: LocaleKeys.price.tr(), hintText: LocaleKeys.priceHint.tr(), controller: priceCtrl),
          12.verticalSpace,
          DropDownItem(title: LocaleKeys.dietaryPreferences.tr(), items: [], hit: LocaleKeys.selectFromElements.tr()),
          12.verticalSpace,
          TextFiledItem(title: LocaleKeys.image.tr(), readOnly: true),
          24.verticalSpace,
          PrimaryButton(
            text: LocaleKeys.addItem.tr(),
            onPressed: () {
              if (nameCtrl.text.isNotEmpty && priceCtrl.text.isNotEmpty) {
                getIt<AddItemCubit>().addItem(nameCtrl.text.trim(), priceCtrl.text.trim());
                nameCtrl.clear();
                priceCtrl.clear();
                getIt<RefreshCubit>().refresh();
              }
            },
            height: 35.h,
            icon: Icon(Icons.add_circle_outline, color: ColorManager.white, size: 18.w),
          ).horizontalPadding(padding: 16.w),
          24.verticalSpace,
        ],
      ),
    );
  }
}
