import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/error_view.dart';
import 'package:lawaen/app/core/widgets/skeletons/redacted_box.dart';
import 'package:lawaen/app/core/widgets/skeletons/shimmer_container.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:lawaen/features/profile/presentation/views/widget/profile_body/settings_itme.dart';

class ProfilePagesSection extends StatelessWidget {
  const ProfilePagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCubit, ProfileState, RequestState>(
      selector: (state) => state.getProfilePagesState,
      builder: (context, state) {
        switch (state) {
          case RequestState.loading:
            return const _ProfilePagesSkeleton();

          case RequestState.error:
            return _ProfilePagesError(
              onRetry: () => context.read<ProfileCubit>().retryProfilePages(),
              errorMsg: context.read<ProfileCubit>().state.getProfilePagesError,
            );

          case RequestState.success:
            return const _ProfilePagesList();

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class _ProfilePagesList extends StatelessWidget {
  const _ProfilePagesList();

  @override
  Widget build(BuildContext context) {
    final pages = context.select((ProfileCubit cubit) => cubit.state.getProfilePages);

    if (pages.isEmpty) return const SizedBox.shrink();

    return Column(
      children: pages.map((page) {
        return SettingsItme(
          title: page.name,
          icon: page.image,
          fromServer: true,
          iconColor: ColorManager.primary,
          hasDivider: pages.indexOf(page) != pages.length - 1,
          onTap: () {
            context.router.push(ProfileStaticRoute(pageId: page.id));
          },
        );
      }).toList(),
    );
  }
}

class _ProfilePagesSkeleton extends StatelessWidget {
  const _ProfilePagesSkeleton();

  @override
  Widget build(BuildContext context) {
    return RedactedBox(
      child: Column(
        children: List.generate(
          4,
          (index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [ShimmerBox(width: 40, height: 40), SizedBox(width: 16), ShimmerBox(width: 120, height: 14)],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfilePagesError extends StatelessWidget {
  final VoidCallback onRetry;
  final String? errorMsg;

  const _ProfilePagesError({required this.onRetry, this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return ErrorView(onRetry: onRetry, errorMsg: errorMsg);
  }
}
