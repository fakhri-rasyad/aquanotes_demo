import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'amonie_screen_state.dart';

class AmonieScreenCubit extends Cubit<AmonieScreenState> {
  AmonieScreenCubit() : super(const AmonieScreeUpdate());

  void updateInput(
      {String? kolam, String? temp, String? pH, String? feed, String? volume}) {
    emit(state.copyWith(
        kolam: kolam, temp: temp, pH: pH, feed: feed, volume: volume));
  }

  void resetInput() {
    emit(const AmonieScreeUpdate());
  }

  double calculateAmmonia() {
    double tan = tanValue();
    double pKa = pKaValue();

    return tan * 1 / (1 + pow(10, pKa - double.parse(state.pH)));
  }

  double tanValue() {
    return double.parse(state.feed) * 0.3 / double.parse(state.volume);
  }

  double pKaValue() {
    double kelvinTemp = double.parse(state.temp) + 275.15;
    return 0.09018 + 2729.92 / kelvinTemp;
  }
}
