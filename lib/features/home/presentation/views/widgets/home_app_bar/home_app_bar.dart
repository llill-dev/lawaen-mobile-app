import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/routes/router.gr.dart';

import '../../../../../../app/core/widgets/custom_text_field.dart';
import '../../../../../../app/resources/assets_manager.dart';
import '../../../../../../generated/locale_keys.g.dart';
import 'home_app_bar_container.dart';
import 'home_app_bar_header_section.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeAppBarContainer(
      child: Column(
        children: [
          const HomeAppBarHeaderSection(),
          SizedBox(height: 12.h),
          CustomTextField(
            hint: LocaleKeys.homeSearchBarHit.tr(),
            hitStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.grey),
            prefixIcon: SvgPicture.asset(IconManager.search).horizontalPadding(padding: 12),
            fillColor: Colors.white,
            horizontalContentPadding: 16,
            verticalContentPadding: 12,
            borderRadius: 16.0,
            onTap: () => context.router.push(CategoryDetailsRoute()),
          ),
        ],
      ),
    );
  }
}
