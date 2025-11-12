import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';

class PrimaryBackButton extends StatelessWidget {
  final bool withShadow;
  final double? width;
  final bool iconOnlay;
  const PrimaryBackButton({super.key, this.withShadow = false, this.width, this.iconOnlay = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
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
            Icon(Icons.arrow_back, color: ColorManager.primary, size: 16),
            if (!iconOnlay) ...[
              SizedBox(width: 4),
              Text('back', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.primary)),
            ],
          ],
        ),
      ),
    );
  }
}
