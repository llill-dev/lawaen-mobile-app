import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../app/resources/color_manager.dart';

class FilterCategoryInfo extends StatelessWidget {
  const FilterCategoryInfo({super.key, required this.selected, required this.subCategories});

  final ValueNotifier<Set<String>> selected;
  final List<String> subCategories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder<Set<String>>(
            valueListenable: selected,
            builder: (context, selectedItems, _) {
              return Column(
                children: subCategories.map((name) {
                  final isSelected = selectedItems.contains(name);
                  return GestureDetector(
                    onTap: () {
                      final newSet = Set<String>.from(selectedItems);
                      if (isSelected) {
                        newSet.remove(name);
                      } else {
                        newSet.add(name);
                      }
                      selected.value = newSet;
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        children: [
                          Container(
                            width: 12.w,
                            height: 12.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? ColorManager.green : ColorManager.lightGrey,
                            ),
                          ),
                          10.horizontalSpace,
                          Text(name, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
