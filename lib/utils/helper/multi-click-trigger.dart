import 'package:flutter/foundation.dart';

class MultiClickTrigger {
  final int targetCount;
  final int interval; // 单位：毫秒
  final VoidCallback onTrigger;

  int _clickNum = 0;
  int _lastTapTime = 0;

  MultiClickTrigger({
    required this.onTrigger,
    this.targetCount = 5,
    this.interval = 500,
  });

  void handleTap() {
    final curTime = DateTime.now().millisecondsSinceEpoch;
    final timeDiff = curTime - _lastTapTime;

    if (timeDiff < interval) {
      _clickNum += 1;
    } else {
      _clickNum = 1;
    }

    if (_clickNum == targetCount) {
      _clickNum = 0;
      onTrigger();
    }

    _lastTapTime = curTime;
  }

  void reset() {
    _clickNum = 0;
    _lastTapTime = 0;
  }

  int get clickCount => _clickNum;
}
