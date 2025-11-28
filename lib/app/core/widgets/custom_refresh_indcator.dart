import 'package:flutter/material.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class CustomRefreshIndcator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  const CustomRefreshIndcator({super.key, required this.onRefresh, required this.child});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(color: ColorManager.primary, onRefresh: onRefresh, child: child);
  }
}
