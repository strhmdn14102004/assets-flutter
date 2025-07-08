// ignore_for_file: avoid_function_literals_in_foreach_calls

import "package:base/base.dart";
import "package:base/src/base_date_field.dart";
import "package:basic_utils/basic_utils.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:image_picker/image_picker.dart";
import "package:jiffy/jiffy.dart";
import "package:lottie/lottie.dart";
import "package:smooth_corner/smooth_corner.dart";

class BaseWidgets {
  static Widget text({
    required bool mandatory,
    required bool readonly,
    required TextEditingController controller,
    String? label,
    FormFieldSetter<String>? onSaved,
    ValueChanged<String>? onChanged,
    int? minLength,
    int? maxLength,
    int maxLines = 1,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Widget? suffix,
    TextInputType? textInputType,
    bool obscureText = false,
    FormFieldValidator<String>? validator,
    bool? isDense = false,
  }) {
    return BaseTextField(
      mandatory: mandatory,
      readonly: readonly,
      controller: controller,
      label: label,
      onSaved: onSaved,
      onChanged: onChanged,
      minLength: minLength,
      maxLength: maxLength,
      maxLines: maxLines,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      suffix: suffix,
      textInputType: textInputType,
      obscureText: obscureText,
      validator: validator,
      isDense: isDense,
    );
  }

  static Widget numeric({
    required bool mandatory,
    required bool readonly,
    required TextEditingController controller,
    bool? enabled = true,
    bool? isDense = false,
    String? label,
    String? helperText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Widget? suffix,
    TextAlign? textAlign = TextAlign.end,
    FormFieldSetter<num>? onSaved,
    ValueChanged<String>? onChanged,
    FormFieldValidator<num>? validator,
  }) {
    return BaseNumericField(
      mandatory: mandatory,
      readonly: readonly,
      controller: controller,
      enabled: enabled!,
      isDense: isDense!,
      label: label,
      helperText: helperText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      suffix: suffix,
      textAlign: textAlign!,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validator,
    );
  }

  static Widget date({
    required String label,
    required bool mandatory,
    required bool readonly,
    required TextEditingController controller,
    Jiffy? jiffy,
    void Function(Jiffy newValue)? onSelected,
    bool? isDense = false,
  }) {
    return BaseDateField(
      mandatory: mandatory,
      readonly: readonly,
      value: jiffy,
      onSelected: onSelected,
      label: label,
    );
  }

