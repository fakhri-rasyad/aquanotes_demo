import 'package:aquanotes/features/amonia/presentation/cubit/amonie_screen_cubit.dart';
import 'package:aquanotes/features/amonia/presentation/page/amonia_prediction_result_screen.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_appbar.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmoniaScreen extends StatelessWidget {
  AmoniaScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  static const routeName = "/amoniaScreen";

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AmonieScreenCubit>();
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: CustomAppBar(
        titleText: "Kadar Amonia",
        onBackButton: () {
          cubit.resetInput();
          Navigator.of(context).pop();
        },
      ),
      body: BlocBuilder<AmonieScreenCubit, AmonieScreenState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const Text('Pilih Kolam',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.blueAccent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: 'Kolam A',
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: ['Kolam A', 'Kolam B'].map((e) {
                        return DropdownMenuItem(value: e, child: Text(e));
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: UnitTextField(
                          unit: '°C',
                          label: 'Suhu',
                          initialValue: cubit.state.temp,
                          onChanged: (value) {
                            cubit.updateInput(temp: value);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Input tidak boleh kosong!";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: UnitTextField(
                          unit: 'pH',
                          label: 'pH',
                          initialValue: cubit.state.pH,
                          onChanged: (value) {
                            cubit.updateInput(pH: value);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Input tidak boleh kosong!";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: UnitTextField(
                          unit: 'm³',
                          label: 'Volume Air Kolam',
                          initialValue: cubit.state.volume,
                          onChanged: (value) {
                            cubit.updateInput(volume: value);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Input tidak boleh kosong!";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: UnitTextField(
                          unit: 'kg',
                          label: 'Jumlah Pakan Harian',
                          initialValue: cubit.state.feed,
                          onChanged: (value) {
                            cubit.updateInput(feed: value);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Input tidak boleh kosong!";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        double amoniaCount = cubit.calculateAmmonia();
                        double tanCount = cubit.tanValue();
                        Navigator.pushNamed(
                            context, AmoniaPredictionResultScreen.routeName,
                            arguments: PredictionResult(amoniaCount, tanCount));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                    child: const Text('Hitung',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                            fontSize: 16.0)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class UnitTextField extends StatelessWidget {
  final String unit;
  final String label;
  final Function(String)? onChanged;
  final String? initialValue;
  final String? Function(String?)? validator;

  const UnitTextField(
      {super.key,
      required this.unit,
      required this.label,
      this.onChanged,
      this.initialValue,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                initialValue: initialValue,
                onChanged: onChanged,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    borderSide: BorderSide(color: AppColors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    borderSide: BorderSide(color: AppColors.blueAccent),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
                validator: validator,
              ),
            ),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                border: Border.all(color: AppColors.blueAccent),
              ),
              alignment: Alignment.center,
              child: Text(
                unit,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
