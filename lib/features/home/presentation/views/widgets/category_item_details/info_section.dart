import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/core/functions/url_launcher.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/features/home/data/models/category_item_model.dart';

import '../../../../../../app/resources/color_manager.dart';

class InfoSection extends StatelessWidget {
  final bool isEvent;
  final ItemData itemData;
  const InfoSection({super.key, this.isEvent = false, required this.itemData});

  @override
  Widget build(BuildContext context) {
    final emails = itemData.ui?.contacts?.emails;
    final urls = itemData.ui?.contacts?.urls;
    final services = itemData.ui?.options ?? [];
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            if (!isEvent &&
                ((emails != null && emails.isNotEmpty) ||
                    (urls != null && urls.isNotEmpty) ||
                    (services.isNotEmpty))) ...[
              20.verticalSpace,
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: _buildBoxDecoration(),
                child: Column(
                  children: [
                    12.verticalSpace,

                    if (emails != null && emails.isNotEmpty)
                      ...emails.map((email) {
                        return Column(
                          children: [
                            _InfoItem(
                              title: email.title ?? "",
                              icon: email.svg,
                              onTap: () {
                                final emailAddress = email.value?.trim() ?? "";
                                if (emailAddress.isNotEmpty) {
                                  launchEmail(emailAddress);
                                }
                              },
                            ),
                            12.verticalSpace,
                          ],
                        );
                      }),

                    if (urls != null && urls.isNotEmpty)
                      ...urls.map((url) {
                        return Column(
                          children: [
                            _InfoItem(
                              title: url.title ?? "",
                              icon: url.svg,
                              onTap: () {
                                launchURL(link: url.value.toString());
                              },
                            ),
                            10.verticalSpace,
                          ],
                        );
                      }),
                    if (services.isNotEmpty)
                      ...services.map((service) {
                        return Column(
                          children: [
                            _InfoItem(title: service.title ?? "", icon: service.svg),
                            10.verticalSpace,
                          ],
                        );
                      }),
                  ],
                ),
              ),
              20.verticalSpace,
            ],
          ],
        ).horizontalPadding(padding: 16.w),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: ColorManager.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: ColorManager.primary),
      boxShadow: [BoxShadow(color: ColorManager.black.withValues(alpha: .25), blurRadius: 4, offset: Offset(0, 4))],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String? icon;
  final String? subTitle;
  final String? moreInfoToShow;
  final VoidCallback? onTap;
  const _InfoItem({required this.title, required this.icon, this.subTitle, this.onTap, this.moreInfoToShow});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: ColorManager.primarySwatch[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.string(icon!, color: ColorManager.primary, width: 20.w, height: 20.h),
            ),
          15.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
                if (subTitle != null) ...[
                  4.verticalSpace,
                  Text(subTitle!, style: Theme.of(context).textTheme.headlineMedium),
                ],
                if (moreInfoToShow != null) ...[
                  4.verticalSpace,
                  Text(moreInfoToShow!, style: Theme.of(context).textTheme.headlineMedium),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
