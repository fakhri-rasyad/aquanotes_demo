import 'package:aquanotes/core/utils/validators.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';

class PembelianWidget extends StatelessWidget {
  final String? currentPackage;
  final String? currentDevice;
  final Function(String) updatePackage;
  final Function(String) updateDevice;
  const PembelianWidget(
      {super.key,
      required this.currentPackage,
      required this.currentDevice,
      required this.updatePackage,
      required this.updateDevice});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdown(
            label: "Pilih Paket",
            currentValue: currentPackage,
            items: List.generate(7, (index) => "$index Bulan"),
            onChanged: (value) => updatePackage(value ?? ""),
            validator: (value) => Validators.requiredField(value, "Paket")),
        CustomDropdown(
            label: "Jumlah Divais",
            currentValue: currentDevice,
            items: List.generate(7, (index) => "$index Divais"),
            onChanged: (value) => updateDevice(value ?? ""),
            validator: (value) => Validators.requiredField(value, "Divais"))
      ],
    );
  }
}
