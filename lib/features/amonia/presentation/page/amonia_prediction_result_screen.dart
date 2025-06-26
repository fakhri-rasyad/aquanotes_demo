import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AmoniaPredictionResultScreen extends StatelessWidget {
  const AmoniaPredictionResultScreen({super.key});

  static const routeName = "amoniaPredictionResultScreen";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PredictionResult;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Hasil Prediksi',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.blueAccent),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.blueAccent),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.error_outline,
                    color: AppColors.blueAccent),
                onPressed: () {
                  infoBottomSheet(context);
                }),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: ListView(
            children: [
              const SizedBox(height: 24),
              const SectionLabel(text: "Hasil Perhitungan"),
              const SizedBox(height: 16),
              CalculationResultSection(args: args),
              const SizedBox(height: 24),
              const SectionLabel(
                text: 'Rekomendasi Tindakan',
              ),
              const SizedBox(height: 8),
              ActionRecommendation(
                ammoniaCount: args.amoniaCount,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> infoBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: AppColors.secondary,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Informasi Prediksi",
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
                        "Hasil perhitungan NH₃ ini merupakan estimasi berbasis:"),
                _bulletListItem("Input pakan & volume air kolam.", '• '),
                _bulletListItem("Data sensor pH dan suhu.", '• '),
                const SizedBox(
                  height: 16,
                ),
                const SectionLabel(text: "Untuk akurasi maksimal: "),
                _bulletListItem("Pastikan input data akurat.", '• '),
                _bulletListItem(
                    "Validasi dengan test kit amonia secara berkala.", '• '),
                _bulletListItem(
                    "Hubungi tim teknis jika hasil tidak sesuai ekspektasi.",
                    '• ')
              ],
            ),
          );
        });
  }
}

class CalculationResultSection extends StatelessWidget {
  const CalculationResultSection({
    super.key,
    required this.args,
  });

  final PredictionResult args;

  @override
  Widget build(BuildContext context) {
    final Color color = getAmmoniaLevelColor(args.amoniaCount);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withAlpha(31),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ResultHeader(args: args),
          const SizedBox(height: 12),
          AmmoniaIndicator(value: args.amoniaCount),
          const SizedBox(
            height: 6,
          ),
          ConditionChip(args: args),
          const SizedBox(height: 12),
          ConditionDescription(
            ammoniaCount: args.amoniaCount,
          ),
        ],
      ),
    );
  }
}

class ConditionChip extends StatelessWidget {
  const ConditionChip({
    super.key,
    required this.args,
  });

  final PredictionResult args;

  @override
  Widget build(BuildContext context) {
    final double ammonia = args.amoniaCount;

    final String condition = ammonia <= 0.1
        ? "Aman"
        : ammonia <= 0.5
            ? "Waspada"
            : "Bahaya";

    final IconData icon = ammonia <= 0.1
        ? Icons.check_circle_outline
        : ammonia <= 0.5
            ? Icons.warning_amber_outlined
            : Icons.error_outline;

    final Color bgColor = getAmmoniaLevelColor(ammonia);
    final Color textColor = getContrastingTextColor(bgColor);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: bgColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: textColor,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            condition,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class ConditionDescription extends StatelessWidget {
  ConditionDescription({super.key, required this.ammoniaCount});

  final double ammoniaCount;
  final List<String> conditionDescriptions = [
    'Kadar amonia dalam kolam saat ini aman. Pertahankan kualitas air dengan kontrol pakan dan aerasi yang optimal',
    "Kadar amonia mulai meningkat. Berisiko menyebabkan stres, segera lakukan tindakan!",
    "DARURAT! Kadar amonia berbahaya. Peluang risiko kematian dalam 24-48 jam jika tidak ditangani!"
  ];

  @override
  Widget build(BuildContext context) {
    return Text(
      ammoniaCount <= 0.1
          ? conditionDescriptions[0]
          : ammoniaCount <= 0.5
              ? conditionDescriptions[1]
              : conditionDescriptions[2],
      textAlign: TextAlign.center,
    );
  }
}

class ResultHeader extends StatelessWidget {
  const ResultHeader({
    super.key,
    required this.args,
  });

  final PredictionResult args;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'TAN',
              ),
              TextSpan(
                text: ' ${(args.tanCount).toStringAsFixed(3)} mg/L',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'Kadar Amonia',
              ),
              TextSpan(
                text: ' ${(args.amoniaCount).toStringAsFixed(3)} mg/L',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
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

class AmmoniaIndicator extends StatelessWidget {
  final double value;

  const AmmoniaIndicator({
    super.key,
    required this.value,
  });

  final double maxValue = 1.0;

  @override
  Widget build(BuildContext context) {
    Color chipColor = getAmmoniaLevelColor(value);

    return SizedBox(
      width: double.infinity,
      child: SfLinearGauge(
        showLabels: true,
        minimum: 0.0,
        maximum: 1.0,
        markerPointers: [
          LinearShapePointer(
            value: value,
            color: chipColor,
            borderColor: Colors.black45,
            borderWidth: 2,
          )
        ],
        ranges: const <LinearGaugeRange>[
          LinearGaugeRange(
            startValue: 0.0,
            endValue: 0.1,
            color: Colors.lightGreen,
          ),
          LinearGaugeRange(
            startValue: 0.1,
            endValue: 0.5,
            color: Colors.amber,
          ),
          LinearGaugeRange(
            startValue: 0.5,
            endValue: 1.0,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class ActionRecommendation extends StatelessWidget {
  ActionRecommendation({super.key, required this.ammoniaCount});
  final double ammoniaCount;

  final List<String> conditionAman = [
    "Lanjutkan jadwal pakan normal.",
    "Pantau pH dan suhu harian.",
    "Ganti 5-10% air jika TDS tinggi."
  ];
  final List<String> conditionaWaspada = [
    "Kurangi pemberian pakan 20-30%",
    "Tambah aerasi (naikkan DO > 5 mg/L).",
    "Berikan probiotik(e.g.,Bacillus spp.) untuk percepat dekomposisi amonia.",
    "Ganti 10-15% air kolam."
  ];
  final List<String> conditionBahaya = [
    "Hentikan pakan sementara (1-2 hari).",
    "Ganti 20-30% air segera.",
    "Tambahkan zeolit (5-10 kg/ha) atau kaporit (dosis aman) untuk netralisasi amonia.",
    "Hubungi penyuluh/konsultan perikanan jika kadar tidak turun dalam 6 jam."
  ];

  @override
  Widget build(BuildContext context) {
    final Condition condition = ammoniaCount <= 0.1
        ? Condition.aman
        : ammoniaCount <= 0.5
            ? Condition.waspada
            : Condition.bahaya;
    List<String> currentCondition = condition == Condition.aman
        ? conditionAman
        : condition == Condition.waspada
            ? conditionaWaspada
            : conditionBahaya;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
          children: currentCondition.map((action) {
        return _bulletListItem(action, '• ');
      }).toList()),
    );
  }
}

class PredictionResult {
  final double amoniaCount;
  final double tanCount;

  PredictionResult(this.amoniaCount, this.tanCount);
}

Color getAmmoniaLevelColor(double value) {
  if (value <= 0.1) return Colors.green;
  if (value <= 0.5) return Colors.amber;
  return Colors.red;
}

Color getContrastingTextColor(Color bgColor) {
  return bgColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}

enum Condition { aman, waspada, bahaya }
