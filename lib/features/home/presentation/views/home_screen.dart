import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/core/widgets/alert_dialog.dart';
import 'package:lawaen/app/core/widgets/custom_refresh_indcator.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:lawaen/features/home/presentation/views/widgets/banners/home_banners.dart';
import 'package:lawaen/features/home/presentation/views/widgets/home_social_links.dart';
import 'package:lawaen/features/home/presentation/views/widgets/view_all_categories.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import 'widgets/home_app_bar/home_app_bar.dart';
import 'widgets/location_section.dart';
import 'widgets/category/category_section.dart';
import 'widgets/add_your_business.dart';
import 'widgets/upcoming_events/upcoming_events.dart';
import 'widgets/weather_and_map/weather_and_map.dart';
import 'widgets/popular_places/popular_places.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit cubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cubit = context.read<HomeCubit>();
    //cubit.initHome();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.extentAfter < 400) {
      cubit.getHomeData(isLoadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (prev, curr) => prev.globalError != curr.globalError && curr.globalError != null,
      listener: (context, state) {
        alertDialog(
          context: context,
          message: state.globalError!,
          isError: true,
          icon: Icons.wifi_tethering_error_rounded_outlined,
          onConfirm: () => cubit.initHome(),
          onCancel: () => cubit.clearGlobalError(),
        );
      },
      child: SafeArea(
        child: CustomRefreshIndcator(
          onRefresh: () async => cubit.initHome(),
          child: CustomScrollView(
            controller: _scrollController,
            clipBehavior: Clip.none,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: const HomeAppBar()),
              buildSpace(),
              const LocationSection(),

              buildSpace(),

              ViewAllCategories(),
              buildSpace(),
              const CategorySection(),

              buildSpace(),

              const UpcomingEvents(),
              buildSpace(),

              HomeBannersSection(isFirstHalf: true, height: 80.h),
              buildSpace(),

              const AddYourBusiness(),
              buildSpace(),

              const WeatherAndMap(),
              buildSpace(),

              const HomeSocialLinks(),
              buildSpace(),

              HomeBannersSection(isFirstHalf: false, height: 80.h),
              buildSpace(),

              SliverToBoxAdapter(
                child: Text(
                  LocaleKeys.popularPlaces.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ).horizontalPadding(padding: 16.w),
              ),

              const PopularPlaces(),
              buildSpace(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
