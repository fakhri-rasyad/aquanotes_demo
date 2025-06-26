part of 'performa_screen_cubit.dart';

sealed class PerformaScreenState extends Equatable {
  final String pakanHarian;
  final String pakanKumulatif;
  final String meanBobotUdang;
  final String feedRate;
  final String jumlahTebar;
  final bool showPredictionResult;
  const PerformaScreenState({
    this.pakanHarian = "",
    this.pakanKumulatif = "",
    this.meanBobotUdang = "",
    this.feedRate = "",
    this.jumlahTebar = "",
    this.showPredictionResult = false,
  });

  PerformaScreenState copyWith(
      {String? pakanHarian,
      String? pakanKumulatif,
      String? meanBobotUdang,
      String? feedRate,
      String? jumlahTebar,
      bool? showPredictionResult});

  @override
  List<Object> get props => [
        pakanHarian,
        pakanKumulatif,
        meanBobotUdang,
        feedRate,
        jumlahTebar,
        showPredictionResult
      ];
}

final class PerformaScreenUpdate extends PerformaScreenState {
  const PerformaScreenUpdate(
      {super.pakanHarian,
      super.pakanKumulatif,
      super.meanBobotUdang,
      super.feedRate,
      super.jumlahTebar,
      super.showPredictionResult});

  @override
  PerformaScreenState copyWith(
      {String? pakanHarian,
      String? pakanKumulatif,
      String? meanBobotUdang,
      String? feedRate,
      String? jumlahTebar,
      bool? showPredictionResult}) {
    return PerformaScreenUpdate(
        pakanHarian: pakanHarian ?? this.pakanHarian,
        pakanKumulatif: pakanKumulatif ?? this.pakanKumulatif,
        meanBobotUdang: meanBobotUdang ?? this.meanBobotUdang,
        feedRate: feedRate ?? this.feedRate,
        jumlahTebar: jumlahTebar ?? this.jumlahTebar,
        showPredictionResult:
            showPredictionResult ?? this.showPredictionResult);
  }
}
