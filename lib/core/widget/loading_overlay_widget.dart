import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../utils/styles/color_utils.dart';

class LoadingOverlayWidget extends StatelessWidget {
  final bool? loading;
  final Widget? child;

  LoadingOverlayWidget({this.loading, this.child});

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading!,
      color: complementary,
      opacity: 0.55,
      progressIndicator: const Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
      child: child!,
    );
  }
}
