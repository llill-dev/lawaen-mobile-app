import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';

import 'widgets/category_item_details/basic_info_section.dart';
import 'widgets/category_item_details/headr_image_section.dart';
import 'widgets/category_item_details/info_section.dart';
import 'widgets/category_item_details/loctaion_item_section.dart';
import 'widgets/category_item_details/photos_section.dart';
import 'widgets/category_item_details/section_selector.dart';

@RoutePage()
class CategoryItemDetialsScreen extends StatefulWidget {
  const CategoryItemDetialsScreen({super.key});

  @override
  State<CategoryItemDetialsScreen> createState() => _CategoryItemDetialsScreenState();
}

class _CategoryItemDetialsScreenState extends State<CategoryItemDetialsScreen> {
  int selectedIndex = 0;
  final List<String> sections = ["Photos", "Information", "Location", "Services"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        clipBehavior: Clip.none,
        slivers: [
          const HeaderImageSection(),
          buildSpace(height: 8.h),
          const BasicInfoSection(),
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
                children: const [
                  PhotosSection(
                    photos: [ImageManager.itmePhoto, ImageManager.place, ImageManager.place],
                    mainPhoto: ImageManager.itmePhoto,
                    maxDisplayPhotos: 3,
                  ),
                  InfoSection(),
                  LocationItemSection(),
                  // ServicesSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
