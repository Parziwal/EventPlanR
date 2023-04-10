import 'package:flutter/material.dart';

extension MediaQueryX on BuildContext {
  double get screenBodyHeight {
    final media = MediaQuery.of(this);
    return media.size.height - media.padding.top - kToolbarHeight;
  }
}
