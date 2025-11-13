import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/resources/assets_manager.dart';

import 'bubble.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  const ChatBubble({super.key, required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isSender ? TextDirection.ltr : TextDirection.rtl,
      child: Row(
        children: [
          SvgPicture.asset(IconManager.profileFeddback),
          10.horizontalSpace,
          Bubble(isSender: isSender, message: message),
        ],
      ),
    );
  }
}
