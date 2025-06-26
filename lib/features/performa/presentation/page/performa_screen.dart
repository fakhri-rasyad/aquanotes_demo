import 'package:aquanotes/features/performa/presentation/cubit/performa_screen_cubit.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_appbar.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PerformaScreen extends StatelessWidget {
  PerformaScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  static const routeName = "/performaScreen";

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PerformaScreenCubit>();
    return Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: CustomAppBar(
          titleText: "Performa Budidaya",
          onBackButton: () {
            cubit.resetInput();
            Navigator.of(context).pop();
          },
        ),
        body: BlocBuilder<PerformaScreenCubit, PerformaScreenState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    UnitTextField(
                      unit: "Kg",
                      label: "Pakan Harian",
                      hint: "Pakan",
                      onChanged: (value) {
                        cubit.updateValues(
                            pakanHarian: value, showPredictionResult: false);
                      },
                      validator: (value) =>
                          validateNumberInput(value, allowZero: false),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    UnitTextField(
                      unit: "g",
                      label: "Rerata Bobot Udang",
                      hint: "ABW",
                      onChanged: (value) {
                        cubit.updateValues(
                            meanBobotUdang: value, showPredictionResult: false);
                      },
                      validator: (value) =>
                          validateNumberInput(value, allowZero: false),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    UnitTextField(
                      unit: "%",
                      label: "Feeding Rate",
                      hint: "Pemberian Pakan",
                      onChanged: (value) {
                        cubit.updateValues(
                            feedRate: value, showPredictionResult: false);
                      },
                      validator: (value) =>
                          validateNumberInput(value, allowZero: false),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    UnitTextField(
                      unit: "Kg",
                      label: "Pakan Kumulatif",
                      hint: "Pakan Kumulatif",
                      onChanged: (value) {
                        cubit.updateValues(
                            pakanKumulatif: value, showPredictionResult: false);
                      },
                      validator: (value) =>
                          validateNumberInput(value, allowZero: false),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    UnitTextField(
                      unit: "Ekor",
                      label: "Jumlah Tebar",
                      hint: "Jumlah Tebar",
                      onChanged: (value) {
                        cubit.updateValues(
                            jumlahTebar: value, showPredictionResult: false);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Input tidak boleh kosong!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.updateValues(showPredictionResult: true);
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
                    const SizedBox(
                      height: 16.0,
                    ),
                    state.showPredictionResult
                        ? PredictionResult(
                            biomassa: cubit.calculateBiomassa(),
                            populasi: cubit.calculatePopulasi(),
                            fcr: cubit.calculateFcr(),
                            sr: cubit.calculateSurvivalRate())
                        : const SizedBox(),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const InformationSection()
                  ],
                ),
              ),
            );
          },
        ));
  }
}

Future<dynamic> infoBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      backgroundColor: AppColors.secondary,
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Informasi Perhitungan",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueAccent,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 16,
              ),
              const SectionLabel(
                  text:
                      "Hasil perhitungan Biomassa, FCR, dan SR ini merupakan estimasi berbasis:"),
              _bulletListItem("Biomassa, FCR, dan SR", '• '),
              _bulletListItem("Data ABW dan jumlah tebar.", '• '),
              const SizedBox(
                height: 16,
              ),
              const SectionLabel(text: "Untuk akurasi maksimal:  : "),
              _bulletListItem(
                  "Update data ABW secara berkala (sampling).", '• '),
              _bulletListItem(
                  "Validasi dengan tim teknis jika hasil tidak wajar.", '• '),
              _bulletListItem(
                  "Pantau kualitas air (pH, DO, amonia) secara rutin.", '• '),
            ],
          ),
        );
      });
}

class SectionLabel extends StatelessWidget {
  const SectionLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

Widget _bulletListItem(String text, String bullet) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bullet,
        ),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    ),
  );
}

class InformationSection extends StatelessWidget {
  const InformationSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.info_outline),
        const Text(" Informasi perhitungan budidaya, "),
        GestureDetector(
          onTap: () => infoBottomSheet(context),
          child: const Text(
            "lihat",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.blueAccent),
          ),
        )
      ],
    );
  }
}

class PredictionResult extends StatelessWidget {
  const PredictionResult(
      {super.key, this.biomassa, this.populasi, this.fcr, this.sr});
  final double? biomassa;
  final double? populasi;
  final double? fcr;
  final double? sr;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.blueAccent),
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.blueAccent.withAlpha(47),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Hasil Perhitungan",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.blueAccent),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(8.0)),
            child: Image.asset(
                "assets/images/performance/performance_formula.png"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(TextSpan(text: "Biomassa ", children: [
                TextSpan(
                    text: "${biomassa!.toStringAsFixed(2)} Kg",
                    style: const TextStyle(fontWeight: FontWeight.bold))
              ])),
              Text.rich(TextSpan(text: "Populasi ", children: [
                TextSpan(
                    text: "${populasi!.toStringAsFixed(2)} PL",
                    style: const TextStyle(fontWeight: FontWeight.bold))
              ])),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Text("FCR"),
          LinearProgressIndicator(
            value: fcr ?? 1,
            color: AppColors.gold,
            backgroundColor: AppColors.blueAccent,
            minHeight: 12,
            borderRadius: BorderRadius.circular(8.0),
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Text("Survival Rate (SR)"),
          LinearProgressIndicator(
            value: (sr ?? 1) / 100,
            color: AppColors.gold,
            backgroundColor: AppColors.blueAccent,
            borderRadius: BorderRadius.circular(8.0),
            minHeight: 12,
          ),
        ],
      ),
    );
  }
}

String? validateNumberInput(String? value, {bool allowZero = true}) {
  if (value == null || value.isEmpty) {
    return 'Input tidak boleh kosong!';
  }

  final numValue = num.tryParse(value);
  if (numValue == null) {
    return 'Input harus berupa angka!';
  }

  if (!allowZero && numValue <= 0) {
    return 'Nilai harus lebih dari 0!';
  }

  if (numValue < 0) {
    return 'Nilai tidak boleh negatif!';
  }

  return null;
}

class UnitTextField extends StatelessWidget {
  final String unit;
  final String label;
  final String hint;
  final Function(String)? onChanged;
  final String? initialValue;
  final String? Function(String?)? validator;

  const UnitTextField(
      {super.key,
      required this.unit,
      required this.label,
      required this.hint,
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
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
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
                decoration: InputDecoration(
                  labelText: label,
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.black.withAlpha(127)),
                  suffix: Text(
                    unit,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.blueAccent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
                validator: validator,
              ),
            ),
            // Container(
            //   width: 48,
            //   height: 48,
            //   decoration: BoxDecoration(
            //     color: const Color(0xFFE0E0E0),
            //     borderRadius: const BorderRadius.only(
            //       topRight: Radius.circular(8),
            //       bottomRight: Radius.circular(8),
            //     ),
            //     border: Border.all(color: AppColors.blueAccent),
            //   ),
            //   alignment: Alignment.center,
            //   child: Text(
            //     unit,
            //     style: const TextStyle(fontSize: 14, color: Colors.black),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
