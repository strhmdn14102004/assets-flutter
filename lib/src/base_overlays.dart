import "package:base/src/dimensions.dart";
import "package:base/src/navigators.dart";
import "package:easy_localization/easy_localization.dart" as el;
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:lottie/lottie.dart";

class ErrorOverlay extends ModalRoute<void> {
  final String message;

  ErrorOverlay({
    required this.message,
  });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black.withValues(alpha:0.8);

  @override
  String get barrierLabel => "null";

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation,) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(Dimensions.size20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(
              "assets/lottie/error.json",
              frameRate: const FrameRate(60),
              width: Dimensions.size100 * 3,
              repeat: false,
            ),
            Text(
              message,
              style: TextStyle(
                fontSize: Dimensions.text20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: Dimensions.size50,
            ),
            IconButton(
              onPressed: () {
                Navigators.pop();
              },
              iconSize: Dimensions.size40,
              color: Colors.white,
              icon: const Icon(
                Icons.cancel_outlined,
              ),
            ),
            Text(
              el.tr("close"),
              style: TextStyle(
                fontSize: Dimensions.text16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child,) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

class SuccessOverlay extends ModalRoute<void> {
  final String message;

  SuccessOverlay({
    required this.message,
  });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black.withValues(alpha:0.8);

  @override
  String get barrierLabel => "null";

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation,) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(Dimensions.size20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(
              "assets/lottie/success.json",
              frameRate: const FrameRate(60),
              width: Dimensions.size100 * 2,
              repeat: false,
            ),
            SizedBox(
              height: Dimensions.size50,
            ),
            Text(
              message,
              style: TextStyle(
                fontSize: Dimensions.text20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: Dimensions.size50,
            ),
            IconButton(
              onPressed: () {
                Navigators.pop();
              },
              iconSize: Dimensions.size40,
              color: Colors.white,
              icon: const Icon(
                Icons.cancel_outlined,
              ),
            ),
            Text(
              el.tr("close"),
              style: TextStyle(
                fontSize: Dimensions.text16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child,) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

class InfoOverlay extends ModalRoute<void> {
  final String message;
  final bool dismissable;

  InfoOverlay({
    required this.message,
    required this.dismissable,
  });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => dismissable;

  @override
  Color get barrierColor => Colors.black.withValues(alpha:0.8);

  @override
  String get barrierLabel => "null";

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation,) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    Widget closeButton() {
      if (dismissable) {
        return Container(
          margin: EdgeInsets.only(
            top: Dimensions.size50,
          ),
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  Navigators.pop();
                },
                iconSize: Dimensions.size40,
                color: Colors.white,
                icon: const Icon(
                  Icons.cancel_outlined,
                ),
              ),
              Text(
                el.tr("close"),
                style: TextStyle(
                  fontSize: Dimensions.text16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      }

      return const SizedBox.shrink();
    }

    return Center(
      child: Container(
        padding: EdgeInsets.all(Dimensions.size20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.info_outline,
              size: Dimensions.size100 * 2,
              color: Colors.white,
            ),
            SizedBox(
              height: Dimensions.size50,
            ),
            Text(
              message,
              style: TextStyle(
                fontSize: Dimensions.text20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            closeButton(),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child,) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

class BaseOverlays {
  static Future<void> error({
    required String message,
  }) async {
    if (Get.context != null) {
      await Navigator.of(Get.context!).push(
        ErrorOverlay(
          message: message,
        ),
      );
    }
  }

  static Future<void> success({
    required String message,
  }) async {
    if (Get.context != null) {
      await Navigator.of(Get.context!).push(
        SuccessOverlay(
          message: message,
        ),
      );
    }
  }

  static Future<void> info({
    required String message,
    bool dismissable = true,
  }) async {
    if (Get.context != null) {
      await Navigator.of(Get.context!).push(
        InfoOverlay(
          message: message,
          dismissable: dismissable,
        ),
      );
    }
  }
}
