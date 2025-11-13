import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';
import '../refresh_cubit/refresh_cubit.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    this.controller,
    this.isFieldObscure = false,
    this.fillColor,
    this.hint,
    this.validator,
    this.onTap,
    this.keyboardType,
    this.textInputAction,
    this.readOnly = false,
    this.autoValidateMode,
    this.labelText,
    this.errorText,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.borderRadius,
    this.maxLines = 1,
    this.expands = false,
    this.verticalContentPadding = 16,
    this.horizontalContentPadding = 14,
    this.hitStyle,
    super.key,
    this.withBorder = true,
  });

  final TextEditingController? controller;
  final bool isFieldObscure;
  final Color? fillColor;
  final String? hint;
  final TextStyle? hitStyle;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool expands;
  final bool readOnly;
  final AutovalidateMode? autoValidateMode;
  final String? labelText;
  final FocusNode? focusNode;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final double? borderRadius;
  final double verticalContentPadding;
  final double horizontalContentPadding;
  final int maxLines;
  final bool withBorder;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  double _borderRadius = 8.0;
  final _borderWidth = 1.0;
  var _obscure = false;
  final _refreshCubit = RefreshCubit();

  @override
  void initState() {
    super.initState();
    _obscure = widget.isFieldObscure;
    if (widget.borderRadius != null) {
      _borderRadius = widget.borderRadius ?? 8.0;
    }
  }

  void _toggleObscure() {
    if (!widget.isFieldObscure) {
      return;
    }
    _obscure = !_obscure;
    _refreshCubit.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.controller?.text,
      validator: widget.validator,
      autovalidateMode: widget.autoValidateMode ?? AutovalidateMode.onUserInteraction,
      builder: (state) {
        final isLabelProvided = widget.labelText != null && widget.labelText!.trim().isNotEmpty;
        final errorBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(width: _borderWidth, color: Colors.red),
        );
        final enabledBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(width: _borderWidth, color: ColorManager.blackSwatch[3]!),
        );
        final focusedBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(width: _borderWidth, color: ColorManager.blackSwatch[13]!),
        );
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLabelProvided) Text(widget.labelText ?? '', style: Theme.of(context).textTheme.bodyMedium),
            if (isLabelProvided) SizedBox(height: 8.h),
            Flexible(
              child: BlocBuilder<RefreshCubit, RefreshState>(
                bloc: _refreshCubit,
                builder: (context, refreshState) {
                  return TextFormField(
                    focusNode: widget.focusNode,
                    controller: widget.controller,
                    obscureText: _obscure,
                    expands: widget.expands,
                    onTap: widget.onTap,
                    readOnly: widget.readOnly,
                    obscuringCharacter: '*',
                    keyboardType: widget.keyboardType ?? TextInputType.text,
                    textInputAction: widget.textInputAction ?? TextInputAction.next,
                    textAlignVertical: widget.expands ? TextAlignVertical.top : TextAlignVertical.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                    maxLines: widget.maxLines,
                    onChanged: (value) {
                      if (widget.onChanged != null) {
                        widget.onChanged!(value);
                      }
                      state.didChange(value);
                    },
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      fillColor: widget.fillColor,
                      hintStyle:
                          widget.hitStyle ??
                          Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorManager.blackSwatch[6]),
                      prefixIcon: widget.prefixIcon,
                      prefixIconConstraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                      errorStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.red, fontSize: 8),
                      error: widget.errorText != null
                          ? Text(
                              widget.errorText ?? '',
                              style: Theme.of(
                                context,
                              ).textTheme.headlineSmall!.copyWith(color: Colors.red, fontSize: 12),
                            )
                          : state.hasError && state.errorText != null
                          ? Text(
                              state.errorText ?? '',
                              maxLines: 2,
                              style: Theme.of(
                                context,
                              ).textTheme.headlineSmall!.copyWith(color: Colors.red, fontSize: 12),
                            )
                          : null,
                      contentPadding: REdgeInsets.symmetric(
                        vertical: widget.verticalContentPadding.h,
                        horizontal: widget.horizontalContentPadding.w,
                      ),
                      enabledBorder: !widget.withBorder
                          ? InputBorder.none
                          : state.hasError
                          ? errorBorder
                          : enabledBorder,
                      border: !widget.withBorder
                          ? InputBorder.none
                          : state.hasError
                          ? errorBorder
                          : enabledBorder,
                      focusedBorder: !widget.withBorder
                          ? InputBorder.none
                          : state.hasError
                          ? errorBorder
                          : focusedBorder,
                      errorBorder: !widget.withBorder ? InputBorder.none : errorBorder,
                      focusedErrorBorder: !widget.withBorder ? InputBorder.none : errorBorder,
                      isCollapsed: true,
                      suffixIcon: widget.isFieldObscure
                          ? Padding(
                              padding: REdgeInsetsDirectional.only(end: 16.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: _toggleObscure,
                                    child: _obscure
                                        ? Icon(Icons.visibility_off_outlined, color: ColorManager.blackSwatch[13])
                                        : Icon(Icons.visibility_outlined, color: ColorManager.blackSwatch[13]),
                                  ),
                                ],
                              ),
                            )
                          : widget.suffixIcon,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
