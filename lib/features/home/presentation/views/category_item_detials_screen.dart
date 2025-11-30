import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/core/widgets/error_view.dart';
import 'package:lawaen/app/core/widgets/loading_widget.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/features/home/presentation/cubit/category_item_details_cubit/category_item_detials_cubit.dart';

import 'widgets/category_item_details/basic_info_section.dart';
import 'widgets/category_item_details/headr_image_section.dart';
import 'widgets/category_item_details/info_section.dart';
import 'widgets/category_item_details/loctaion_item_section.dart';
import 'widgets/category_item_details/photos_section.dart';
import 'widgets/category_item_details/section_selector.dart';
import 'widgets/category_item_details/services_section.dart';

@RoutePage()
class CategoryItemDetialsScreen extends StatefulWidget {
  const CategoryItemDetialsScreen({
    super.key,
    @PathParam('subCategoryId') required this.subCategoryId,
    @PathParam('itemId') required this.itemId,
  });

  final String subCategoryId;
  final String itemId;

  @override
  State<CategoryItemDetialsScreen> createState() => _CategoryItemDetialsScreenState();
}

class _CategoryItemDetialsScreenState extends State<CategoryItemDetialsScreen> {
  int selectedIndex = 0;
  final List<String> sections = ["Photos", "Information", "Location", "Services"];
  late final CategoryItemDetialsCubit cubit;
  @override
  void initState() {
    cubit = getIt<CategoryItemDetialsCubit>();
    cubit.getCategoryItems(itemId: widget.itemId, secondCategoryId: widget.subCategoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: BlocBuilder<CategoryItemDetialsCubit, CategoryItemDetialsState>(
          builder: (context, state) {
            if (state.categoryItemState == RequestState.loading) {
              return LoadingWidget();
            }
            if (state.categoryItemState == RequestState.error) {
              return ErrorView(
                withBackButton: true,
                errorMsg: state.globalError,
                onRetry: () => cubit.getCategoryItems(itemId: widget.itemId, secondCategoryId: widget.subCategoryId),
              );
            }
            return SafeArea(
              child: CustomScrollView(
                clipBehavior: Clip.none,
                slivers: [
                  HeaderImageSection(itemData: state.categoryItems!),
                  buildSpace(height: 8.h),

                  BasicInfoSection(itemData: state.categoryItems!),
                  buildSpace(),

                  SectionSelector(
                    sections: sections,
                    selectedIndex: selectedIndex,
                    onSectionSelected: (index) => setState(() => selectedIndex = index),
                  ),

                  buildSpace(),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: IndexedStack(
                        index: selectedIndex,
                        children: [
                          PhotosSection(photos: state.categoryItems!.item?.images ?? [], maxDisplayPhotos: 3),
                          InfoSection(itemData: state.categoryItems!),
                          LocationItemSection(
                            latitude: state.categoryItems!.item?.location?.latitude,
                            longitude: state.categoryItems!.item?.location?.longitude,
                          ),
                          ServicesSection(itemData: state.categoryItems!),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
