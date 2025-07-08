import 'package:base/base.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_corner/smooth_corner.dart';

class BaseTextField extends StatefulWidget {
  final bool mandatory;
  final bool readonly;
  final TextEditingController controller;
  String? label;
  FormFieldSetter<String>? onSaved;
  ValueChanged<String>? onChanged;
  int? minLength;
  int? maxLength;
  int? maxLines;
  Widget? prefixIcon;
  Widget? suffixIcon;
  Widget? suffix;
  TextInputType? textInputType;
  bool obscureText;
  FormFieldValidator<String>? validator;
  bool? isDense = false;

  BaseTextField({
    super.key,
    required this.mandatory,
    required this.readonly,
    required this.controller,
    this.label,
    this.onSaved,
    this.onChanged,
    this.minLength,
    this.maxLength,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.textInputType,
    this.obscureText = false,
    this.validator,
    this.isDense,
  });

  @override
  State<BaseTextField> createState() => BaseTextFieldState();
}

class BaseTextFieldState extends State<BaseTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: widget.controller.text,
      enabled: !widget.readonly,
      validator: widget.validator ?? (String? value) {
        if (widget.mandatory) {
          if (StringUtils.isNullOrEmpty(value)) {
            return "this_field_is_required".tr();
          }
        }

        if (widget.minLength != null) {
          if ((value ?? "").length < widget.minLength!) {
            return "${"minimum_character_length_is".tr()} ${widget.minLength}";
          }
        }

        if (StringUtils.isNotNullOrEmpty(value)) {
          if (widget.textInputType != null) {
            if (widget.textInputType == TextInputType.emailAddress) {
              if (!RegExp("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-.]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})\$").hasMatch(value ?? "")) {
                return "email_format_is_invalid".tr();
              }
            }
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
                obscureText: widget.obscureText,
                keyboardType: widget.textInputType,
                readOnly: widget.readonly,
                maxLength: widget.maxLength,
                maxLines: widget.maxLines,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                buildCounter: (context, {required currentLength, required isFocused, required maxLength}) {
                  return const SizedBox.shrink();
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  prefixIcon: widget.prefixIcon,
                  suffix: widget.suffix,
                  suffixIcon: widget.suffixIcon,
                ),
                onChanged: widget.onChanged ?? (value) {
                  setState(() {
                    field.didChange(value);
                  });
                },
              ),
            ),
            helperWidget(field),
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

  Widget helperWidget(FormFieldState field) {
    List<Widget> widgets = [];

    if (field.hasError) {
      widgets.add(
        Expanded(
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
        ),
      );
    }

    if ((widget.maxLength ?? 0) > 0 && !widget.readonly) {
      widgets.add(
        Text(
          "${(field.value as String).length}/${widget.maxLength}",
          style: TextStyle(
            fontSize: Dimensions.text10,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface().withValues(alpha: 80),
          ),
        ),
      );
    }

    if (widgets.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(
          top: Dimensions.size5,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: widgets,
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
}