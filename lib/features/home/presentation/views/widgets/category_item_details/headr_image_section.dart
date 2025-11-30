import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/helper/network_icon.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/data/models/category_item_model.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class HeaderImageSection extends StatefulWidget {
  final ItemData itemData;
  const HeaderImageSection({super.key, required this.itemData});

  @override
  State<HeaderImageSection> createState() => _HeaderImageSectionState();
}

class _HeaderImageSectionState extends State<HeaderImageSection> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool isExpanded = false;

  void _toggleDropdown(BuildContext context) {
    if (isExpanded) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } else {
      _overlayEntry = _createOverlayEntry(context);
      Overlay.of(context).insert(_overlayEntry!);
    }
    setState(() => isExpanded = !isExpanded);
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderSliverToBoxAdapter renderBox = context.findRenderObject() as RenderSliverToBoxAdapter;
    Offset position = renderBox.child!.localToGlobal(Offset.zero);
    final String workingHours = widget.itemData.ui?.workingHours?.label ?? "";
    final List<Map<String, String>> workHours = [
      {"day": LocaleKeys.sunday.tr(), "hours": workingHours},
      {"day": LocaleKeys.monday.tr(), "hours": workingHours},
      {"day": LocaleKeys.tuesday.tr(), "hours": workingHours},
      {"day": LocaleKeys.wednesday.tr(), "hours": workingHours},
      {"day": LocaleKeys.thursday.tr(), "hours": workingHours},
      {"day": LocaleKeys.friday.tr(), "hours": workingHours},
      {"day": LocaleKeys.saturday.tr(), "hours": workingHours},
    ];

    return OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx + 15,
        top: position.dy + renderBox.child!.size.height - 40,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, 30.h),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(10),
            color: ColorManager.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: workHours.map((t) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: Row(
                      children: [
                        Text(
                          t["day"]!,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.black),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          t["hours"]!,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.grey),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isOpenNow = widget.itemData.ui?.workingHours?.isOpenNow == true;
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          // Background image + gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorManager.categoryItemDetailsGradinet.withValues(alpha: 0.1),
                  ColorManager.categoryItemDetailsGradinet.withValues(alpha: 0.3),
                  ColorManager.categoryItemDetailsGradinet,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: widget.itemData.item?.images == null || widget.itemData.item!.images!.isEmpty
                ? Image.asset(
                    ImageManager.emptyPhoto,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : AspectRatio(
                    aspectRatio: 16 / 9,
                    child: NetworkIcon(
                      url: widget.itemData.item!.images!.first,
                      fit: BoxFit.cover,

                      width: double.infinity,
                    ),
                  ),
          ),

          // Back button
          Positioned(
            top: 50.h,
            left: 15.w,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: CircleAvatar(
                backgroundColor: ColorManager.black.withValues(alpha: .5),
                child: Icon(Icons.arrow_back, color: ColorManager.white, size: 18.r),
              ),
            ),
          ),

          // Bottom info + dropdown trigger
          Positioned(
            bottom: 15,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorManager.black.withValues(alpha: 0.6),
                  ),
                  child: Text(
                    widget.itemData.item?.name ?? "",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.white),
                  ),
                ),
                10.verticalSpace,
                CompositedTransformTarget(
                  link: _layerLink,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _toggleDropdown(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: isOpenNow ? ColorManager.green : ColorManager.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                isOpenNow ? LocaleKeys.openNow.tr() : LocaleKeys.closedNow.tr(),
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.white),
                              ),
                              Icon(
                                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                color: ColorManager.white,
                                size: 18.r,
                              ),
                            ],
                          ),
                        ),
                      ),
                      8.horizontalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: ColorManager.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.itemData.ui?.workingHours?.label ?? "",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.lightGrey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }
}
