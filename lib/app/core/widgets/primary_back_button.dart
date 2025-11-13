import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';

class PrimaryBackButton extends StatelessWidget {
  final bool withShadow;
  final double? width;
  final bool iconOnlay;
  final double? iconSize;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? fontSize;
  const PrimaryBackButton({
    super.key,
    this.withShadow = false,
    this.width,
    this.iconOnlay = false,
    this.iconSize,
    this.iconColor,
    this.backgroundColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            if (withShadow)
              BoxShadow(
                color: ColorManager.black.withValues(alpha: .25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),

        child: Row(
          children: [
            Icon(Icons.arrow_back, color: iconColor ?? ColorManager.primary, size: iconSize ?? 16),
            if (!iconOnlay) ...[
              SizedBox(width: 4),
              Text(
                'back',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: iconColor ?? ColorManager.primary, fontSize: fontSize),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
