import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/features/home/presentation/views/widgets/category_section.dart';

import '../../../../app/resources/color_manager.dart';
import '../../../../generated/locale_keys.g.dart';
import 'widgets/home_app_bar/home_app_bar.dart';
import 'widgets/location_section.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: const HomeAppBar()),
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            SliverToBoxAdapter(child: const LocationSection()),
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Text(LocaleKeys.whatWouldLikeToFind.tr(), style: Theme.of(context).textTheme.headlineMedium),
                  Spacer(),
                  Text(
                    LocaleKeys.viewAll.tr(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.primary),
                  ),
                ],
              ).horizontalPadding(padding: 16.w),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            CategorySection(),
          ],
        ),
      ),
    );
  }
}
