import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import '../../../../../../app/resources/assets_manager.dart';

class HeaderImageSection extends StatefulWidget {
  const HeaderImageSection({super.key});

  @override
  State<HeaderImageSection> createState() => _HeaderImageSectionState();
}

class _HeaderImageSectionState extends State<HeaderImageSection> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool isExpanded = false;

  // Example working hours list
  final List<Map<String, String>> workHours = [
    {"day": "Sunday", "hours": "09:00 AM - 06:00 PM"},
    {"day": "Monday", "hours": "09:00 AM - 06:00 PM"},
    {"day": "Tuesday", "hours": "09:00 AM - 06:00 PM"},
    {"day": "Wednesday", "hours": "09:00 AM - 06:00 PM"},
    {"day": "Thursday", "hours": "09:00 AM - 06:00 PM"},
    {"day": "firady", "hours": "09:00 AM - 06:00 PM"},
    {"day": "Saturday", "hours": "09:00 AM - 06:00 PM"},
  ];

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
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          // Background image + gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorManager.categoryItemDetailsGradinet.withValues(alpha: 0.5),
                  ColorManager.categoryItemDetailsGradinet.withValues(alpha: 0.7),
                  ColorManager.categoryItemDetailsGradinet,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: Image.asset(ImageManager.catItem, fit: BoxFit.cover, width: double.infinity),
            ),
          ),

          // Back button
          Positioned(
            top: 50.h,
            left: 15.w,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Icon(Icons.arrow_back, color: ColorManager.white, size: 18.r),
            ),
          ),

          // Bottom info + dropdown trigger
          Positioned(
            bottom: 15,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Banyan Tree Damascus",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorManager.white),
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
                          decoration: BoxDecoration(color: ColorManager.red, borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Text(
                                "Closed now",
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
                      Text(
                        "9:00AM - 6:00PM",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.lightGrey),
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
