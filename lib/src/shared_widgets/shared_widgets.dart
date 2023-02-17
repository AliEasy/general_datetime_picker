import 'package:flutter/material.dart';

class SharedWidgets {
  static Widget defaultSelectionOverlayWidget() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.blue, width: 2),
              top: BorderSide(color: Colors.blue, width: 2))),
    );
  }
}
