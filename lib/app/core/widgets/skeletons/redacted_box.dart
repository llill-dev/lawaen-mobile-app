import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';

class RedactedBox extends StatelessWidget {
  final Widget child;
  final bool enabled;

  const RedactedBox({super.key, required this.child, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return child.redacted(
      context: context,
      redact: enabled,
      configuration: RedactedConfiguration(
        animationDuration: Duration(milliseconds: 900),
        defaultBorderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
