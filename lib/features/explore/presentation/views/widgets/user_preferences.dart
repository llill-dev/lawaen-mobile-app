import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/explore/data/models/user_preferences_model.dart';

class UserPreferences extends StatelessWidget {
  final List<UserPreferencesModel> preferences;
  final String? selectedCategoryId;
  final ValueChanged<String> onSelect;

  const UserPreferences({
    super.key,
    required this.preferences,
    required this.selectedCategoryId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: preferences.length,
        separatorBuilder: (_, _) => 8.horizontalSpace,
        itemBuilder: (_, index) {
          final item = preferences[index];
          final isSelected = item.id == selectedCategoryId;

          return GestureDetector(
            onTap: () => onSelect(item.id),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isSelected ? ColorManager.primary : ColorManager.blackSwatch[3],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item.name,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(color: isSelected ? ColorManager.white : ColorManager.black),
              ),
            ),
          );
        },
      ),
    );
  }
}
