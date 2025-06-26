import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:equatable/equatable.dart';

class SensorSetting extends Equatable {
  final String name;
  final double min;
  final double max;

  const SensorSetting({
    required this.name,
    required this.min,
    required this.max,
  });

  SensorSetting copyWith({double? min, double? max}) {
    return SensorSetting(
      name: name,
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }

  @override
  List<Object?> get props => [min, max, name];
}

abstract class AlarmSettingState extends Equatable {
  final List<SensorSetting>? settings;
  final List<DivaisResponseModel>? divaisList;
  final DivaisResponseModel? divais;

  const AlarmSettingState({this.settings, this.divaisList, this.divais});

  AlarmSettingState copyWith(
      {List<SensorSetting>? settings,
      List<DivaisResponseModel>? divaisList,
      DivaisResponseModel? divais});

  @override
  List<Object?> get props => [settings, divaisList];
}

class AlarmSettingUpdate extends AlarmSettingState {
  const AlarmSettingUpdate({super.settings, super.divaisList, super.divais});
  @override
  AlarmSettingState copyWith(
      {List<SensorSetting>? settings,
      List<DivaisResponseModel>? divaisList,
      DivaisResponseModel? divais}) {
    return AlarmSettingUpdate(
        settings: settings ?? this.settings,
        divaisList: divaisList ?? this.divaisList,
        divais: divais ?? this.divais);
  }

  @override
  List<Object?> get props => [...super.props];
}

class AlarmSettingError extends AlarmSettingUpdate {
  final String message;
  AlarmSettingError(
      {required AlarmSettingUpdate current, required this.message})
      : super(
            divais: current.divais,
            divaisList: current.divaisList,
            settings: current.settings);
  @override
  List<Object?> get props => [...super.props, message];
}

class AlarmSettingLoading extends AlarmSettingUpdate {
  AlarmSettingLoading({required AlarmSettingUpdate current})
      : super(
            divais: current.divais,
            divaisList: current.divaisList,
            settings: current.settings);
}

class AlarmSettingSuccess extends AlarmSettingUpdate {
  AlarmSettingSuccess({required AlarmSettingUpdate current})
      : super(
            divais: current.divais,
            divaisList: current.divaisList,
            settings: current.settings);
}
