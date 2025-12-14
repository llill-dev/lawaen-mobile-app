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
  final _messageController = TextEditingController();
  final _focusNode = FocusNode();

  String? get _currentUserId => getIt<AppPreferences>().getUserInfo()?.id;
  String? get _currentUserImage => getIt<AppPreferences>().getUserInfo()?.image;

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

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty || _currentUserId == null) return;

    context.read<MessagesCubit>().sendMessage(
      itemId: widget.itemId,
      secondCategoryId: widget.secondCategoryId,
      message: text,
      currentUserId: _currentUserId!,
    );

    _messageController.clear();
    _focusNode.requestFocus();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: _buildInputBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              const PrimaryBackButton(iconOnlay: true),
              12.verticalSpace,
              Expanded(
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
                      return const Center(child: Text('No messages yet'));
                    }

                    return CustomScrollView(
                      controller: _scrollController,
                      reverse: true,
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) {
                            final message = state.messages[index];
                            final isSender = message.userId == _currentUserId;

                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: ChatBubble(isSender: isSender, message: message.message, image: null),
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
            ],
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
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
            boxShadow: [BoxShadow(color: ColorManager.black.withValues(alpha: .25), blurRadius: 14, spreadRadius: 3)],
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _messageController,
                  focusNode: _focusNode,
                  hint: 'type any thing...',
                  withBorder: false,
                  onFieldSubmitted: (_) => _sendMessage(),
                ),
              ),
              8.horizontalSpace,
              BlocBuilder<MessagesCubit, MessagesState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: state.isSending ? null : _sendMessage,
                    child: CircleAvatar(
                      backgroundColor: state.isSending ? ColorManager.lightGrey : ColorManager.primary,
                      child: state.isSending
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : SvgPicture.asset(
                              IconManager.sendFeedback,
                              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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
