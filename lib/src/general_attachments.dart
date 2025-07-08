import "dart:io";
import "dart:typed_data";

import "package:base/base.dart";
import "package:easy_localization/easy_localization.dart";
import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:path/path.dart" as path;

class GeneralAttachments implements Attachments {
  @override
  void download({
    required BuildContext context,
    required Uint8List bytes,
    required String fileName,
  }) async {
    String? directoryPath = await FilePicker.platform.getDirectoryPath();

    if (directoryPath != null) {
      String filePath = path.join(directoryPath, fileName);

      bool fileExists = await File(filePath).exists();

      if (fileExists) {
        int count = 1;

        String newFileName = "1-$fileName";

        while (await File(path.join(directoryPath, newFileName)).exists()) {
          count++;

          newFileName = "$count-$fileName";
        }

        fileName = newFileName;
        filePath = path.join(directoryPath, fileName);
      }

      await File(filePath).writeAsBytes(bytes);

      Future.delayed(const Duration(milliseconds: 500), () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("file_has_been_successfully_downloaded".tr()),
                Text(filePath),
              ],
            ),
            duration: const Duration(milliseconds: 2000),
          ),
        );
      });
    } else {
      BaseOverlays.error(message: "error_occured_when_saving_file".tr());
    }
  }
}

Attachments getAttachments() => GeneralAttachments();
