import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/monitoring/data/model/device.dart';
import 'package:aquanotes/features/monitoring/data/model/device_data.dart';
import 'package:aquanotes/features/monitoring/data/model/kolam_list.dart';
import 'package:aquanotes/features/monitoring/data/model/monitor_resp_model.dart';
import 'package:aquanotes/features/monitoring/domain/usecase/get_monitoring.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'monitoring_screen_state.dart';

class MonitoringScreenCubit extends Cubit<MonitoringScreenState> {
  final GetMonitoring getMonitoring;

  MonitoringScreenCubit(this.getMonitoring)
      : super(const MonitoringScreenUpdate());

  Future<void> getData() async {
    emit(MonitoringScreenLoading(current: state as MonitoringScreenUpdate));
    // MonitorRespModel mockMonitorRespModel;
    final response = await getMonitoring.call(NoParams());
    response.fold((e) {
      emit(MonitoringScreenError(
          message: e, current: state as MonitoringScreenUpdate));
    }, (model) {
      // mockMonitorRespModel = mockData();
      // print(mockMonitorRespModel);
      handleInitData(model);
    });
  }

  void selectKolam(int kolamIndex) {
    final selectedKolam = state.kolamData[kolamIndex];
    final deviceList = selectedKolam.devices;
    final firstDevice = deviceList.isNotEmpty ? deviceList.first : null;

    List<FlSpot> phData = [];
    List<FlSpot> suhuData = [];

    if (firstDevice != null) {
      final historicalDataExist = firstDevice.historicalData.isNotEmpty;
      phData = historicalDataExist
          ? generateFlSpot(firstDevice.historicalData, (e) => e.ph.toDouble())
          : [];
      suhuData = historicalDataExist
          ? generateFlSpot(firstDevice.historicalData, (e) => e.suhu.toDouble())
          : [];
    }
    emit(state.copyWith(
      selectedKolam: selectedKolam,
      selectedTabIndex: kolamIndex,
      devices: deviceList,
      selectedDevice: firstDevice,
      currentDevicePhList: phData,
      currentDeviceTempList: suhuData,
    ));
  }

  void selectDevice(Device device) {
    final selectedDevice = state.devices.where((e) => e == device).first;

    List<FlSpot> phData = [];
    List<FlSpot> suhuData = [];

    final historicalDataExist = selectedDevice.historicalData.isNotEmpty;
    phData = historicalDataExist
        ? generateFlSpot(selectedDevice.historicalData, (e) => e.ph.toDouble())
        : [];
    suhuData = historicalDataExist
        ? generateFlSpot(
            selectedDevice.historicalData, (e) => e.suhu.toDouble())
        : [];

    emit(state.copyWith(
      selectedDevice: selectedDevice,
      currentDevicePhList: phData,
      currentDeviceTempList: suhuData,
    ));
  }

  Future<void> handleInitData(MonitorRespModel mockMonitorRespModel) async {
    final kolamExist = mockMonitorRespModel.kolamList.isNotEmpty;
    final firstKolam = kolamExist ? mockMonitorRespModel.kolamList.first : null;

    final kolamDevicesExist =
        firstKolam != null ? firstKolam.devices.isNotEmpty : false;
    final firstDevice = kolamDevicesExist ? firstKolam.devices.first : null;

    final historyDataExist =
        firstDevice != null ? firstDevice.historicalData.isNotEmpty : false;
    final List<DeviceData> historyDataList =
        historyDataExist ? firstDevice.historicalData : [];

    emit(MonitoringScreenUpdate(
        selectedTabIndex: kolamExist ? 0 : null,
        kolamData: kolamExist ? mockMonitorRespModel.kolamList : [],
        selectedKolam: firstKolam,
        monitorRespModel: mockMonitorRespModel,
        devices: kolamDevicesExist ? firstKolam.devices : [],
        selectedDevice: firstDevice,
        currentDevicePhList: historyDataExist
            ? generateFlSpot(historyDataList, (d) => d.ph.toDouble())
            : [],
        currentDeviceTempList: historyDataExist
            ? generateFlSpot(historyDataList, (d) => d.suhu.toDouble())
            : []));
  }
}

