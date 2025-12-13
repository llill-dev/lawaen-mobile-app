import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/helper/network_icon.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/empty_view.dart';
import 'package:lawaen/app/core/widgets/error_view.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/offers/data/models/offer_model.dart';
import 'package:lawaen/features/offers/presentation/cubit/offers_cubit/offers_cubit.dart';
import 'package:lawaen/features/offers/presentation/views/widgets/offers_filter_bottom_sheet.dart';
import 'package:lawaen/generated/locale_keys.g.dart';
import 'package:shimmer/shimmer.dart';

import 'widgets/offers_circular_action_button.dart';
import 'widgets/offers_details_bottom_sheet.dart';

@RoutePage()
class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getOffers();
  }

  void _getOffers() {
    final cubit = context.read<OffersCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cubit.state.offerTypes.isNotEmpty) {
        cubit.updateSelectedTypes(cubit.state.offerTypes.map((e) => e.id).toSet());
        cubit.getOffersForSelectedTypes();
      }
    });
  }

  Future<void> _preloadImages(List<OfferModel> offers) async {
    for (final offer in offers) {
      try {
        await precacheImage(NetworkImage(offer.image), context);
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<OffersCubit, OffersState>(
      listener: (context, state) async {
        if (state.offersState == RequestState.success) {
          await _preloadImages(state.offers);
        }
      },
      builder: (context, state) {
        if (state.offersState == RequestState.loading) {
          return const _OffersShimmer();
        }
        if (state.offersState == RequestState.error || state.offerTypesError != null) {
          ErrorView(errorMsg: state.offersError, onRetry: _getOffers);
        }

        final offers = state.offers;

        if (offers.isEmpty) {
          return Center(
            child: EmptyView(message: LocaleKeys.noOffersFound.tr(), icon: IconManager.emptySearch),
          );
        }

        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: offers.length,
              itemBuilder: (context, index) {
                final offer = offers[index];

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    NetworkIcon(url: offer.image, fit: BoxFit.cover),

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
      },
    );
  }

  void _showOfferDetailsBottomSheet(BuildContext context, OfferModel offer) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      backgroundColor: ColorManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (_) => OffersDetailsBottomSheet(offer: offer),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      backgroundColor: ColorManager.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (_) => const OffersFilterBottomSheet(),
    );
  }
}

class _OffersShimmer extends StatelessWidget {
  const _OffersShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorManager.grey.withValues(alpha: 0.5),
      highlightColor: ColorManager.lightGrey,
      child: Container(
        color: ColorManager.grey.withValues(alpha: 0.5),
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
