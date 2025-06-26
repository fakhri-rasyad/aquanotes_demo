import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

class FeedvisionState extends Equatable {
  final int selectedTab;
  final List<FlSpot> sensorData;
  final double xRange;
  final double yRange;

  const FeedvisionState({
    this.selectedTab = 0,
    this.sensorData = const [],
    this.xRange = 10,
    this.yRange = 100,
  });

  FeedvisionState copyWith({
    int? selectedTab,
    List<FlSpot>? sensorData,
    double? xRange,
    double? yRange,
  }) {
    return FeedvisionState(
      selectedTab: selectedTab ?? this.selectedTab,
      sensorData: sensorData ?? this.sensorData,
      xRange: xRange ?? this.xRange,
      yRange: yRange ?? this.yRange,
    );
  }

  @override
  List<Object> get props => [selectedTab, sensorData, xRange, yRange];
}
