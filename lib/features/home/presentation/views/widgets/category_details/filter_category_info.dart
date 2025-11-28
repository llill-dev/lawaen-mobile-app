import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import '../../../../../../app/resources/color_manager.dart';

class FilterCategoryInfo extends StatefulWidget {
  final List<SecondCategory> subCategories;
  final String? initialSelectedId;

  const FilterCategoryInfo({super.key, required this.subCategories, this.initialSelectedId});

  @override
  State<FilterCategoryInfo> createState() => _FilterCategoryInfoState();
}

class _FilterCategoryInfoState extends State<FilterCategoryInfo> {
  String? _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialSelectedId;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: widget.subCategories.map((sub) {
                    final isSelected = _selectedId == sub.id;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedId = sub.id;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          children: [
                            Container(
                              width: 16.w,
                              height: 16.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? ColorManager.green : ColorManager.lightGrey,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: 8.w,
                                  height: 8.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected ? ColorManager.green : Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                            10.horizontalSpace,
                            Expanded(child: Text(sub.name, style: Theme.of(context).textTheme.bodyMedium)),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            24.verticalSpace,

            PrimaryButton(
              text: LocaleKeys.apply.tr(),
              onPressed: () {
                Navigator.of(context).pop(_selectedId);
              },
            ),
          ],
        ),
      ),
    );
  }
}
