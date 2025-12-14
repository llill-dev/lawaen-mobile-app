import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/error_view.dart';
import 'package:lawaen/app/core/widgets/loading_widget.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/profile/data/models/profile_page_model.dart';
import 'package:lawaen/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';

@RoutePage()
class ProfileStaticScreen extends StatefulWidget {
  final String pageId;

  const ProfileStaticScreen({super.key, required this.pageId});

  @override
  State<ProfileStaticScreen> createState() => _ProfileStaticScreenState();
}

class _ProfileStaticScreenState extends State<ProfileStaticScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfilePage(id: widget.pageId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(color: ColorManager.black),
        title: BlocSelector<ProfileCubit, ProfileState, String?>(
          selector: (state) => state.getProfilePage?.name,
          builder: (context, title) {
            return Text(
              title ?? '',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(color: ColorManager.primary),
            );
          },
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        buildWhen: (prev, curr) =>
            prev.getProfilePageState != curr.getProfilePageState || prev.getProfilePage != curr.getProfilePage,
        builder: (context, state) {
          switch (state.getProfilePageState) {
            case RequestState.loading:
              return const LoadingWidget();

            case RequestState.error:
              return _ProfilePageError(
                message: state.getProfilePageError ?? '',
                onRetry: () => context.read<ProfileCubit>().getProfilePage(id: widget.pageId),
              );

            case RequestState.success:
              return _ProfilePageContent(page: state.getProfilePage!);

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _ProfilePageContent extends StatelessWidget {
  final ProfilePageModel page;

  const _ProfilePageContent({required this.page});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorManager.primary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: page.content.map(_buildContentItem).toList(),
        ),
      ),
    );
  }

  Widget _buildContentItem(Content item) {
    switch (item.type.toLowerCase()) {
      case 'title':
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            item.value,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        );

      case 'description':
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Text(
            item.value,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}

class _ProfilePageError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ProfilePageError({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ErrorView(onRetry: onRetry, errorMsg: message),
    );
  }
}
