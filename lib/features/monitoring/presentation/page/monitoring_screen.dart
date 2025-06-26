import 'package:aquanotes/features/monitoring/data/model/device.dart';
import 'package:aquanotes/features/monitoring/data/model/kolam_list.dart';
import 'package:aquanotes/features/monitoring/presentation/cubit/monitoring_screen_cubit.dart';
import 'package:aquanotes/features/export_data/presentation/page/export_data_screen.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_appbar.dart';
import 'package:aquanotes/shared/presentation/widgets/loading_overlay.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class MonitoringScreen extends StatefulWidget {
  static const routeName = "/monitoring";

  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MonitoringScreenCubit>().getData();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MonitoringScreenCubit>();
    return BlocConsumer<MonitoringScreenCubit, MonitoringScreenState>(
      listener: (context, state) {
        if (state is MonitoringScreenError) {
          final snackBar = SnackBar(content: Text(state.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        Widget body;

        if (state is MonitoringScreenLoading) {
          body = const LoadingOverlay();
        } else if (state.kolamData.isEmpty) {
          body = const Center(child: Text("Data monitoring belum tersedia."));
        } else {
          body = Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildInfoCards(
                    state.selectedDevice, state.devices, cubit.selectDevice),
                const SizedBox(height: 12),
                _buildTabBar(
                  context.read<MonitoringScreenCubit>().selectKolam,
                  state.kolamData,
                  state.selectedTabIndex ?? 0,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: _buildChartSection(
                    state.currentDeviceTempList,
                    state.currentDevicePhList,
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            titleText: "Pantau Kolam",
            actions: [
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(ExportDataScreen.routeName);
                },
                icon: const Icon(Icons.download, color: Colors.blue),
                label: const Text("Ekspor Data",
                    style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          body: body,
        );
      },
    );
  }

  /// Builds the information section with date, weather, and device info
  Widget _buildInfoCards(Device? device, List<Device> diveciList,
      void Function(Device) changeDivais) {
    if (device == null) {
      return const Expanded(
        child: Center(
          child: Text(
            "Kolam belum memiliki perangkat terpasang.",
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
        ),
      );
    }
    final timestamp = DateTime.parse(device.latestData.timestamp);
    final formattedTime = DateFormat("dd MMM yyyy").format(timestamp);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _infoCard(Icons.wb_sunny, "$formattedTime\n${device.latestData.suhu}"),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.skyBlue,
                    AppColors.blueAccent,
                  ]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Device>(
                borderRadius: BorderRadius.circular(8.0),
                value: device,
                iconEnabledColor: Colors.white,
                dropdownColor: AppColors.gradientStart,
                style: const TextStyle(color: Colors.white),
                isExpanded: true,
                items: diveciList.map((device) {
                  return DropdownMenuItem<Device>(
                    value: device,
                    child: Text("${device.name} (ID: ${device.id})"),
                  );
                }).toList(),
                onChanged: (device) {
                  if (device != null) {
                    changeDivais(device);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoCard(IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.skyBlue,
                AppColors.blueAccent,
              ]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(text,
                  style: const TextStyle(color: Colors.white, fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(
      Function(int) onTap, List<KolamList> listKolam, int selectedIndex) {
    if (listKolam.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Tambak ini belum memiliki kolam",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(listKolam.length, (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: selectedIndex == index ? Colors.blue : Colors.white30,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  listKolam[index].nama,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color:
                        selectedIndex == index ? Colors.white : Colors.black54,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildChartSection(List<FlSpot> suhuData, List<FlSpot> phData) {
    return ListView(
      children: [
        const SizedBox(height: 12),
        const Text(
          "Parameter Fisika",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _chartCard("Sensor Suhu", Colors.orange, suhuData,
            suhuData.length.toDouble(), 40),
        const SizedBox(height: 12),
        const Text("Parameter Kimia",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _chartCard(
            "Sensor PH", Colors.green, phData, phData.length.toDouble(), 15),
      ],
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
          if (sensorData.isEmpty)
            const SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  "Data belum tersedia",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            )
          else
            SizedBox(
              height: 200,
              child: _buildLineChart(lineColor, sensorData, yRange, xRange),
            ),
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
