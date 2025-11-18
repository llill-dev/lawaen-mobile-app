import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class RecentSearch extends StatelessWidget {
  const RecentSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.watch_later_outlined, color: ColorManager.grey, size: 16.r),
            8.horizontalSpace,
            Text(
              LocaleKeys.recent_search.tr(),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorManager.grey),
            ),
          ],
        ),
        16.verticalSpace,
        Row(
          children: List.generate(3, (index) => buildRecentSearchItem(searchText: 'Luxury hotels', context: context)),
        ),
      ],
    );
  }

  Widget buildRecentSearchItem({required String searchText, required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(color: ColorManager.blackSwatch[3], borderRadius: BorderRadius.circular(8)),
      child: Text(searchText, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorManager.black)),
    );
  }
}
