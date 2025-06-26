import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../theme/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String hint;
  final String? initialValue;
  final IconButton? endIcon;
  final Function(String) onChanged;
  final String? Function(String?) validator;
  final bool isPassword;
  final bool isDate;
  final bool isNumber;
  final bool isVisible;
  final bool isEnabled;
  final int maxLines;
  final VoidCallback? iconAction;

  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.initialValue,
    required this.onChanged,
    required this.validator,
    this.isPassword = false,
    this.isVisible = false,
    this.isEnabled = true,
    this.label,
    this.iconAction,
    this.endIcon,
    this.maxLines = 1,
    this.isNumber = false,
    this.isDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      maxLines: maxLines,
      inputFormatters:
          isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
      initialValue: initialValue,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      obscureText: isPassword && !isVisible,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.lightGray,
        ),
        suffixIcon: endIcon ??
            (isPassword && iconAction != null
                ? IconButton(
                    icon: Icon(
                        isVisible ? Icons.visibility_off : Icons.visibility),
                    onPressed: iconAction,
                  )
                : isDate
                    ? IconButton(
                        icon: const Icon(Icons.date_range),
                        onPressed: iconAction,
                      )
                    : null),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.gradientStart, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.gradientStart, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.gradientStart, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
