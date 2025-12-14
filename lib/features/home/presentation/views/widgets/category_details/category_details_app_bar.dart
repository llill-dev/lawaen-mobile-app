import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/features/home/presentation/cubit/category_details_cubit/category_details_cubit.dart';
import 'package:lawaen/features/home/presentation/views/widgets/home_app_bar/home_app_bar_container.dart';
import 'package:lawaen/features/home/presentation/views/widgets/home_app_bar/home_app_bar_header_section.dart';

import '../../../../../../app/core/widgets/custom_text_field.dart';
import '../../../../../../app/resources/assets_manager.dart';
import '../../../../../../generated/locale_keys.g.dart';

class CategoryDetailsAppBar extends StatelessWidget {
  const CategoryDetailsAppBar({
    super.key,
    required this.categoryId,
    this.secondCategoryNames,
    this.formCategory = false,
  });

  final String? categoryId;
  final bool formCategory;
  final String? secondCategoryNames;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CategoryDetailsCubit>();
    final TextEditingController controller = TextEditingController();
    return SliverToBoxAdapter(
      child: HomeAppBarContainer(
        child: Column(
          children: [
            const HomeAppBarHeaderSection(),
            SizedBox(height: 12.h),

            CustomTextField(
              controller: controller,
              hint: secondCategoryNames != null && formCategory
                  ? "${LocaleKeys.searchFor.tr()} ${secondCategoryNames!}..."
                  : LocaleKeys.homeSearchBarHit.tr(),
              hitStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.grey),
              //prefixIcon: SvgPicture.asset(IconManager.search).horizontalPadding(padding: 12),
              suffixIcon: GestureDetector(
                onTap: () {
                  final text = controller.text.trim();
                  if (text.isNotEmpty) {
                    cubit.initCategoryDetails(mainCategoryId: categoryId, search: text, isGetAll: categoryId == null);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: SvgPicture.asset(IconManager.search),
                ),
              ),
              fillColor: Colors.white,
              horizontalContentPadding: 16,
              verticalContentPadding: 12,
              borderRadius: 16.0,
              onFieldSubmitted: (value) {
                if (value.trim().isNotEmpty && controller.text.trim().isNotEmpty) {
                  cubit.initCategoryDetails(
                    mainCategoryId: categoryId,
                    search: controller.text.trim(),
                    isGetAll: categoryId == null,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
