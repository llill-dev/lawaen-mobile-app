import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/alert_dialog.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<HomeCubit>();
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: cubit..getCities(),
      listener: (context, state) {
        if (state is GetCitiesError) {
          alertDialog(context: context, message: state.errorMessage, onConfirm: () => cubit.getCities());
        }
      },
      builder: (context, state) {
        if (state is GetCitiesSuccess) {
          final locations = state.cities;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SizedBox(
              height: 0.12.sh,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: locations.length,
                separatorBuilder: (_, _) => SizedBox(width: 16.w),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Expanded(
                        child: AspectRatio(aspectRatio: 1, child: CachedNetworkImage(imageUrl: locations[index].image)),
                      ),
                      SizedBox(height: 8.h),
                      Text(locations[index].name, style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  );
                },
              ),
            ),
          );
        }
        if (state is GetCitiesError) {
          return SizedBox.shrink();
        }
        return _CitiesLoadingWidget();
      },
    );
  }
}

class _CitiesLoadingWidget extends StatelessWidget {
  const _CitiesLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      containersColor: ColorManager.lightGrey,
      enabled: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SizedBox(
          height: 0.12.sh,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (_, _) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: 70.h,
                    width: 70.w,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: ColorManager.lightGrey),
                  ),
                  SizedBox(height: 8.h),
                  Text("this is a test", style: Theme.of(context).textTheme.headlineSmall),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
