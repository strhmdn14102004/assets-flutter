import "dart:html";
import "dart:typed_data";

import "package:base/src/attachments.dart";
import "package:flutter/material.dart";

class WebAttachments implements Attachments {
  @override
  void download({
    required BuildContext context,
    required Uint8List bytes,
    required String fileName,
  }) {
    // Create a blob and a link element
    final blob = Blob([bytes]);
    final url = Url.createObjectUrlFromBlob(blob);

    AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();

    // Revoke the object URL after download
    Url.revokeObjectUrl(url);
  }
}

Attachments getAttachments() => WebAttachments();
