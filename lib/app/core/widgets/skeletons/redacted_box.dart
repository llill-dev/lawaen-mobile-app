import 'package:flutter/material.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:redacted/redacted.dart';

class RedactedBox extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final Color? color;

  const RedactedBox({super.key, required this.child, this.enabled = true, this.color});

  @override
  Widget build(BuildContext context) {
    return child.redacted(
      context: context,
      redact: enabled,
      configuration: RedactedConfiguration(
        redactedColor: color ?? ColorManager.lightGrey,
        animationDuration: Duration(milliseconds: 900),
        defaultBorderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