  static Widget month({
    required String label,
    required bool mandatory,
    required bool readonly,
    required TextEditingController controller,
    required Jiffy? jiffy,
    required void Function(Jiffy newValue) onSelected,
    bool? isDense = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: Dimensions.text12,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface().withValues(alpha: 80),
          ),
        ),
        SizedBox(height: Dimensions.size5),
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
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
                color: AppColors.primary(),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(Dimensions.size10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.error(),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(Dimensions.size10),
            ),
            suffixIcon: const Icon(
              Icons.event,
            ),
            isDense: isDense,
          ),
          validator: (String? value) {
            if (mandatory) {
              if (jiffy == null) {
                return "this_field_is_required".tr();
              }
            }

            return null;
          },
          onTap: !readonly ? () async {
            await BaseDialogs.month(
              jiffy: jiffy,
              onSelected: (newValue) {
                controller.text = newValue.format(pattern: "MMMM yyyy");

                onSelected(newValue);
              },
            );
          } : null,
        ),
      ],
    );
  }

  static Widget spinner({
    required bool mandatory,
    required bool readonly,
    required List<SpinnerItem> spinnerItems,
    required dynamic value,
    required void Function(SpinnerItem selectedItem) onSelected,
    String? label,
    String? defaultDescription,
  }) {
    return BaseSpinnerField(
      mandatory: mandatory,
      readonly: readonly,
      spinnerItems: spinnerItems,
      value: value,
      onSelected: onSelected,
      label: label,
      defaultDescription: defaultDescription,
    );
  }

  static Widget check({
    required String label,
    required bool? value,
    required bool readonly,
    required void Function(bool newValue) onChanged,
  }) {
    return InkWell(
      onTap: !readonly ? () {
        onChanged(!(value ?? false));
      } : null,
      customBorder: SmoothRectangleBorder(
        smoothness: 1,
        borderRadius: BorderRadius.circular(Dimensions.size10),
      ),
      child: Container(
        decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
            smoothness: 1,
            borderRadius: BorderRadius.circular(Dimensions.size10),
            side: BorderSide(color: AppColors.outline()),
          ),
          color: (value ?? false) ? AppColors.primaryContainer() : AppColors.surfaceContainerLowest(),
        ),
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.size10,
          horizontal: Dimensions.size15,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: Dimensions.size20,
              height: Dimensions.size20,
              child: Checkbox(
                value: value ?? false,
                onChanged: !readonly ? (newValue) {
                  onChanged(newValue ?? false);
                } : null,
              ),
            ),
            SizedBox(width: Dimensions.size10),
            Text(
              label,
              style: TextStyle(
                fontSize: Dimensions.text14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget radio<T>({
    required T value,
    required List<RadioItem<T>> radioItems,
    required bool readonly,
    required void Function(T newValue) onChanged,
    String? label,
  }) {
    Widget labelWidget() {
      if (StringUtils.isNotNullOrEmpty(label)) {
        return Container(
          margin: EdgeInsets.only(
            bottom: Dimensions.size5,
          ),
          child: Text(
            label!,
            style: TextStyle(
              fontSize: Dimensions.text12,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface().withValues(alpha: 80),
            ),
          ),
        );
      }

      return const SizedBox.shrink();
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelWidget(),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            runSpacing: Dimensions.size10,
            spacing: Dimensions.size10,
            children: radioItems.map((radioItem) {
              return Opacity(
                opacity: !readonly ? 1 : 0.5,
                child: InkWell(
                  onTap: !readonly ? () {
                    onChanged(radioItem.option);
                  } : null,
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.size5),
                  ),
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: SmoothRectangleBorder(
                        smoothness: 1,
                        borderRadius: BorderRadius.circular(Dimensions.size10),
                        side: BorderSide(color: AppColors.outline()),
                      ),
                      color: (radioItem.option == value) ? AppColors.primaryContainer() : AppColors.surfaceContainerLowest(),
                    ),
                    padding: EdgeInsets.all(Dimensions.size10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: Dimensions.size20,
                          height: Dimensions.size20,
                          child: Radio<T>(
                            value: radioItem.option,
                            groupValue: value,
                            onChanged: !readonly ? (newValue) {
                              if (newValue != null) {
                                onChanged(newValue);
                              }
                            } : null,
                          ),
                        ),
                        SizedBox(width: Dimensions.size10),
                        Text(
                          radioItem.description,
                          style: TextStyle(
                            fontSize: Dimensions.text14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  static Widget image({
    String? label,
    double? width,
    double? height,
    required Uint8List? value,
    required bool readonly,
    required void Function(Uint8List? newValue) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: StringUtils.isNotNullOrEmpty(label),
          child: Text(
            label ?? "",
            style: TextStyle(
              fontSize: Dimensions.text12,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface().withValues(alpha: 80),
            ),
          ),
        ),
        Visibility(
          visible: StringUtils.isNotNullOrEmpty(label),
          child: SizedBox(height: Dimensions.size5),
        ),
        Image.memory(
          value ?? Uint8List(0),
          height: width ?? Dimensions.size100,
          width: height ?? Dimensions.size100,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) => Container(
            height: width ?? Dimensions.size100,
            width: height ?? Dimensions.size100,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              shape: SmoothRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.size20),
                smoothness: 1,
                side: BorderSide(
                  color: AppColors.outline(),
                ),
              ),
              color: AppColors.surfaceContainerLowest(),
            ),
            child: SmoothClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.size20),
              smoothness: 1,
              child: SizedBox(
                height: Dimensions.size100,
                width: Dimensions.size100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      size: Dimensions.size30,
                      color: AppColors.onSurface().withValues(alpha: 0.5),
                    ),
                    Text(
                      "no_image".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.onSurface().withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            return Container(
              height: width ?? Dimensions.size100,
              width: height ?? Dimensions.size100,
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.size20),
                  smoothness: 1,
                  side: BorderSide(
                    color: AppColors.outline(),
                  ),
                ),
                color: AppColors.surfaceContainerLowest(),
              ),
              child: SmoothClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.size20),
                smoothness: 1,
                side: BorderSide(
                  color: AppColors.outline(),
                ),
                child: child,
              ),
            );
          },
        ),
        SizedBox(height: Dimensions.size10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: Dimensions.size30,
              width: Dimensions.size30,
              child: IconButton.filledTonal(
                onPressed: !readonly ? () async {
                  XFile? xFile = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 20,
                  );

                  if (xFile != null) {
                    Uint8List bytesFile = Uint8List.fromList(await xFile.readAsBytes());

                    onChanged(bytesFile);
                  }
                } : null,
                icon: const Icon(Icons.edit),
                iconSize: Dimensions.size15,
              ),
            ),
            SizedBox(width: Dimensions.size5),
            SizedBox(
              height: Dimensions.size30,
              width: Dimensions.size30,
              child: IconButton(
                onPressed: !readonly ? () async {
                  onChanged(null);
                } : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.errorContainer()),
                ),
                color: AppColors.onErrorContainer(),
                icon: const Icon(Icons.delete),
                iconSize: Dimensions.size15,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget shimmer() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.size20,
            ),
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  "assets/lottie/loading.json",
                  frameRate: const FrameRate(60),
                  height: Dimensions.size100,
                  width: Dimensions.size100,
                  repeat: true,
                ),
                Text(
                  "${"loading".tr()}...",
                  style: TextStyle(
                    fontSize: Dimensions.text20,
                    color: AppColors.onSurface(),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget loadingFail({
    RefreshCallback? onRefresh,
  }) {
    Widget body() {
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.size20,
              ),
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    "assets/lottie/loading_fail.json",
                    frameRate: const FrameRate(60),
                    width: Dimensions.size100 * 2,
                    repeat: false,
                  ),
                  Text(
                    "failed_to_load_data".tr(),
                    style: TextStyle(
                      fontSize: Dimensions.text20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Dimensions.size10,
                  ),
                  Text(
                    "failed_to_load_data_hint".tr(),
                    style: TextStyle(
                      fontSize: Dimensions.text14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.onSurface(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: body(),
      );
    } else {
      return body();
    }
  }

  static Widget noData({
    RefreshCallback? onRefresh,
  }) {
    Widget body() {
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.size20,
                ),
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      "assets/lottie/no_data.json",
                      frameRate: const FrameRate(60),
                      width: Dimensions.size100 * 2,
                      repeat: false,
                    ),
                    Text(
                      "no_data".tr(),
                      style: TextStyle(
                        fontSize: Dimensions.text20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface(),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: Dimensions.size10,
                    ),
                    Text(
                      "no_data_hint".tr(),
                      style: TextStyle(
                        fontSize: Dimensions.text14,
                        fontWeight: FontWeight.w300,
                        color: AppColors.onSurface(),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
          );
        },
      );
    }

    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: body(),
      );
    } else {
      return body();
    }
  }

  static Widget labelValue({
    required String description,
    required String value,
    required bool left,
    bool expanded = true,
  }) {
    Widget widget = Column(
      crossAxisAlignment: left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          description,
          textAlign: left ? TextAlign.start : TextAlign.end,
        ),
        Text(
          value,
          textAlign: left ? TextAlign.start : TextAlign.end,
          style: TextStyle(
            fontSize: Dimensions.text16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

    if (expanded) {
      return Expanded(
        child: widget,
      );
    } else {
      return widget;
    }
  }

  static Widget rowColumn({
    required List<Widget> leftChildren,
    required List<Widget> rightChildren,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (Dimensions.isMobile()) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...leftChildren,
              SizedBox(height: Dimensions.size10),
              ...rightChildren,
            ],
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...leftChildren,
                  ],
                ),
              ),
              SizedBox(width: Dimensions.size20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...rightChildren,
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class RadioItem<T> {
  final T option;
  final String description;

  RadioItem({
    required this.option,
    required this.description,
  });
}