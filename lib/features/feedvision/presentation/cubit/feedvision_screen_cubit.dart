import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feedvision_screen_state.dart';

class FeedvisionCubit extends Cubit<FeedvisionState> {
  FeedvisionCubit() : super(const FeedvisionState());

  void selectTab(int index) {
    emit(state.copyWith(selectedTab: index));
  }

  void updateChartData(List<FlSpot> data, double xRange, double yRange) {
    emit(state.copyWith(sensorData: data, xRange: xRange, yRange: yRange));
  }
}
