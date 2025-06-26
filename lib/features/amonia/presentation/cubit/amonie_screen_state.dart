part of 'amonie_screen_cubit.dart';

sealed class AmonieScreenState extends Equatable {
  final String kolam;
  final String temp;
  final String pH;
  final String volume;
  final String feed;
  const AmonieScreenState(
      {this.kolam = "",
      this.feed = "",
      this.pH = "",
      this.temp = "",
      this.volume = ""});

  AmonieScreenState copyWith({
    String? kolam,
    String? temp,
    String? pH,
    String? volume,
    String? feed,
  });

  @override
  List<Object> get props => [kolam, temp, pH, volume, feed];
}

class AmonieScreeUpdate extends AmonieScreenState {
  const AmonieScreeUpdate(
      {super.kolam, super.temp, super.pH, super.volume, super.feed});

  @override
  AmonieScreenState copyWith(
      {String? kolam, String? temp, String? pH, String? volume, String? feed}) {
    return AmonieScreeUpdate(
        kolam: kolam ?? this.kolam,
        temp: temp ?? this.temp,
        pH: pH ?? this.pH,
        volume: volume ?? this.volume,
        feed: feed ?? this.feed);
  }
}
