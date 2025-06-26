part of 'export_data_screen_cubit.dart';

abstract class ExportDataScreenState extends Equatable {
  final String? tambak;
  final String? kolam;
  final String? divais;
  final List<TambakResponseModel>? tambakList;
  final List<KolamRespModel>? kolamList;
  final List<DivaisResponseModel>? divaisList;
  final String? startTime;
  final String? endTime;

  const ExportDataScreenState(
      {this.tambak,
      this.kolam,
      this.divais,
      this.tambakList,
      this.kolamList,
      this.divaisList,
      this.startTime,
      this.endTime});

  ExportDataScreenState copyWith({
    String? tambak,
    String? kolam,
    String? divais,
    List<TambakResponseModel>? tambakList,
    List<KolamRespModel>? kolamList,
    List<DivaisResponseModel>? divaisList,
    String? startTime,
    String? endTime,
  });

  @override
  List<Object?> get props => [
        tambak,
        kolam,
        divais,
        tambakList,
        kolamList,
        divaisList,
        startTime,
        endTime
      ];
}

class ExportDataUpdateState extends ExportDataScreenState {
  const ExportDataUpdateState(
      {super.tambak,
      super.kolam,
      super.divais,
      super.tambakList,
      super.startTime,
      super.endTime,
      super.divaisList,
      super.kolamList});
  @override
  ExportDataScreenState copyWith({
    String? tambak,
    String? kolam,
    String? divais,
    List<TambakResponseModel>? tambakList,
    List<KolamRespModel>? kolamList,
    List<DivaisResponseModel>? divaisList,
    String? startTime,
    String? endTime,
  }) {
    return ExportDataUpdateState(
        tambak: tambak ?? this.tambak,
        kolam: kolam ?? this.kolam,
        divais: divais ?? this.divais,
        tambakList: tambakList ?? this.tambakList,
        divaisList: divaisList ?? this.divaisList,
        kolamList: kolamList ?? this.kolamList,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime);
  }
}

class ExportDataLoading extends ExportDataUpdateState {
  ExportDataLoading({required ExportDataUpdateState current})
      : super(
            tambak: current.tambak,
            kolam: current.kolam,
            divais: current.divais,
            tambakList: current.tambakList,
            kolamList: current.kolamList,
            divaisList: current.divaisList,
            startTime: current.startTime,
            endTime: current.endTime);
}

class ExportDataError extends ExportDataUpdateState {
  final String message;
  ExportDataError(
      {required ExportDataUpdateState current, required this.message})
      : super(
            tambak: current.tambak,
            kolam: current.kolam,
            divais: current.divais,
            tambakList: current.tambakList,
            kolamList: current.kolamList,
            divaisList: current.divaisList,
            startTime: current.startTime,
            endTime: current.endTime);
  @override
  List<Object?> get props => [...super.props, message];
}

class ExportDataSuccess extends ExportDataUpdateState {
  ExportDataSuccess({required ExportDataUpdateState current})
      : super(
            tambak: current.tambak,
            kolam: current.kolam,
            divais: current.divais,
            tambakList: current.tambakList,
            kolamList: current.kolamList,
            divaisList: current.divaisList,
            startTime: current.startTime,
            endTime: current.endTime);
}
