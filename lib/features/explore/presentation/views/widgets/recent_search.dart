import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class RecentSearch extends StatelessWidget {
  final List<String> recentSearch;
  final ValueChanged<String> onTap;
  const RecentSearch({super.key, required this.recentSearch, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (recentSearch.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.watch_later_outlined, color: ColorManager.grey, size: 16.r),
            8.horizontalSpace,
            Expanded(
              child: Text(
                LocaleKeys.recent_search.tr(),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorManager.grey),
              ),
            ),
          ],
        ),
        16.verticalSpace,
        SizedBox(
          height: 32.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: recentSearch.length,
            separatorBuilder: (_, __) => 8.horizontalSpace,
            itemBuilder: (context, index) => buildRecentSearchItem(searchText: recentSearch[index], context: context),
          ),
        ),
      ],
    );
  }

  Widget buildRecentSearchItem({required String searchText, required BuildContext context}) {
    return GestureDetector(
      onTap: () => onTap(searchText),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(color: ColorManager.blackSwatch[3], borderRadius: BorderRadius.circular(8)),
        child: Text(searchText, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorManager.black)),
      ),
    );
  }
}
