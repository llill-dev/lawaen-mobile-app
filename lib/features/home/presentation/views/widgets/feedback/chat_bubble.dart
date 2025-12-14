import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/core/helper/network_icon.dart';
import 'package:lawaen/app/resources/assets_manager.dart';

import 'bubble.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  final String? image;
  const ChatBubble({super.key, required this.message, required this.isSender, this.image});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isSender ? TextDirection.ltr : TextDirection.rtl,
      child: Row(
        children: [
          image == null
              ? SvgPicture.asset(IconManager.profileFeddback)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: NetworkIcon(url: image!, width: 40.w, height: 40.h),
                ),
          10.horizontalSpace,
          Bubble(isSender: isSender, message: message),
        ],
      ),
    );
  }
}
