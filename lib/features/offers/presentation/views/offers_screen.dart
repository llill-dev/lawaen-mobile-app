import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';

import '../../../home/presentation/views/widgets/category_details/filter_category_info.dart';
import 'widgets/offers_circular_action_button.dart';
import 'widgets/offers_details_bottom_sheet.dart';

@RoutePage()
class OffersScreen extends StatelessWidget {
  final List<OffersModel> offers = [
    OffersModel(
      image: ImageManager.offers,
      title: "products 1",
      description:
          "Life beckons at Banyan Tree, your sanctuary for the senses. Nestled in the heart of Bluewaters Island, our resort offers unparalleled views of the Arabian Gulf. Experience world-class hospitality with state-of-the-art facilities and exceptional service.",
    ),
    OffersModel(
      image: ImageManager.offers,
      title: "products 2",
      description:
          "ayham 2 Life beckons at Banyan Tree, your sanctuary for the senses. Nestled in the heart of Bluewaters Island, our resort offers unparalleled views of the Arabian Gulf. Experience world-class hospitality with state-of-the-art facilities and exceptional service.",
    ),
  ];
  OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: offers.length,
          itemBuilder: (context, index) {
            final offer = offers[index];
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(offer.image, fit: BoxFit.cover),
                Positioned(
                  right: 24.w,
                  bottom: 100.h,
                  child: Column(
                    children: [
                      OffersCircularActionButton(
                        icon: IconManager.offersDetails,
                        onTap: () => _showOfferDetailsBottomSheet(context, offer),
                      ),
                      SizedBox(height: 16.h),
                      OffersCircularActionButton(
                        icon: IconManager.offersFilter,
                        onTap: () => _showFilterBottomSheet(context),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showOfferDetailsBottomSheet(BuildContext context, OffersModel offer) {
    showModalBottomSheet<void>(
      showDragHandle: true,
      context: context,
      backgroundColor: ColorManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (context) {
        return OffersDetailsBottomSheet(offer: offer);
      },
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: ColorManager.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) {
        final List<String> subCategories = ["Food", "Cars", "Electronics", "Restaurants", "Travel"];
        final ValueNotifier<Set<String>> selected = ValueNotifier<Set<String>>({});
        return FilterCategoryInfo(selected: selected, subCategories: subCategories);
      },
    );
  }
}

class OffersModel {
  final String image;
  final String title;
  final String description;
  final String? price;
  OffersModel({required this.image, required this.title, required this.description, this.price});
}
