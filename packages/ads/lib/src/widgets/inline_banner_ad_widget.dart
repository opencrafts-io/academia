import 'package:flutter/material.dart';

import '../banner_ad_size.dart';
import 'banner_ad_widget.dart';

/// Places a standard banner in scrollable content when the slot can fit it.
class InlineBannerAdWidget extends StatelessWidget {
  const InlineBannerAdWidget({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth < BannerAdSize.banner.width) {
        return const SizedBox.shrink();
      }
      return const Center(child: BannerAdWidget());
    },
  );
}
