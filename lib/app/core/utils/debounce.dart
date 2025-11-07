import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  final Duration delay;
  Timer? _timer;

  Debounce({required this.delay});

  void run(VoidCallback action) {
    _timer?.cancel();

    _timer = Timer(delay, action);
  }

  void cancel() {
    _timer?.cancel();
  }

  bool isActive() {
    return _timer?.isActive ?? false;
  }
}
