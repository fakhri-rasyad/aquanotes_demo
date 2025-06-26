// Widget _buildDropdown({
//     required String label,
//     required String? currentValue,
//     required List<String> items,
//     required void Function(String?) onChanged,
//     required String? Function(String?) validator,
//   }) {

//   }

import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
      {super.key,
      required this.label,
      required this.currentValue,
      required this.items,
      required this.onChanged,
      required this.validator});

  final String label;
  final String? currentValue;
  final List<String> items;
  final void Function(String?) onChanged;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField<String>(
            dropdownColor: AppColors.secondary,
            isExpanded: true,
            value: currentValue,
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
            validator: validator,
            decoration: const InputDecoration(
              filled: true,
              fillColor: AppColors.secondary,
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.gradientStart, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.gradientStart, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.gradientStart, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
