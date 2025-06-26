import 'package:aquanotes/core/utils/validators.dart';
import 'package:aquanotes/features/feedvision/presentation/cubit/feedvision_screen_cubit.dart';
import 'package:aquanotes/features/feedvision/presentation/cubit/feedvision_screen_state.dart';
import 'package:aquanotes/shared/presentation/widgets/date_range_picker.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedvisionScreen extends StatelessWidget {
  const FeedvisionScreen({super.key});

  static const routeName = "/feedvision";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pantau Kolam",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTabBar(),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<FeedvisionCubit, FeedvisionState>(
                builder: (context, state) {
                  return state.selectedTab == 0
                      ? _buildColorMappingScreen()
                      : _buildRiwayatScreen(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    List<String> tabs = ["COLOR MAPPING", "RIWAYAT"];
    return BlocBuilder<FeedvisionCubit, FeedvisionState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: List.generate(tabs.length, (index) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _buildTabButton(
                    selected: state.selectedTab == index,
                    onTap: () =>
                        context.read<FeedvisionCubit>().selectTab(index),
                    title: tabs[index],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildTabButton(
      {required bool selected,
      required VoidCallback onTap,
      required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.gradientStart : AppColors.fadeLightBlue,
          borderRadius: BorderRadius.circular(12.0),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: selected ? Colors.white : AppColors.gradientStart,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildColorMappingScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Deteksi Kepadatan Pangan",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          "Capture Kolam",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.gradientStart,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Container(
            height: 156,
            width: 240,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.image,
              size: 50,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gradientStart,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              minimumSize: const Size(200, 48),
            ),
            child: const Text(
              "Generate With AI",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildGenerateResult()
      ],
    );
  }

  Widget _buildGenerateResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hasil Generate",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: AppColors.fadeLightBlue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Estimasi Kepadatan Pakan Kolam B",
                style: TextStyle(
                  color: AppColors.gradientStart,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              const Text("Berdasarkan hasil generate diperoleh"),
              const SizedBox(height: 2),
              const Text(
                "20342 nilai kepadatan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "03 Aug 2024 | 12:45",
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? currentValue,
    required List<String> items,
    required void Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField<String>(
            value: currentValue,
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: onChanged,
            validator: validator,
            decoration: const InputDecoration(
              filled: true,
              fillColor: AppColors.fadeLightBlue,
              border: OutlineInputBorder(
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
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildRiwayatScreen(BuildContext context) {
    return BlocBuilder<FeedvisionCubit, FeedvisionState>(
      builder: (context, state) {
        return Column(
          children: [
            DateRangeSelector(
              label: "Pilih Tanggal",
              hint: "Tanggal awal dan akhir",
              onDateRangePicked: (DateTimeRange<DateTime> datetime) {
                // final startDate = datetime.start;
                // final endDate = datetime.end;
              },
              validator: (startTime, endTime) {
                final error1 =
                    Validators.requiredField(startTime, "Tanggal awal");
                if (error1 != null) return error1;
                final error2 =
                    Validators.requiredField(endTime, "Tanggal akhir");
                if (error2 != null) return error2;
                return null;
              },
            ),
            _buildDropdown(
              label: "Pilih Tanggal",
              currentValue: null,
              items: List.generate(10, (index) => "Tanggal $index"),
              onChanged: (value) => print(value),
              validator: (value) => value == null || value.isEmpty
                  ? "Tipe divais harus dipilih"
                  : null,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        const WidgetStatePropertyAll(AppColors.gradientStart),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                            color: AppColors.gradientStart, width: 2),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.download, color: Colors.white),
                  label: const Text(
                    "Ekspor Data",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                            color: AppColors.gradientStart, width: 2),
                      ),
                    ),
                  ),
                  label: const Text(
                    "Bersihkan",
                    style: TextStyle(color: AppColors.gradientStart),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            _chartCard(
              "Riwayat Generate",
              AppColors.gradientStart,
              state.sensorData,
              state.xRange,
              state.yRange,
            ),
          ],
        );
      },
    );
  }

  Widget _chartCard(String title, Color lineColor, List<FlSpot> sensorData,
      double xRange, double yRange) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.fadeLightBlue,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: lineColor, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          SizedBox(
              height: 200,
              child: _buildLineChart(lineColor, sensorData, yRange, xRange)),
        ],
      ),
    );
  }

  Widget _buildLineChart(
      Color lineColor, List<FlSpot> sensorData, double yRange, double xRange) {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true),
        titlesData: const FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        minX: 0,
        maxX: xRange,
        minY: 0,
        maxY: yRange,
        lineBarsData: [
          LineChartBarData(
            spots: sensorData,
            isCurved: true,
            color: lineColor,
            barWidth: 3,
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
