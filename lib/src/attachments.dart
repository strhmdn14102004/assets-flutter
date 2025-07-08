import "dart:typed_data";
import "package:flutter/material.dart";

import "package:base/src/general_attachments.dart"
// ignore: uri_does_not_exist
if (dart.library.html) "package:base/src/web_attachments.dart";

abstract class Attachments {
  void download({
    required BuildContext context,
    required Uint8List bytes,
    required String fileName,
  }) {}

  factory Attachments() => getAttachments();
}
