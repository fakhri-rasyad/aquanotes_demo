import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'performa_screen_state.dart';

class PerformaScreenCubit extends Cubit<PerformaScreenState> {
  PerformaScreenCubit()
      : super(const PerformaScreenUpdate(
            pakanHarian: "",
            pakanKumulatif: "",
            meanBobotUdang: "",
            feedRate: "",
            jumlahTebar: "",
            showPredictionResult: false));

  void updateValues(
      {String? pakanHarian,
      String? pakanKumulatif,
      String? meanBobotUdang,
      String? feedRate,
      String? jumlahTebar,
      bool? showPredictionResult}) {
    emit(state.copyWith(
        pakanHarian: pakanHarian,
        pakanKumulatif: pakanKumulatif,
        meanBobotUdang: meanBobotUdang,
        feedRate: feedRate,
        jumlahTebar: jumlahTebar,
        showPredictionResult: showPredictionResult));
  }

  void resetInput() {
    emit(const PerformaScreenUpdate(
        pakanHarian: "",
        pakanKumulatif: "",
        meanBobotUdang: "",
        feedRate: "",
        jumlahTebar: "",
        showPredictionResult: false));
  }

  double calculateBiomassa() {
    return double.parse(state.pakanHarian) /
        (double.parse(state.feedRate) / 100);
  }

  double calculatePopulasi() {
    return calculateBiomassa() / double.parse(state.meanBobotUdang) * 1000;
  }

  double calculateFcr() {
    return double.parse(state.pakanKumulatif) / calculateBiomassa();
  }

  double calculateSurvivalRate() {
    return calculatePopulasi() / double.parse(state.jumlahTebar) * 100;
  }
}
