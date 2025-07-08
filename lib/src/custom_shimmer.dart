// ignore_for_file: always_specify_types, prefer_const_constructors_in_immutables

import "package:base/base.dart";
import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

class CustomShimmer extends StatelessWidget {
  CustomShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.size100 * 5,
      width: Dimensions.screenWidth,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.size20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/lottie/loading.json",
            frameRate: const FrameRate(60),
            height: Dimensions.size100,
            width: Dimensions.size100,
            repeat: true,
          ),
        ],
      ),
    );
  }
}
