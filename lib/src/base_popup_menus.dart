import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';

class BasePopupMenus {
  static Future<T?> show<T>({
    required BuildContext context,
    required BuildContext targetContext,
    required List<PopupMenuEntry<T>> items,
    T? value,
    Alignment alignment = Alignment.bottomRight,
  }) async {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final targetBox = targetContext.findRenderObject() as RenderBox;

    final targetSize = targetBox.size;
    final targetPosition = targetBox.localToGlobal(Offset.zero, ancestor: overlay);

    // Map alignment to anchor point on the target widget
    final dx = alignment.x; // -1.0 (left), 0.0 (center), 1.0 (right)
    final dy = alignment.y; // -1.0 (top), 0.0 (center), 1.0 (bottom)

    final anchorOffset = Offset(
      targetSize.width * (dx + 1) / 2,
      targetSize.height * (dy + 1) / 2,
    );

    final anchor = targetPosition + anchorOffset;

    // Position the menu using a small rect around the anchor point
    const double menuOffset = 1.0; // avoids zero-size rect
    final positionRect = Rect.fromLTWH(
      anchor.dx,
      anchor.dy,
      menuOffset,
      menuOffset,
    );

    final position = RelativeRect.fromRect(positionRect, Offset.zero & overlay.size);

    return showMenu<T>(
      context: context,
      position: position,
      color: AppColors.tertiaryContainer(),
      shape: SmoothRectangleBorder(
        smoothness: 1,
        borderRadius: BorderRadius.circular(Dimensions.size15),
        side: BorderSide(color: AppColors.onTertiaryContainer()),
      ),
      initialValue: value,
      menuPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      items: items,
    );
  }
}