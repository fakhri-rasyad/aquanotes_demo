import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class DateRangeSelector extends StatelessWidget {
  final String? startDate;
  final String? endDate;
  final String label;
  final String hint;
  final void Function(DateTimeRange) onDateRangePicked;
  final String? Function(String?, String?)? validator;

  const DateRangeSelector({
    super.key,
    required this.label,
    required this.hint,
    required this.onDateRangePicked,
    this.startDate,
    this.endDate,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (_) => validator?.call(startDate, endDate),
      builder: (formFieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4),
            InkWell(
              onTap: () async {
                final picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  onDateRangePicked(picked);
                  formFieldState.didChange("picked"); // trigger state change
                }
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: formFieldState.hasError
                        ? Colors.red
                        : AppColors.blueAccent,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (startDate != null && endDate != null)
                          ? "$startDate - $endDate"
                          : hint,
                      style: TextStyle(
                        color: (startDate != null && endDate != null)
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                    const Icon(
                      Icons.date_range,
                      color: AppColors.blueAccent,
                    )
                  ],
                ),
              ),
            ),
            if (formFieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  formFieldState.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
