import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class DivaisDropdown<T> extends StatelessWidget {
  const DivaisDropdown({
    super.key,
    required this.label,
    required this.currentValue,
    required this.items,
    required this.onChanged,
    required this.validator,
    required this.valueMapper,
  });

  final String label;
  final T? currentValue;
  final List<T> items;
  final void Function(T?) onChanged;
  final String? Function(T?) validator;
  final String Function(T) valueMapper; // how to display T

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField<T>(
            dropdownColor: AppColors.secondary,
            isExpanded: true,
            value: currentValue,
            items: items
                .map((item) => DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        valueMapper(item),
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
