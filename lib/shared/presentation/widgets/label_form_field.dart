import 'package:flutter/material.dart';

import 'custom_text_form_field.dart';

class LabelFormField extends StatelessWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final IconButton? endAction;
  final Function(String) onChanged;
  final String? Function(String?) validator;
  final bool isPassword;
  final bool isDate;
  final bool isNumber;
  final bool isVisible;
  final bool isEnabled;
  final int maxLines;
  final VoidCallback? iconAction;
  const LabelFormField(
      {super.key,
      required this.hint,
      required this.initialValue,
      required this.onChanged,
      required this.validator,
      this.isPassword = false,
      this.isVisible = false,
      this.isEnabled = true,
      this.endAction,
      required this.label,
      this.maxLines = 1,
      this.iconAction,
      this.isDate = false,
      this.isNumber = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          CustomTextFormField(
              label: label,
              isDate: isDate,
              isNumber: isNumber,
              isPassword: isPassword,
              iconAction: iconAction,
              endIcon: endAction,
              isVisible: isVisible,
              isEnabled: isEnabled,
              hint: hint,
              maxLines: maxLines,
              onChanged: onChanged,
              initialValue: initialValue,
              validator: validator),
        ],
      ),
    );
  }
}
