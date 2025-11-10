import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/presentation/views/widgets/popular_places/popular_places.dart';

import '../../../../app/resources/color_manager.dart';
import '../../../../generated/locale_keys.g.dart';
import 'widgets/add_your_business.dart';
import 'widgets/category/category_section.dart';
import 'widgets/home_app_bar/home_app_bar.dart';
import 'widgets/location_section.dart';
import 'widgets/upcoming_events/upcoming_events.dart';
import 'widgets/weather_and_map/weather_and_map.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: const HomeAppBar()),
          buildSpace(),
          SliverToBoxAdapter(child: const LocationSection()),
          buildSpace(),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Text(LocaleKeys.whatWouldLikeToFind.tr(), style: Theme.of(context).textTheme.headlineMedium),
                Spacer(),
                GestureDetector(
                  onTap: () => context.router.push(CategoryRoute()),
                  child: Text(
                    LocaleKeys.viewAll.tr(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.primary),
                  ),
                ),
              ],
            ).horizontalPadding(padding: 16.w),
          ),
          buildSpace(),
          CategorySection(),
          buildSpace(),
          SliverToBoxAdapter(child: UpcomingEvents()),
          buildSpace(),
          SliverToBoxAdapter(child: AddYourBusiness().horizontalPadding(padding: 40.w)),
          buildSpace(),
          SliverToBoxAdapter(child: WeatherAndMap().horizontalPadding(padding: 16.w)),
          buildSpace(),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Text('Popular Places', style: Theme.of(context).textTheme.headlineMedium),
                Spacer(),
                Text(
                  'view All',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.primary),
                ),
              ],
            ).horizontalPadding(padding: 16.w),
          ),
          PopularPlaces(),
          buildSpace(height: 50.h),
        ],
      ),
    );
  }
}
