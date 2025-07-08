// ignore_for_file: always_specify_types, use_build_context_synchronously, always_put_required_named_parameters_first, cascade_invocations

import "package:base/src/app_colors.dart";
import "package:base/src/dimensions.dart";
import "package:base/src/navigators.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:jiffy/jiffy.dart";
import "package:syncfusion_flutter_datepicker/datepicker.dart";
import "package:easy_localization/easy_localization.dart" as el;

class BaseDialogs {
  static Future<void> message({
    required String title,
    String? message,
    String? dismiss,
    bool showButton = true,
    bool cancelable = true,
  }) async {
    if (Get.context != null) {
      Widget? content;

      if (message != null) {
        content = SingleChildScrollView(
          child: Text(message),
        );
      }

      List<Widget> actions = [];

      if (showButton) {
        actions.add(
          TextButton(
            child: Text(dismiss ?? el.tr("got_it")),
            onPressed: () => Navigator.of(Get.context!).pop(),
          ),
        );
      }

      return await showDialog(
        context: Get.context!,
        barrierDismissible: cancelable,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text(title),
            content: content,
            actions: actions,
          );
        },
      );
    }
  }

  static Future<void> confirmation({
    required String title,
    String? message,
    String? negative,
    String? positive,
    bool cancelable = true,
    VoidCallback? negativeCallback,
    VoidCallback? positiveCallback,
  }) async {
    if (Get.context != null) {
      Widget? content;

      if (message != null) {
        content = SingleChildScrollView(
          child: Text(message),
        );
      }

      return await showDialog(
        context: Get.context!,
        barrierDismissible: cancelable,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text(title),
            content: content,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.error(),
                ),
                onPressed: () {
                  Navigator.of(buildContext).pop();

                  if (negativeCallback != null) {
                    negativeCallback.call();
                  }
                },
                child: Text(negative ?? el.tr("no")),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.materialContainer(Colors.green),
                  foregroundColor: AppColors.onMaterialContainer(Colors.green),
                ),
                child: Text(positive ?? el.tr("yes")),
                onPressed: () {
                  Navigator.of(buildContext).pop();

                  if (positiveCallback != null) {
                    positiveCallback.call();
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }

  static Future<dynamic> month({
    required Jiffy? jiffy,
    required void Function(Jiffy selectedMonth) onSelected,
  }) async {
    if (Get.context != null) {
      await showDialog(
        context: Get.context!,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(Dimensions.size20),
              width: Dimensions.size100 * 3,
              height: Dimensions.size100 * 4,
              child: SfDateRangePicker(
                view: DateRangePickerView.year,
                allowViewNavigation: false,
                selectionMode: DateRangePickerSelectionMode.single,
                initialDisplayDate: jiffy != null ? jiffy.dateTime : DateTime.now(),
                initialSelectedDate: jiffy != null ? jiffy.dateTime : DateTime.now(),
                headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                  backgroundColor: AppColors.surface(),
                ),
                backgroundColor: AppColors.surface(),
                onCancel: () {
                  Navigators.pop();
                },
                onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                  if (dateRangePickerSelectionChangedArgs.value != null) {
                    if (dateRangePickerSelectionChangedArgs.value is DateTime) {
                      onSelected(Jiffy.parseFromDateTime(dateRangePickerSelectionChangedArgs.value));

                      Navigators.pop();
                    }
                  }
                },
              ),
            ),
          );
        },
      );
    }
  }
}
