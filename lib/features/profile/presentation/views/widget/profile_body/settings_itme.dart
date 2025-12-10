import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class SettingsItme extends StatelessWidget {
  final String title;
  final String icon;
  final Color? iconColor;
  final bool isLogin;
  final VoidCallback? onTap;
  final bool hasDivider;
  final double? iconSize;
  const SettingsItme({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.hasDivider = true,
    this.iconColor,
    this.iconSize,
    this.isLogin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: ColorManager.lightGrey,
                  child: isLogin
                      ? Icon(Icons.login, color: ColorManager.red, size: iconSize)
                      : SvgPicture.asset(
                          icon,
                          width: iconSize,
                          height: iconSize,
                          colorFilter: iconColor == null ? null : ColorFilter.mode(iconColor!, BlendMode.srcIn),
                        ),
                ),
                const SizedBox(width: 16),
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
                const Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, size: 16, color: ColorManager.black),
              ],
            ),
            if (hasDivider)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: const Divider(color: ColorManager.lightGrey, thickness: 2),
              ),
          ],
        ),
      ),
    );
  }
}
