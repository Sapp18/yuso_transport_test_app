import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatelessWidget {
  final bool obscureText;
  final FocusNode? focusNode;
  final IconData? icon;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final Map<String, dynamic> formValues;
  final String formProperty;
  final String? counterText;
  final String? Function(String?)? validator;
  final String? helperText;
  final String? hintText;
  final String? labelText;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final String? initialValue;
  final void Function(String)? onFieldSubmitted;

  const CustomInputField({
    Key? key,
    required this.formProperty,
    required this.formValues,
    this.counterText,
    this.focusNode,
    this.helperText,
    this.hintText,
    this.icon,
    this.keyboardType,
    this.labelText,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.inputFormatters,
    this.maxLength,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: focusNode,
      initialValue: initialValue,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
        counterText: counterText,
        prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
        suffixIcon: suffixIcon,
        icon: icon == null ? null : Icon(icon),
      ),
      onChanged: (value) => formValues[formProperty] = value,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
    );
  }
}
