import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/data/models/category_item_model.dart';
import 'package:lawaen/features/home/presentation/views/widgets/category_item_details/item_details_link_row.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import '../../../../../../app/resources/assets_manager.dart';
import 'feedback_bottom_sheet.dart';

class BasicInfoSection extends StatelessWidget {
  final ItemData itemData;
  const BasicInfoSection({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    final int average = itemData.item?.rating?.average ?? 0;

    final stars = List.generate(5, (index) {
      final isActive = index < average;
      return Icon(Icons.star_rounded, size: 32.r, color: isActive ? ColorManager.orange : ColorManager.darkGrey);
    });

    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(IconManager.location, color: ColorManager.black),
              8.horizontalSpace,
              Flexible(child: Text(itemData.item?.address ?? "", style: Theme.of(context).textTheme.headlineMedium)),
            ],
          ),

          12.verticalSpace,
          ItemDetialsLinksRow(itemData: itemData),

          12.verticalSpace,
          Text(itemData.item?.description ?? "", style: Theme.of(context).textTheme.labelMedium),

          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: List.generate(stars.length, (index) => stars[index])),
              GestureDetector(
                onTap: () => _showFeedBackBttomSheet(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: ColorManager.primary, width: 2),
                  ),
                  child: Text(
                    LocaleKeys.feedback.tr(),
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(color: ColorManager.primary, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),

          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildUserActionContainer(context: context, title: LocaleKeys.claim.tr(), onTap: () {}),
              4.horizontalSpace,
              _buildUserActionContainer(context: context, title: LocaleKeys.report.tr(), onTap: () {}, read: true),
            ],
          ),
        ],
      ).horizontalPadding(padding: 16.w),
    );
  }

  void _showFeedBackBttomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.white,
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (_) {
        return const FeedbackBottomSheet();
      },
    );
  }

  Widget _buildUserActionContainer({
    required BuildContext context,
    required String title,
    bool read = false,
    required Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.w,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: read ? ColorManager.red : ColorManager.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_rounded, color: ColorManager.white, size: 15.r),
            4.horizontalSpace,
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorManager.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
