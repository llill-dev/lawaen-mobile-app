import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/refresh_cubit/refresh_cubit.dart';
import 'package:lawaen/app/core/widgets/primary_back_button.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_item_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_mune/add_mune_item.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_services/no_item_container.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_services/services_cotianer.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@RoutePage()
class MuneManagerScreen extends StatelessWidget {
  const MuneManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: BlocBuilder<RefreshCubit, RefreshState>(
            bloc: getIt<RefreshCubit>(),
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PrimaryBackButton(withShadow: false, iconOnlay: true, iconSize: 18),
                      Text(
                        LocaleKeys.menuManagerTitle.tr(),
                        style: Theme.of(
                          context,
                        ).textTheme.headlineLarge!.copyWith(color: ColorManager.primary, fontSize: 22),
                      ),
                    ],
                  ).horizontalPadding(padding: 16.w),
                  24.verticalSpace,
                  AddMuneItem(),
                  24.verticalSpace,
                  Text(
                    LocaleKeys.menuManagerItems.tr(namedArgs: {'count': getIt<AddItemCubit>().items.length.toString()}),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ).horizontalPadding(padding: 16.w),
                  24.verticalSpace,
                  BlocBuilder<AddItemCubit, AddItemState>(
                    bloc: getIt<AddItemCubit>(),
                    builder: (context, state) {
                      if (state is AddItemUpdated && state.items.isNotEmpty) {
                        return Column(
                          children: List.generate(
                            state.items.length,
                            (index) => ServicesContainer(item: state.items[index], index: index),
                          ),
                        );
                      }
                      return NoItemAddedContainer(title: LocaleKeys.noMenuItemsYet.tr());
                    },
                  ),
                  24.verticalSpace,
                  PrimaryButton(text: LocaleKeys.done.tr()).horizontalPadding(padding: 16.w),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