MonitorRespModel mockData() {
  return MonitorRespModel(
    [
      KolamList(
        0,
        "Kolam A",
        [
          Device(
            0,
            "Device A1",
            const DeviceData(30, 7, 6, 100, 1, 5, "2025-06-14T01:25:54.919Z"),
            List.generate(10, (index) {
              final timestamp = DateTime.now()
                  .subtract(Duration(hours: 10 - index))
                  .toIso8601String();
              return DeviceData(
                27 + index,
                7 + (index % 2),
                6,
                100,
                1,
                5,
                timestamp,
              );
            }),
          ),
          Device(
            1,
            "Device A2",
            const DeviceData(29, 6, 5, 95, 2, 4, "2025-06-14T01:30:00.000Z"),
            List.generate(10, (index) {
              final timestamp = DateTime.now()
                  .subtract(Duration(hours: 10 - index))
                  .toIso8601String();
              return DeviceData(
                26 + index,
                6 + (index % 3),
                5,
                95,
                2,
                4,
                timestamp,
              );
            }),
          ),
        ],
      ),
      KolamList(
        1,
        "Kolam B",
        [
          Device(
            2,
            "Device B1",
            const DeviceData(28, 6, 5, 90, 1, 4, "2025-06-14T01:25:54.919Z"),
            List.generate(10, (index) {
              final timestamp = DateTime.now()
                  .subtract(Duration(hours: 10 - index))
                  .toIso8601String();
              return DeviceData(
                25 + index,
                6 + (index % 2),
                5,
                90,
                1,
                4,
                timestamp,
              );
            }),
          ),
          Device(
            3,
            "Device B2",
            const DeviceData(27, 5, 4, 85, 1, 3, "2025-06-14T01:35:00.000Z"),
            List.generate(10, (index) {
              final timestamp = DateTime.now()
                  .subtract(Duration(hours: 10 - index))
                  .toIso8601String();
              return DeviceData(
                24 + index,
                5 + (index % 2),
                4,
                85,
                1,
                3,
                timestamp,
              );
            }),
          ),
        ],
      ),
      KolamList(
        2,
        "Kolam C",
        [
          Device(
            4,
            "Device C1",
            const DeviceData(31, 7, 6, 110, 2, 6, "2025-06-14T02:00:00.000Z"),
            List.generate(10, (index) {
              final timestamp = DateTime.now()
                  .subtract(Duration(hours: 10 - index))
                  .toIso8601String();
              return DeviceData(
                28 + index,
                7 + (index % 2),
                6,
                110,
                2,
                6,
                timestamp,
              );
            }),
          ),
          Device(
            5,
            "Device C2",
            const DeviceData(32, 6, 5, 105, 2, 5, "2025-06-14T02:10:00.000Z"),
            List.generate(10, (index) {
              final timestamp = DateTime.now()
                  .subtract(Duration(hours: 10 - index))
                  .toIso8601String();
              return DeviceData(
                29 + index,
                6 + (index % 2),
                5,
                105,
                2,
                5,
                timestamp,
              );
            }),
          ),
        ],
      ),
      KolamList(
        3,
        "Kolam D",
        [
          Device(
            6,
            "Device D1",
            const DeviceData(30, 7, 6, 98, 1, 5, "2025-06-14T02:15:00.000Z"),
            List.generate(10, (index) {
              final timestamp = DateTime.now()
                  .subtract(Duration(hours: 10 - index))
                  .toIso8601String();
              return DeviceData(
                27 + index,
                7 + (index % 2),
                6,
                98,
                1,
                5,
                timestamp,
              );
            }),
          ),
          Device(
            7,
            "Device D2",
            const DeviceData(29, 6, 5, 92, 1, 4, "2025-06-14T02:20:00.000Z"),
            List.generate(10, (index) {
              final timestamp = DateTime.now()
                  .subtract(Duration(hours: 10 - index))
                  .toIso8601String();
              return DeviceData(
                26 + index,
                6 + (index % 2),
                5,
                92,
                1,
                4,
                timestamp,
              );
            }),
          ),
        ],
      ),
    ],
    0, // current_device_id
    0, // current_kolam_id
  );
}

List<FlSpot> generateFlSpot(
  List<DeviceData> data,
  double Function(DeviceData d) valueSelector,
) {
  return List.generate(
    data.length,
    (i) => FlSpot(i.toDouble(), valueSelector(data[i])),
  );
}
