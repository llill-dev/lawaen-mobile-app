import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/widgets/custom_text_field.dart';
import 'package:lawaen/app/core/widgets/error_view.dart';
import 'package:lawaen/app/core/widgets/loading_widget.dart';
import 'package:lawaen/app/core/widgets/primary_back_button.dart';
import 'package:lawaen/app/core/widgets/skeletons/shimmer_container.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/features/home/presentation/cubit/messages_cubit/messages_cubit.dart';

import '../../../../app/resources/color_manager.dart';
import 'widgets/feedback/chat_bubble.dart';

@RoutePage()
class FeedbackChatScreen extends StatefulWidget {
  final String itemId;
  final String secondCategoryId;
  const FeedbackChatScreen({super.key, required this.itemId, required this.secondCategoryId});

  @override
  State<FeedbackChatScreen> createState() => _FeedbackChatScreenState();
}

class _FeedbackChatScreenState extends State<FeedbackChatScreen> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    context.read<MessagesCubit>().fetchMessages(secondCategoryId: widget.secondCategoryId, itemId: widget.itemId);

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<MessagesCubit>().loadMoreMessages(secondCategoryId: widget.secondCategoryId, itemId: widget.itemId);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final currentUserId = getIt<AppPreferences>().getUserInfo()?.id;

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: _buildInputBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: BlocBuilder<MessagesCubit, MessagesState>(
            builder: (context, state) {
              if (state.isLoading) {
                return _buildSkeleton();
              }

              if (state.error != null) {
                return ErrorView(
                  errorMsg: state.error,
                  onRetry: () {
                    context.read<MessagesCubit>().fetchMessages(
                      secondCategoryId: widget.secondCategoryId,
                      itemId: widget.itemId,
                    );
                  },
                );
              }

              if (state.messages.isEmpty) {
                return const Center(child: Text("No messages yet"));
              }

              return CustomScrollView(
                controller: _scrollController,
                reverse: true,
                slivers: [
                  SliverToBoxAdapter(child: PrimaryBackButton(iconOnlay: true)),

                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final message = state.messages[index];
                      final isSender = message.userId == currentUserId;

                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: ChatBubble(isSender: isSender, message: message.message),
                      );
                    }, childCount: state.messages.length),
                  ),

                  if (state.isLoadingMore)
                    const SliverToBoxAdapter(
                      child: Padding(padding: EdgeInsets.all(12), child: LoadingWidget()),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSkeleton() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (_, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: ChatBubbleSkeleton(isSender: index.isEven),
        );
      },
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
        boxShadow: [BoxShadow(color: ColorManager.black.withValues(alpha: .25), blurRadius: 14, spreadRadius: 3)],
      ),
      child: Row(
        children: [
          Expanded(child: CustomTextField(hint: "type any thing... ", withBorder: false)),
          8.horizontalSpace,
          CircleAvatar(
            backgroundColor: ColorManager.primary,
            child: SvgPicture.asset(
              IconManager.sendFeedback,
              colorFilter: ColorFilter.mode(ColorManager.white, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubbleSkeleton extends StatelessWidget {
  final bool isSender;
  const ChatBubbleSkeleton({super.key, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isSender ? TextDirection.ltr : TextDirection.rtl,
      child: Row(
        children: [
          const ShimmerBox(width: 32, height: 32),
          10.horizontalSpace,
          ShimmerBox(width: 220.w, height: 50.h, borderRadius: BorderRadius.circular(16)),
        ],
      ),
    );
  }
}
