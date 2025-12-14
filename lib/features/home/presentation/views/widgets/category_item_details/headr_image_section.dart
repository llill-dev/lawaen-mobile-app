import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/helper/network_icon.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/alert_dialog.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/resources/language_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/data/models/category_item_model.dart';
import 'package:lawaen/features/home/presentation/cubit/category_item_details_cubit/category_item_detials_cubit.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class HeaderSection extends StatefulWidget {
  final ItemData itemData;
  final String categoryId;
  final String itemId;
  const HeaderSection({super.key, required this.itemData, required this.categoryId, required this.itemId});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool isExpanded = false;
  final currentLang = getIt<AppPreferences>().getAppLanguage();

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  void _toggleDropdown() {
    if (isExpanded) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } else {
      _overlayEntry = _buildOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
    setState(() => isExpanded = !isExpanded);
  }

  OverlayEntry _buildOverlayEntry() {
    final workingHours = widget.itemData.ui?.workingHours?.label ?? "";

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
      builder: (_) => Positioned(
        top: MediaQuery.of(context).padding.top + 180.h,
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
                children: workHours.map((t) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
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
    final item = widget.itemData.item;
    bool isOpenNow = widget.itemData.ui?.workingHours?.isOpenNow == true;
    bool isGuest = getIt<AppPreferences>().isGuest;

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              Positioned.fill(
                child: item?.images?.isEmpty ?? true
                    ? Image.asset(ImageManager.emptyPhoto, fit: BoxFit.cover, width: double.infinity)
                    : NetworkIcon(url: item!.images!.first, fit: BoxFit.cover, width: double.infinity),
              ),

              // Back button
              Positioned(
                top: 20.h,
                left: 15.w,

                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: CircleAvatar(
                    backgroundColor: ColorManager.black.withValues(alpha: 0.5),
                    child: Icon(
                      currentLang == english ? Icons.arrow_back : Icons.arrow_forward,
                      color: ColorManager.white,
                      size: 18.r,
                    ),
                  ),
                ),
              ),

              Positioned(
                right: 15.w,
                top: 20.h,
                child: BlocBuilder<CategoryItemDetialsCubit, CategoryItemDetialsState>(
                  buildWhen: (prev, curr) =>
                      prev.saved != curr.saved || prev.toggleFavoriteState != curr.toggleFavoriteState,
                  builder: (context, state) {
                    final bool isFavorite = state.toggleFavoriteState == RequestState.success
                        ? state.saved
                        : (widget.itemData.item?.flags?.isSaved ?? false);

                    return GestureDetector(
                      onTap: state.toggleFavoriteState == RequestState.loading
                          ? null
                          : () {
                              if (isGuest) {
                                alertDialog(
                                  context: context,
                                  message: LocaleKeys.signInToContinue.tr(),
                                  onConfirm: () => context.router.push(LoginRoute()),
                                  onCancel: () => (),
                                  approveButtonTitle: LocaleKeys.signIn.tr(),
                                  rejectButtonTitle: LocaleKeys.cancel.tr(),
                                );
                                return;
                              }
                              context.read<CategoryItemDetialsCubit>().toggleFavorite(
                                itemId: widget.itemId,
                                secondCategoryId: widget.categoryId,
                              );
                            },
                      child: CircleAvatar(
                        backgroundColor: ColorManager.black.withValues(alpha: 0.5),
                        child: state.toggleFavoriteState == RequestState.loading
                            ? SizedBox(
                                width: 16.r,
                                height: 16.r,
                                child: CircularProgressIndicator(strokeWidth: 2, color: ColorManager.white),
                              )
                            : Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
                                color: isFavorite ? ColorManager.red : ColorManager.white,
                                size: 18.r,
                              ),
                      ),
                    );
                  },
                ),
              ),

              // Bottom info + dropdown
              Positioned(
                bottom: 15.h,
                left: currentLang == english ? 15.w : null,
                right: currentLang == arabic ? 15.w : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name Tag
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

                    // Status + Hours
                    CompositedTransformTarget(
                      link: _layerLink,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: _toggleDropdown,
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
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall?.copyWith(color: ColorManager.white),
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
        ),
      ],
    );
  }
}
