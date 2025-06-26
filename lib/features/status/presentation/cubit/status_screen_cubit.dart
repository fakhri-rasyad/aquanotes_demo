import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/status/domain/entities/info_card_data.dart';
import 'package:aquanotes/features/status/domain/usecase/get_divais_status.dart';
import 'package:aquanotes/features/status/domain/usecase/get_kolam_status.dart';
import 'package:aquanotes/features/status/domain/usecase/get_tambak_status.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:aquanotes/shared/data/model/kolam_resp_model.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'status_screen_state.dart';

class StatusScreenCubit extends Cubit<StatusScreenState> {
  StatusScreenCubit(
      this.getTambakStatus, this.getDivaisStatus, this.getKolamStatus)
      : super(const StatusScreenUpdate());

  final GetTambakStatus getTambakStatus;
  final GetDivaisStatus getDivaisStatus;
  final GetKolamStatus getKolamStatus;

  void updateTab(int index) {
    final current = state as StatusScreenUpdate;

    List<dynamic>? selectedList;
    List<InfoCardData>? data;
    if (index == 0) {
      data = current.tambakData
          ?.map((e) => InfoCardData(
              title: e.name,
              subtitle: e.cultivationType,
              statusText: e.id.toString()))
          .toList();
      selectedList = data;
    } else if (index == 1) {
      data = current.kolamData
          ?.map((e) => InfoCardData(
              title: e.nama,
              subtitle: e.komoditas,
              statusText: e.id.toString()))
          .toList();
      selectedList = data;
    } else if (index == 2) {
      data = current.divaisData
          ?.map((e) => InfoCardData(
              title: e.name, subtitle: e.uid, statusText: e.id.toString()))
          .toList();
      selectedList = data;
    }

    emit(StatusScreenUpdate(
      selectedTab: index,
      tambakData: current.tambakData,
      kolamData: current.kolamData,
      divaisData: current.divaisData,
      selectedList: selectedList,
    ));
  }

  void getData() async {
    emit(StatusScreenLoading(current: state as StatusScreenUpdate));
    final tambakList = await getTambakStatus(NoParams());

    List<TambakResponseModel> listTambak = [
      TambakResponseModel(0, "name - 0", "uid - 0"),
      TambakResponseModel(0, "name - 1", "uid - 1"),
      TambakResponseModel(0, "name - 2", "uid - 2"),
    ];

    tambakList.fold((error) {
      emit(StatusScreenError(current: state as StatusScreenUpdate, msg: error));
    }, (model) {
      listTambak = model;
    });

    final divaisList = await getDivaisStatus(NoParams());

    List<DivaisResponseModel> listDivais = [
      DivaisResponseModel(0, "Name - 0", "UID - 0"),
      DivaisResponseModel(1, "Name - 1", "UID - 1"),
      DivaisResponseModel(0, "Name - 2", "UID - 2"),
      DivaisResponseModel(1, "Name - 3", "UID - 3"),
    ];

    divaisList.fold((error) {
      emit(StatusScreenError(current: state as StatusScreenUpdate, msg: error));
    }, (model) {
      listDivais = model;
    });

    int tambakId = listTambak.isEmpty ? 0 : listTambak.first.id;

    final kolamList = await getKolamStatus(tambakId);

    List<KolamRespModel> listKolam = [
      KolamRespModel(0, "Name - 0", "UID - 0"),
      KolamRespModel(1, "Name - 1", "UID - 1"),
    ];

    kolamList.fold((error) {
      emit(StatusScreenError(current: state as StatusScreenUpdate, msg: error));
    }, (model) {
      listKolam = model;
    });

    List<InfoCardData>? data = listTambak
        .map((e) => InfoCardData(
            title: e.name,
            subtitle: e.cultivationType,
            statusText: e.id.toString()))
        .toList();
    emit(StatusScreenUpdate(
        tambakData: listTambak,
        divaisData: listDivais,
        kolamData: listKolam,
        selectedList: data));
  }
}
