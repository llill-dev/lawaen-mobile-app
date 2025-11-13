import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/core/widgets/custom_text_field.dart';
import 'package:lawaen/app/core/widgets/primary_back_button.dart';
import 'package:lawaen/app/resources/assets_manager.dart';

import '../../../../app/resources/color_manager.dart';
import 'widgets/feedback/chat_bubble.dart';

@RoutePage()
class FeedbackChatScreen extends StatelessWidget {
  const FeedbackChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
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
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: PrimaryBackButton(iconOnlay: true, iconSize: 18.w)),
              SliverToBoxAdapter(
                child: ChatBubble(
                  isSender: true,
                  message:
                      "sed do eiusmod tempor incididunt ut labore et magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliqui.",
                ),
              ),
              buildSpace(),
              SliverToBoxAdapter(
                child: ChatBubble(
                  isSender: false,
                  message:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
