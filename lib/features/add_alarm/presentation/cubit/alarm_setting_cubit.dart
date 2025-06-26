import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/add_alarm/domain/usecase/add_alarm_get_divais.dart';
import 'package:aquanotes/features/add_alarm/presentation/cubit/alarm_setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlarmSettingCubit extends Cubit<AlarmSettingState> {
  AlarmSettingCubit(this.getDivais)
      : super(const AlarmSettingUpdate(settings: [
          SensorSetting(name: "Suhu", min: 70, max: 32),
          SensorSetting(name: "pH", min: 6.5, max: 8),
          SensorSetting(name: "Salinitas", min: 30, max: 35),
          SensorSetting(name: "Oksigen Terlarut", min: 5, max: 10),
          SensorSetting(name: "Amonia", min: 0.1, max: 0.5),
        ]));

  final AddAlarmGetDivais getDivais;
  AlarmSettingUpdate get current => state as AlarmSettingUpdate;

  void updateSetting(String name, double newMin, double newMax) {
    final updatedSettings = state.settings?.map((s) {
      return s.name == name ? s.copyWith(min: newMin, max: newMax) : s;
    }).toList();

    emit(state.copyWith(settings: updatedSettings));
  }

  void updateDivais(final divais) {
    final device = state.divaisList!.where((e) => e == divais).first;
    emit(state.copyWith(divais: device));
  }

  Future<void> populateDropdown() async {
    emit(AlarmSettingLoading(current: current));
    final response = await getDivais.call(NoParams());
    response.fold((error) {
      emit(AlarmSettingError(current: current, message: error));
    }, (model) {
      emit(state.copyWith(divaisList: model));
    });
  }

  Future<void> sendData() async {
    emit(AlarmSettingLoading(current: current));
    await Future.delayed(const Duration(seconds: 3));
    emit(AlarmSettingSuccess(current: current));
  }
}
