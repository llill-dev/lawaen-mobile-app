import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/functions/url_launcher.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/cached_image.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/data/models/contact_model.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:lawaen/generated/locale_keys.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeSocialLinks extends StatelessWidget {
  const HomeSocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.contactState == RequestState.loading) {
            return _SocialLinksSkeleton();
          }

          if (state.contactState == RequestState.error || state.contact.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.followUsOnSocialMedia.tr(), style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: state.contact.map((item) => _buildLinkItem(item: item)).toList(),
              ),
            ],
          ).horizontalPadding(padding: 16.w);
        },
      ),
    );
  }

  Widget _buildLinkItem({required ContactModel item}) {
    return GestureDetector(
      onTap: () => launchURL(link: item.url),
      child: CachedImage(url: item.image, width: 40.r, height: 40.r),
    );
  }
}

class _SocialLinksSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Skeletonizer(
        enabled: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            4,
            (_) => Container(
              width: 25.r,
              height: 25.r,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorManager.lightGrey),
            ),
          ),
        ),
      ),
    );
  }
}
