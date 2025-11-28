import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class ViewAllCategories extends StatelessWidget {
  const ViewAllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (p, c) => p.categoriesState != c.categoriesState || p.categories.length != c.categories.length,
        builder: (context, state) {
          if (state.categoriesState == RequestState.error) {
            return const SizedBox.shrink();
          }

          final isReady = state.categoriesState == RequestState.success;

          return Row(
            children: [
              Text(LocaleKeys.whatWouldLikeToFind.tr(), style: Theme.of(context).textTheme.headlineMedium),
              const Spacer(),
              GestureDetector(
                onTap: isReady ? () => context.router.push(CategoryRoute(categories: state.categories)) : null,
                child: Text(
                  LocaleKeys.viewAll.tr(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.primary),
                ),
              ),
            ],
          ).horizontalPadding(padding: 16.w);
        },
      ),
    );
  }
}
