import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class UserPreferences extends StatelessWidget {
  final List<String> userPreferences;
  const UserPreferences({super.key, required this.userPreferences});

  @override
  Widget build(BuildContext context) {
    if (userPreferences.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 32.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: userPreferences.length,
        separatorBuilder: (_, __) => 8.horizontalSpace,
        itemBuilder: (context, index) =>
            _buildUserPreferenceItem(userPreference: userPreferences[index], context: context),
      ),
    );
  }

  Widget _buildUserPreferenceItem({required String userPreference, required BuildContext context}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(color: ColorManager.blackSwatch[3], borderRadius: BorderRadius.circular(8)),
      child: Text(
        userPreference,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorManager.black),
      ),
    );
  }
}
