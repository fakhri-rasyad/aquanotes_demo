part of 'monitoring_screen_cubit.dart';

abstract class MonitoringScreenState extends Equatable {
  final int? selectedTabIndex;
  final MonitorRespModel? monitorRespModel;
  final List<KolamList> kolamData;
  final KolamList? selectedKolam;
  final List<Device> devices;
  final Device? selectedDevice;
  final List<FlSpot> currentDevicePhList;
  final List<FlSpot> currentDeviceTempList;

  const MonitoringScreenState(
      {this.selectedTabIndex,
      this.kolamData = const [],
      this.selectedKolam,
      this.monitorRespModel,
      this.devices = const [],
      this.selectedDevice,
      this.currentDevicePhList = const [],
      this.currentDeviceTempList = const []});

  MonitoringScreenState copyWith({
    int? selectedTabIndex,
    MonitorRespModel? monitorRespModel,
    List<KolamList> kolamData,
    KolamList? selectedKolam,
    List<Device> devices,
    Device? selectedDevice,
    List<FlSpot> currentDevicePhList,
    List<FlSpot> currentDeviceTempList,
  });

  @override
  List<Object?> get props => [
        selectedTabIndex,
        monitorRespModel,
        kolamData,
        selectedKolam,
        devices,
        selectedDevice,
        currentDevicePhList,
        currentDeviceTempList
      ];
}

class MonitoringScreenUpdate extends MonitoringScreenState {
  const MonitoringScreenUpdate(
      {super.selectedTabIndex,
      super.monitorRespModel,
      super.kolamData,
      super.selectedKolam,
      super.devices,
      super.selectedDevice,
      super.currentDevicePhList,
      super.currentDeviceTempList});

  @override
  MonitoringScreenState copyWith(
      {int? selectedTabIndex,
      MonitorRespModel? monitorRespModel,
      List<KolamList>? kolamData,
      KolamList? selectedKolam,
      List<Device>? devices,
      Device? selectedDevice,
      List<FlSpot>? currentDevicePhList = const [],
      List<FlSpot>? currentDeviceTempList = const []}) {
    return MonitoringScreenUpdate(
        selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
        monitorRespModel: monitorRespModel ?? this.monitorRespModel,
        kolamData: kolamData ?? this.kolamData,
        selectedKolam: selectedKolam ?? this.selectedKolam,
        devices: devices ?? this.devices,
        selectedDevice: selectedDevice ?? this.selectedDevice,
        currentDevicePhList: currentDevicePhList ?? this.currentDevicePhList,
        currentDeviceTempList:
            currentDeviceTempList ?? this.currentDeviceTempList);
  }
}

class MonitoringScreenLoading extends MonitoringScreenUpdate {
  MonitoringScreenLoading({required MonitoringScreenUpdate current})
      : super(
            selectedTabIndex: current.selectedTabIndex,
            devices: current.devices,
            kolamData: current.kolamData,
            selectedDevice: current.selectedDevice,
            selectedKolam: current.selectedKolam,
            monitorRespModel: current.monitorRespModel,
            currentDevicePhList: current.currentDevicePhList,
            currentDeviceTempList: current.currentDeviceTempList);

  @override
  List<Object?> get props => [...super.props];
}

class MonitoringScreenError extends MonitoringScreenUpdate {
  final String message;
  const MonitoringScreenError(
      {required this.message, required MonitoringScreenUpdate current});
  @override
  List<Object?> get props => [...super.props];
}
