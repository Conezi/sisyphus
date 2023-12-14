import 'package:flutter/material.dart';

class TextEditView extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final Color? fillColor;
  final GestureTapCallback? onTap;
  final String? labelText;
  final String? hintText;
  final bool readOnly;
  final bool autofocus;
  final bool autocorrect;
  final double borderRadius;
  final double borderWidth;
  final bool isDense;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? borderColor;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool filled;
  final String? prefixText;
  final String? helperText;
  final Color? iconColor;
  final Color? textColor;
  final Iterable<String>? autofillHints;
  final FocusNode? focusNode;
  const TextEditView(
      {Key? key,
      this.onChanged,
      this.controller,
      this.fillColor,
      this.onTap,
      this.keyboardType,
      this.textInputAction,
      this.validator,
      this.readOnly = false,
      this.autofocus = false,
      this.autocorrect = false,
      this.isDense = true,
      this.labelText,
      this.hintText,
      this.onFieldSubmitted,
      this.borderRadius = 6.0,
      this.borderWidth = 0.2,
      this.suffixIcon,
      this.iconColor,
      this.textColor,
      this.prefixIcon,
      this.borderColor,
      this.filled = true,
      this.prefixText,
      this.autofillHints,
      this.focusNode,
      this.helperText,
      this.minLines,
      this.maxLength,
      this.maxLines = 1})
      : super(key: key);

  @override
  State<TextEditView> createState() => _TextEditViewState();
}

class _TextEditViewState extends State<TextEditView> {
  OutlineInputBorder _border(BuildContext context) => OutlineInputBorder(
      borderSide: BorderSide(
          width: widget.borderWidth,
          color: widget.borderColor ?? Theme.of(context).shadowColor,
          style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)));

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.secondary)),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        autocorrect: widget.autocorrect,
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        autofillHints: widget.autofillHints,
        onFieldSubmitted: widget.onFieldSubmitted,
        focusNode: widget.focusNode,
        style: TextStyle(color: widget.textColor),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 9.0, horizontal: 12.0),
          border: _border(context),
          enabledBorder: _border(context),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                  width: widget.borderWidth,
                  color: Theme.of(context).dividerColor,
                  style: BorderStyle.solid)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                  width: widget.borderWidth,
                  color: Colors.red,
                  style: BorderStyle.solid)),
          errorBorder: _border(context),
          disabledBorder: _border(context),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: widget.textColor, fontSize: 14),
          labelText: widget.labelText,
          labelStyle: TextStyle(color: widget.textColor, fontSize: 14),
          filled: widget.filled,
          isDense: widget.isDense,
          fillColor: widget.fillColor ??
              Theme.of(context).shadowColor.withOpacity(0.02),
          helperText: widget.helperText,
          helperMaxLines: 2,
          helperStyle: const TextStyle(fontSize: 10),
          iconColor: widget.iconColor,
          prefixIconColor: widget.iconColor,
          suffixIconColor: widget.iconColor,
          prefixText: widget.prefixText,
          prefixIcon: widget.prefixIcon,
          suffixIconConstraints: const BoxConstraints(maxHeight: 40),
          prefixIconConstraints: const BoxConstraints(maxHeight: 40),
          suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}
