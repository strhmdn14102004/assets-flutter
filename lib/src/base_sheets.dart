// ignore_for_file: always_specify_types, use_build_context_synchronously, cascade_invocations, always_put_required_named_parameters_first, constant_identifier_names, avoid_print

import "dart:io";

import "package:base/src/app_colors.dart";
import "package:base/src/base_overlays.dart";
import "package:base/src/base_preferences.dart";
import "package:base/src/base_side_sheet.dart";
import "package:base/src/base_widgets.dart";
import "package:base/src/dimensions.dart";
import "package:base/src/navigators.dart";
import "package:basic_utils/basic_utils.dart";
import "package:easy_localization/easy_localization.dart" as el;
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:jiffy/jiffy.dart";
import "package:photo_view/photo_view.dart";
import "package:smooth_corner/smooth_corner.dart";
import "package:syncfusion_flutter_datepicker/datepicker.dart";
import "package:video_player/video_player.dart";

class BaseSheets {
  static Future<dynamic> spinner({
    required String title,
    required List<SpinnerItem> spinnerItems,
    required void Function(SpinnerItem selectedItem) onSelected,
    BuildContext? context,
  }) async {
    TextEditingController textEditingController = TextEditingController();

    List<SpinnerItem> filteredSpinnerItems = [];

    filteredSpinnerItems.addAll(spinnerItems);

    Widget body() {
      return StatefulBuilder(
        builder: (context, setState) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(
                      Dimensions.size15,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface(),
                      border: Border(
                        bottom: BorderSide(
                          width: 0.2,
                          color: AppColors.outline(),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigators.pop(context: context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: Dimensions.size5,
                                ),
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: Dimensions.text16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.size10),
                        TextField(
                          controller: textEditingController,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: el.tr("search"),
                            hintStyle: TextStyle(
                              color: AppColors.onSurface().withValues(alpha:0.5),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.onSurface().withValues(alpha:0.5),
                            ),
                            filled: true,
                            fillColor: AppColors.backgroundSurface(),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.outline().withValues(alpha:0.3),
                              ),
                              borderRadius: BorderRadius.circular(Dimensions.size10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.outline().withValues(alpha:0.3),
                              ),
                              borderRadius: BorderRadius.circular(Dimensions.size10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.outline().withValues(alpha:0.3),
                              ),
                              borderRadius: BorderRadius.circular(Dimensions.size10),
                            ),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              filteredSpinnerItems.clear();

                              if (StringUtils.isNotNullOrEmpty(textEditingController.text)) {
                                for (SpinnerItem spinnerItem in spinnerItems) {
                                  if (spinnerItem.description.toLowerCase().contains(textEditingController.text.toLowerCase(),)) {
                                    filteredSpinnerItems.add(spinnerItem);
                                  }
                                }
                              } else {
                                filteredSpinnerItems.addAll(spinnerItems);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: filteredSpinnerItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        SpinnerItem spinnerItem = filteredSpinnerItems[index];

                        return ListTile(
                          onTap: () {
                            Navigators.pop(context: context);

                            onSelected(spinnerItem);
                          },
                          title: Text(
                            spinnerItem.description,
                            style: TextStyle(
                              color: spinnerItem.selected ? AppColors.primary() : AppColors.onSurface(),
                              fontWeight: spinnerItem.selected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 0,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    if (context != null) {
      return Navigators.push(
        body(),
        context: context,
      );
    } else {
      if (Navigators.sideSheetNavigatorState.currentContext != null) {
        return Navigators.push(
          body(),
          context: Navigators.sideSheetNavigatorState.currentContext,
        );
      } else {
        return await BaseSideSheet.rightFlow(
          initialBody: body(),
        );
      }
    }
  }

  static Future<dynamic> checkable({
    required String title,
    required List<SpinnerItem> spinnerItems,
    required void Function(List<SpinnerItem> selectedItems) onSelected,
    BuildContext? context,
  }) async {
    TextEditingController textEditingController = TextEditingController();

    List<SpinnerItem> filteredSpinnerItems = [];

    filteredSpinnerItems.addAll(spinnerItems);

    bool selectedAll = !spinnerItems.any((element) => !element.selected);

    Widget body() {
      return StatefulBuilder(
        builder: (context, setState) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(
                      Dimensions.size15,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface(),
                      border: Border(
                        bottom: BorderSide(
                          width: 0.2,
                          color: AppColors.outline(),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigators.pop(context: context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: Dimensions.size5,
                                ),
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: Dimensions.text16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: Dimensions.size15,
                              ),
                              child: BaseWidgets.check(
                                label: el.tr("select_all"),
                                value: selectedAll,
                                readonly: false,
                                onChanged: (value) {
                                  selectedAll = !selectedAll;

                                  for (SpinnerItem spinnerItem in spinnerItems) {
                                    spinnerItem.selected = selectedAll;
                                  }

                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.size10),
                        TextField(
                          controller: textEditingController,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: el.tr("search"),
                            hintStyle: TextStyle(
                              color: AppColors.onSurface().withValues(alpha:0.5),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.onSurface().withValues(alpha:0.5),
                            ),
                            filled: true,
                            fillColor: AppColors.backgroundSurface(),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.outline().withValues(alpha:0.3),
                              ),
                              borderRadius: BorderRadius.circular(Dimensions.size10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.outline().withValues(alpha:0.3),
                              ),
                              borderRadius: BorderRadius.circular(Dimensions.size10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.outline().withValues(alpha:0.3),
                              ),
                              borderRadius: BorderRadius.circular(Dimensions.size10),
                            ),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              filteredSpinnerItems.clear();

                              if (StringUtils.isNotNullOrEmpty(textEditingController.text)) {
                                for (SpinnerItem spinnerItem in spinnerItems) {
                                  if (spinnerItem.description.toLowerCase().contains(textEditingController.text.toLowerCase(),)) {
                                    filteredSpinnerItems.add(spinnerItem);
                                  }
                                }
                              } else {
                                filteredSpinnerItems.addAll(spinnerItems);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: filteredSpinnerItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        SpinnerItem spinnerItem = filteredSpinnerItems[index];

                        return CheckboxListTile(
                          value: spinnerItem.selected,
                          onChanged: (value) {
                            setState(() {
                              spinnerItem.selected = value ?? false;
                            });
                          },
                          title: Text(
                            spinnerItem.description,
                            style: TextStyle(
                              color: spinnerItem.selected ? AppColors.primary() : AppColors.onSurface(),
                              fontWeight: spinnerItem.selected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 0,
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.size20,
                      vertical: Dimensions.size15,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 0.2,
                          color: AppColors.outline(),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FilledButton.icon(
                          onPressed: () async {
                            onSelected(spinnerItems.where((element) => element.selected).toList());

                            Navigators.pop();
                          },
                          label: Text(el.tr("save")),
                          icon: const Icon(Icons.save),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    if (context != null) {
      return Navigators.push(
        body(),
        context: context,
      );
    } else {
      if (Navigators.sideSheetNavigatorState.currentContext != null) {
        return Navigators.push(
          body(),
          context: context,
        );
      } else {
        return await BaseSideSheet.rightFlow(
          initialBody: body(),
        );
      }
    }
  }

  static Future<dynamic> menu({
    required List<MenuItem> menuItems,
  }) async {
    return await BaseSideSheet.right(
      title: el.tr("option"),
      body: ListView.separated(
        itemCount: menuItems.length,
        separatorBuilder: (context, index) {
          return Divider(
            color: AppColors.outline(),
            thickness: 0.2,
            height: 0,
          );
        },
        itemBuilder: (context, index) {
          MenuItem menuItem = menuItems[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.size20,
              vertical: Dimensions.size5,
            ),
            onTap: menuItem.onTap != null ? () {
              Navigators.pop();

              menuItem.onTap!();
            } : null,
            leading: menuItem.iconData != null ? Icon(
              menuItem.iconData,
              color: menuItem.onTap != null ? AppColors.onSurface() : AppColors.onSurface().withValues(alpha:0.3),
            ) : null,
            title: Text(
              menuItem.title,
              style: TextStyle(
                color: menuItem.onTap != null ? AppColors.onSurface() : AppColors.onSurface().withValues(alpha:0.3),
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.text16,
              ),
            ),
          );
        },
      ),
    );
  }

  static Future<dynamic> dateRange({
    required Jiffy from,
    required Jiffy until,
    required void Function(Jiffy selectedFrom, Jiffy selectedUntil) onSelected,
    int? maxRangeInDays,
  }) async {
    if (Get.context != null) {
      await showDialog(
        context: Get.context!,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            child: SmoothClipRRect(
              smoothness: 1,
              borderRadius: BorderRadius.circular(Dimensions.size20),
              side: BorderSide(color: AppColors.outline()),
              child: SizedBox(
                width: Dimensions.size100 * 4,
                height: Dimensions.size100 * 4,
                child: SfDateRangePicker(
                  view: DateRangePickerView.month,
                  selectionMode: DateRangePickerSelectionMode.range,
                  headerStyle: DateRangePickerHeaderStyle(
                    textAlign: TextAlign.center,
                    backgroundColor: AppColors.surfaceContainerLowest(),
                  ),
                  backgroundColor: AppColors.surfaceContainerLowest(),
                  showActionButtons: true,
                  initialDisplayDate: from.dateTime,
                  initialSelectedRange: PickerDateRange(from.dateTime, until.dateTime),
                  onCancel: () {
                    Navigators.pop();
                  },
                  onSubmit: (Object? p0) {
                    if (p0 != null) {
                      if (p0 is PickerDateRange) {
                        if (p0.startDate != null && p0.endDate != null) {
                          if (maxRangeInDays != null && p0.endDate!.difference(p0.startDate!).inDays > maxRangeInDays) {
                            BaseOverlays.error(message: "${el.tr("the_maximum_period_is")} $maxRangeInDays ${el.tr("days")}");
                          } else {
                            onSelected(
                              Jiffy.parseFromDateTime(p0.startDate!),
                              Jiffy.parseFromDateTime(p0.endDate!),
                            );

                            Navigators.pop();
                          }
                        }
                      }
                    }
                  },
                ),
              ),
            ),
          );
        },
      );
    }
  }

  static Future<dynamic> date({
    required Jiffy? jiffy,
    Jiffy? min,
    Jiffy? max,
    required void Function(Jiffy jiffy) onSelected,
  }) async {
    if (Get.context != null) {
      jiffy ??= Jiffy.now();
      min ??= Jiffy.parseFromDateTime(DateTime(1900, 1, 1));
      max ??= Jiffy.now();

      DateTime? dateTime = await showDatePicker(
        context: Get.context!,
        initialDate: jiffy.dateTime,
        firstDate: min.dateTime,
        lastDate: max.dateTime,
      );

      if (dateTime != null) {
        onSelected(
          Jiffy.parseFromDateTime(
            DateTime(
              dateTime.year,
              dateTime.month,
              dateTime.day,
            ),
          ).startOf(Unit.day),
        );
      }
    }
  }

  static Future<dynamic> dateTime({
    required Jiffy jiffy,
    required Jiffy min,
    required Jiffy max,
    required void Function(Jiffy jiffy) onSelected,
  }) async {
    if (Get.context != null) {
      DateTime? dateTime = await showDatePicker(
        context: Get.context!,
        initialDate: jiffy.dateTime,
        firstDate: min.dateTime,
        lastDate: max.dateTime,
      );

      if (dateTime != null) {
        TimeOfDay? timeOfDay = await showTimePicker(
          context: Get.context!,
          initialTime: TimeOfDay.fromDateTime(jiffy.dateTime),
        );

        if (timeOfDay != null) {
          onSelected(
            Jiffy.parseFromDateTime(
              DateTime(
                dateTime.year,
                dateTime.month,
                dateTime.day,
                timeOfDay.hour,
                timeOfDay.minute,
              ),
            ),
          );
        }
      }
    }
  }

  static void imagePreview({
    required ImageProvider imageProvider,
  }) async {
    await BaseSideSheet.right(
      title: el.tr("view_image"),
      body: StatefulBuilder(
        builder: (context, setState) {
          return PhotoView(
            imageProvider: imageProvider,
            backgroundDecoration: const BoxDecoration(
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  static void videoPreview({
    required File file,
  }) async {
    VideoPlayerController videoPlayerController = VideoPlayerController.file(file);

    await videoPlayerController.initialize();
    await videoPlayerController.setLooping(true);
    await videoPlayerController.play();

    await BaseSideSheet.right(
      title: el.tr("view_video"),
      body: Center(
        child: AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: VideoPlayer(videoPlayerController),
        ),
      ),
    );
  }

  static Future<dynamic> savedSetting() async {
    return await BaseSideSheet.right(
      title: el.tr("saved_setting"),
      body: ListView.separated(
        itemCount: BasePreferences.getInstance().all().length,
        itemBuilder: (BuildContext context, int index) {
          MapEntry<String, String> mapEntry = BasePreferences.getInstance().all().entries.elementAt(index);

          return ListTile(
            title: Text(
              mapEntry.key,
            ),
            subtitle: Text(
              mapEntry.value,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 0,
          );
        },
      ),
    );
  }
}

class SpinnerItem {
  final dynamic identity;
  final String description;
  final String? selectedDescription;
  final dynamic tag;
  bool selected;

  SpinnerItem({
    required this.identity,
    required this.description,
    this.selectedDescription,
    this.tag,
    this.selected = false,
  });
}

class MenuItem {
  final IconData? iconData;
  final String title;
  final void Function()? onTap;

  MenuItem({
    this.iconData,
    required this.title,
    this.onTap,
  });
}
