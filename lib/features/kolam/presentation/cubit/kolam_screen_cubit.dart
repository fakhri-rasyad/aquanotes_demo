import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:aquanotes/features/kolam/data/model/kolam_req_model.dart';
import 'package:aquanotes/features/kolam/domain/usecase/get_divais.dart';
import 'package:aquanotes/features/kolam/domain/usecase/get_tambak.dart';
import 'package:aquanotes/features/kolam/domain/usecase/post_kolam.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'kolam_screen_state.dart';

class KolamScreenCubit extends Cubit<KolamScreenState> {
  KolamScreenCubit(this.getDivais, this.getTambak, this.postKolam)
      : super(const KolamScreenUpdate());

  final GetTambak getTambak;
  final GetDivais getDivais;
  final PostKolam postKolam;

  KolamScreenUpdate get current => state as KolamScreenUpdate;

  void resetInput() {
    emit(state.copyWith(
        tambak: "",
        listTambak: [],
        kolam: "",
        tipeKolam: "",
        komoditas: "",
        divais: "",
        listDivais: [],
        panjang: "",
        lebar: "",
        kedalaman: ""));
  }

  void updateKolam({
    String? tambak,
    List<TambakResponseModel>? listTambak,
    String? kolam,
    String? tipeKolam,
    String? komoditas,
    String? divais,
    List<DivaisResponseModel>? listDivais,
    String? panjang,
    String? lebar,
    String? kedalaman,
  }) {
    emit(state.copyWith(
      tambak: tambak,
      listTambak: listTambak,
      kolam: kolam,
      tipeKolam: tipeKolam,
      komoditas: komoditas,
      divais: divais,
      listDivais: listDivais,
      panjang: panjang,
      lebar: lebar,
      kedalaman: kedalaman,
    ));
  }

  Future<void> getData() async {
    emit(KolamScreenLoading(current: current));
    await populateTambakList();

    if (state is KolamScreenError) return;

    await populateDivaisList();
  }

  Future<void> populateTambakList() async {
    final tambakResponse = await getTambak.call(NoParams());
    tambakResponse.fold((error) {
      emit(KolamScreenError(current: current, msg: error));
    }, (model) {
      final listTambak = model;
      emit(state.copyWith(listTambak: listTambak));
    });
  }

  Future<void> populateDivaisList() async {
    final divaisResponse = await getDivais.call(NoParams());
    divaisResponse.fold((error) {
      emit(KolamScreenError(current: current, msg: error));
    }, (model) {
      final listDivais = model;
      emit(state.copyWith(listDivais: listDivais));
    });
  }

  void processData() async {
    emit(KolamScreenLoading(current: current));
    final divaisId =
        state.listDivais!.where((e) => e.name == state.divais).first.id;
    final tambakId =
        state.listTambak!.where((e) => e.name == state.tambak).first.id;
    KolamReqModel reqModel = KolamReqModel(
        state.kolam ?? "",
        state.tipeKolam ?? "",
        int.parse(state.panjang ?? "0"),
        int.parse(state.lebar ?? "0"),
        int.parse(state.kedalaman ?? "0"),
        state.komoditas ?? "",
        tambakId,
        divaisId);

    final response = await postKolam.call(reqModel);

    response.fold((error) {
      emit(KolamScreenError(msg: error, current: current));
    }, (model) {
      emit(KolamScreenSuccess(current: current));
    });
  }
}
