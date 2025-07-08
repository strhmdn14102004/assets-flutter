// ignore_for_file: must_be_immutable

import 'package:base/base.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:smooth_corner/smooth_corner.dart';

class BaseNumericField extends StatefulWidget {
  final bool mandatory;
  final bool readonly;
  final TextEditingController controller;
  bool enabled;
  bool isDense;
  String? label;
  String? helperText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  Widget? suffix;
  TextAlign textAlign;
  FormFieldSetter<num>? onSaved;
  ValueChanged<String>? onChanged;
  FormFieldValidator<num>? validator;

  BaseNumericField({
    super.key,
    required this.mandatory,
    required this.readonly,
    required this.controller,
    this.enabled = true,
    this.isDense = false,
    this.label,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.textAlign = TextAlign.end,
    this.onSaved,
    this.onChanged,
    this.validator,
  });

  @override
  State<BaseNumericField> createState() => BaseNumericFieldState();
}

class BaseNumericFieldState extends State<BaseNumericField> {
  late final NumberFormat numberFormat;
  late final MaskTextInputFormatter formatter;

  @override
  void initState() {
    super.initState();
    numberFormat = NumberFormat.decimalPattern("id_ID");
    formatter = MaskTextInputFormatter(
      mask: '#,###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<num>(
      initialValue: tryParse(widget.controller.text),
      enabled: !widget.readonly,
      validator: widget.validator ??
          (num? value) {
            if (widget.mandatory) {
              if (value == null || value == 0) {
                return "this_field_is_required".tr();
              }
            }
            return null;
          },
      onSaved: widget.onSaved,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelWidget(),
            Container(
              width: double.infinity,
              height: Dimensions.size55,
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  smoothness: 1,
                  side: BorderSide(
                    color: borderColor(field),
                  ),
                ),
                color: AppColors.surfaceContainerLowest(),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.size5,
              ),
              child: TextField(
                controller: widget.controller,
                keyboardType: TextInputType.number,
                readOnly: widget.readonly,
                textAlign: widget.textAlign,
                enabled: widget.enabled,
                inputFormatters: [formatter],
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  prefixIcon: widget.prefixIcon,
                  suffix: widget.suffix,
                  suffixIcon: widget.suffixIcon,
                ),
                onChanged: widget.onChanged ??
                    (value) {
                      setState(() {
                        field.didChange(tryParse(value));
                      });
                    },
              ),
            ),
            errorWidget(field),
          ],
        );
      },
    );
  }

  Widget labelWidget() {
    if (StringUtils.isNotNullOrEmpty(widget.label)) {
      return Container(
        margin: EdgeInsets.only(
          bottom: Dimensions.size5,
        ),
        child: Text(
          "${widget.label}${widget.mandatory ? "*" : ""}",
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

  Widget errorWidget(FormFieldState field) {
    if (field.hasError) {
      return Container(
        margin: EdgeInsets.only(
          top: Dimensions.size5,
        ),
        child: Row(
          children: [
            Icon(
              Icons.error,
              color: AppColors.error(),
            ),
            SizedBox(width: Dimensions.size5),
            Expanded(
              child: Text(
                field.errorText ?? "",
                style: TextStyle(
                  fontSize: Dimensions.text12,
                  color: AppColors.error(),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Color borderColor(FormFieldState field) {
    if (widget.readonly) {
      return AppColors.surfaceDim();
    } else {
      if (field.hasError) {
        return AppColors.error();
      } else {
        return AppColors.outline();
      }
    }
  }

  static num tryParse(String value) {
    try {
      return NumberFormat.decimalPattern("id_ID").parse(value);
    } catch (ignored) {
      return num.tryParse(value.replaceAll(",", "")) ?? 0;
    }
  }
}
