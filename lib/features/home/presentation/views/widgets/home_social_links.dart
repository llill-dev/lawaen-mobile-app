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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.contactState == RequestState.loading) {
          return SliverToBoxAdapter(child: _buildSkeletonLoader());
        }
        if (state.contactState == RequestState.error ||
            (state.contact.isEmpty && state.contactState == RequestState.success)) {
          return SliverToBoxAdapter(child: SizedBox.shrink());
        }
        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.followUsOnSocialMedia.tr(), style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 8.h),
              SizedBox(
                height: 40.h,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.contact.length,
                  separatorBuilder: (_, _) => SizedBox(width: 20.w),
                  itemBuilder: (context, index) => _buildLinkItem(item: state.contact[index]),
                ),
              ),
            ],
          ).horizontalPadding(padding: 16.w),
        );
      },
    );
  }

  Widget _buildLinkItem({required ContactModel item}) {
    return GestureDetector(
      onTap: () => launchURL(link: item.url),
      child: Center(
        child: CachedImage(url: item.image, width: 32.r, height: 32.r),
      ),
    );
  }
}

Widget _buildSkeletonLoader() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: SizedBox(
      height: 0.12.sh,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (_, _) => const _ContactSkeleton(),
      ),
    ),
  );
}

class _ContactSkeleton extends StatelessWidget {
  const _ContactSkeleton();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          Container(
            width: 25.r,
            height: 25.r,
            decoration: BoxDecoration(shape: BoxShape.circle, color: ColorManager.lightGrey),
          ),
        ],
      ),
    );
  }
}
