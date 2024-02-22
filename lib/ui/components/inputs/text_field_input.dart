// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final String? fieldTitle;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? suffixText;
  final Widget? prefixIcon;
  final String? prefixText;
  final String? hintText;
  final int? maxLines;
  final String? initialValue;
  final bool _showObscureIcon;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final Color? backgroundColor;
  final String? labelText;
  final void Function()? onTap;
  final InputBorder? errorBorder;
  final void Function(String)? onChanged;

  const AppTextField._internal({
    this.controller,
    this.keyboardType,
    this.validator,
    this.prefixText,
    this.prefixIcon,
    this.maxLines,
    this.suffixText,
    this.fieldTitle,
    this.readOnly = false,
    this.hintText,
    this.initialValue,
    this.autofillHints,
    this.backgroundColor,
    this.onFieldSubmitted,
    this.textCapitalization,
    this.labelText,
    this.errorBorder,
    bool showObscureIcon = false,
    this.onChanged,
    this.textInputAction,
    this.inputFormatters,
    this.suffixIcon,
    this.onTap,
  }) : _showObscureIcon = showObscureIcon;

  factory AppTextField({
    String? Function(String?)? validator,
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool readOnly = false,
    int? maxLines = 1,
    String? fieldTitle,
    bool showObscureTextIcon = false,
    List<TextInputFormatter>? inputFormatters,
    void Function()? onTap,
    Iterable<String>? autofillHints,
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted,
    String? hintText,
  }) {
    return AppTextField._internal(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      onTap: onTap,
      autofillHints: autofillHints,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      fieldTitle: fieldTitle,
      maxLines: maxLines,
      hintText: hintText,
      validator: validator,
    );
  }

  factory AppTextField.otp({
    String? Function(String?)? validator,
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool readOnly = false,
    String? fieldTitle,
    void Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters,
    void Function()? onTap,
    Iterable<String>? autofillHints,
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted,
    String? hintText,
  }) {
    return AppTextField._internal(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r' ')),
      ],
      onChanged: onChanged,
      onTap: onTap,
      autofillHints: autofillHints,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      fieldTitle: fieldTitle,
      hintText: hintText,
      validator: validator,
    );
  }

  factory AppTextField.password({
    TextEditingController? controller,
    String? Function(String?)? validator,
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted,
    TextInputType? keyboardType,
    String? fieldTitle,
    int? maxLines = 1,
    void Function()? onTap,
    Iterable<String>? autofillHints,
    bool readOnly = false,
    bool showObscureTextIcon = true,
    bool showHiddenIcon = true,
    String? hintText,
  }) {
    return AppTextField._internal(
      controller: controller,
      autofillHints: autofillHints,
      readOnly: readOnly,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      hintText: hintText,
      onTap: onTap,
      maxLines: maxLines,
      onFieldSubmitted: onFieldSubmitted,
      fieldTitle: fieldTitle,
      validator: validator,
      showObscureIcon: showHiddenIcon,
    );
  }

  factory AppTextField.withColor({
    TextEditingController? controller,
    String? Function(String?)? validator,
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted,
    TextInputType? keyboardType,
    String? fieldTitle,
    Widget? suffixIcon,
    int? maxLines = 1,
    void Function()? onTap,
    String? labelText,
    InputBorder? errorBorder,
    final Color? backgroundColor,
    Iterable<String>? autofillHints,
    bool readOnly = false,
    bool showObscureTextIcon = false,
    String? hintText,
  }) {
    return AppTextField._internal(
      controller: controller,
      labelText: labelText,
      autofillHints: autofillHints,
      readOnly: readOnly,
      errorBorder: errorBorder,
      maxLines: maxLines,
      onTap: onTap,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      hintText: hintText,
      suffixIcon: suffixIcon,
      onFieldSubmitted: onFieldSubmitted,
      fieldTitle: fieldTitle,
      validator: validator,
      backgroundColor: backgroundColor,
      showObscureIcon: showObscureTextIcon,
    );
  }

  factory AppTextField.withLabel({
    TextEditingController? controller,
    TextCapitalization? textCapitalization,
    String? Function(String?)? validator,
    TextInputAction? textInputAction,
    Widget? suffixIcon,
    Widget? prefixIcon,
    String? initialValue,
    void Function(String)? onFieldSubmitted,
    void Function(String)? onChanged,
    TextInputType? keyboardType,
    String? fieldTitle,
    final Color? backgroundColor,
    Iterable<String>? autofillHints,
    bool readOnly = false,
    void Function()? onTap,
    bool showObscureTextIcon = false,
    String? hintText,
    String? labelText,
    int? maxLines,
    String? suffixText,
    String? prefixText,
  }) {
    return AppTextField._internal(
        controller: controller,
        autofillHints: autofillHints,
        readOnly: readOnly,
        initialValue: initialValue,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        hintText: hintText,
        textCapitalization: textCapitalization,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        maxLines: maxLines,
        onTap: onTap,
        fieldTitle: fieldTitle,
        validator: validator,
        backgroundColor: backgroundColor,
        showObscureIcon: showObscureTextIcon,
        labelText: labelText,
        suffixIcon: suffixIcon,
        suffixText: suffixText,
        prefixIcon: prefixIcon,
        prefixText: prefixText);
  }

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  @override
  void initState() {
    super.initState();
    _obscureText = widget._showObscureIcon ? true : false;
  }

  late bool _obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.fieldTitle != null)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.size6),
            child: Text(widget.fieldTitle!),
          ),
        TextFormField(
          autofillHints: widget.autofillHints,
          onFieldSubmitted: widget.onFieldSubmitted,
          maxLines: widget._showObscureIcon ? 1 : widget.maxLines,
          onChanged: widget.onChanged,
          textInputAction: widget.textInputAction,
          readOnly: widget.readOnly,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          obscureText: widget._showObscureIcon ? _obscureText : false,
          controller: widget.controller,
          onTap: widget.onTap,
          textAlign: TextAlign.left,
          initialValue: widget.initialValue,
          style: AppTextStyles.inputTextStyle,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            contentPadding: AppConstants.contentPadding,
            filled: true,
            suffixText: widget.suffixText,
            prefixText: widget.prefixText,
            fillColor: widget.backgroundColor ?? context.colorScheme.secondary,
            hintText: widget.hintText,
            labelText: widget.labelText,
            errorBorder: widget.errorBorder ?? const OutlineInputBorder(),
            focusedErrorBorder: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none),
            ),
            focusedBorder: const OutlineInputBorder(),
            suffixIcon: widget.suffixIcon ??
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget._showObscureIcon
                        ? IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: context.colorScheme.primary,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          )
                        : const SizedBox(),
                  ],
                ),
          ),
        ),
      ],
    );
  }
}
