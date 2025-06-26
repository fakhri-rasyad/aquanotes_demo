import 'package:aquanotes/core/utils/validators.dart';
import 'package:aquanotes/shared/presentation/widgets/label_form_field.dart';
import 'package:flutter/material.dart';

class EditDialog extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final String name;
  final String min;
  final String max;
  final String initiaMinlValue;
  final String initialMaxValue;
  final Function(String) onMaxChanged;
  final Function(String) onMinChanged;

  EditDialog(
      {super.key,
      required this.name,
      required this.min,
      required this.max,
      required this.initiaMinlValue,
      required this.initialMaxValue,
      required this.onMinChanged,
      required this.onMaxChanged});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit $name"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LabelFormField(
                hint: min,
                initialValue: initiaMinlValue,
                onChanged: onMinChanged,
                validator: (value) => Validators.requiredField(value, min),
                label: min),
            LabelFormField(
                hint: max,
                initialValue: initialMaxValue,
                onChanged: onMaxChanged,
                validator: (value) => Validators.requiredField(value, max),
                label: max)
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              // final newMin = double.parse(minController.text);
              // final newMax = double.parse(maxController.text);
              // context
              //     .read<AlarmSettingCubit>()
              //     .updateSetting(setting.name, newMin, newMax);
              Navigator.of(context).pop();
            }
          },
          child: const Text("Simpan"),
        ),
      ],
    );
  }
}

// showDialog(
//     context: context,
//     builder: (_) => AlertDialog(
//       title: Text("Edit $name"),
//       content: Form(
//         key: formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             LabelFormField(
//                 hint: name,
//                 initialValue: initialValue,
//                 onChanged: onChanged,
//                 validator: (value) => Validators.requiredField(value, name),
//                 label: name)
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             if (formKey.currentState!.validate()) {
//               // final newMin = double.parse(minController.text);
//               // final newMax = double.parse(maxController.text);
//               // context
//               //     .read<AlarmSettingCubit>()
//               //     .updateSetting(setting.name, newMin, newMax);
//               Navigator.of(context).pop();
//             }
//           },
//           child: const Text("Simpan"),
//         ),
//       ],
//     ),
//   );
