import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/export_data/domain/usecase/expo_get_divais.dart';
import 'package:aquanotes/features/export_data/domain/usecase/expo_get_kolam.dart';
import 'package:aquanotes/features/export_data/domain/usecase/expo_get_tambak.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:aquanotes/shared/data/model/kolam_resp_model.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'export_data_screen_state.dart';

class ExportDataScreenCubit extends Cubit<ExportDataScreenState> {
  ExportDataScreenCubit(this.getDivais, this.getKolam, this.getTambak)
      : super(const ExportDataUpdateState());

  final ExpoGetTambak getTambak;
  final ExpoGetDivais getDivais;
  final ExpoGetKolam getKolam;

  ExportDataUpdateState get current => state as ExportDataUpdateState;

  Future<void> getData() async {
    emit(ExportDataLoading(current: current));
    await populateTambak();
    if (state is ExportDataError) return;
    await populateDivais();

    if (state is ExportDataError) return;
    await populateKolam();
  }

  Future<void> resetInput() async {
    emit(const ExportDataUpdateState());
  }

  Future<void> populateTambak() async {
    final tambakList = await getTambak.call(NoParams());

    tambakList.fold((error) {
      emit(ExportDataError(current: current, message: error));
    }, (model) {
      emit(state.copyWith(tambakList: model));
    });
  }

  Future<void> populateDivais() async {
    final divaisList = await getDivais.call(NoParams());

    divaisList.fold((error) {
      emit(ExportDataError(current: current, message: "$error Divais"));
    }, (model) {
      emit(state.copyWith(divaisList: model));
    });
  }

  Future<void> populateKolam() async {
    if (state.tambakList != null && state.tambakList!.isNotEmpty) {
      final tambakId = state.tambakList!.first.id;
      final kolamList = await getKolam.call(tambakId);

      kolamList.fold((error) {
        emit(ExportDataError(current: current, message: "$error kolam"));
      }, (model) {
        emit(state.copyWith(kolamList: model));
      });
    }
  }

  void updateData({
    String? tambak,
    String? kolam,
    String? divais,
    List<TambakResponseModel>? tambakList,
    List<KolamRespModel>? kolamList,
    List<DivaisResponseModel>? divaisList,
    String? startTime,
    String? endTime,
  }) {
    emit(state.copyWith(
        tambak: tambak,
        kolam: kolam,
        divais: divais,
        tambakList: tambakList,
        kolamList: kolamList,
        divaisList: divaisList,
        startTime: startTime,
        endTime: endTime));
  }

  void processData() async {
    emit(ExportDataLoading(current: current));

    try {
      await Future.delayed(const Duration(seconds: 3));
      emit(ExportDataSuccess(current: current));
    } catch (e) {
      emit(ExportDataError(current: current, message: e.toString()));
    }
  }
}
