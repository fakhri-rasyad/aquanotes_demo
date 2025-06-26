import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/tambak/domain/entities/district.dart';
import 'package:aquanotes/features/tambak/domain/entities/province.dart';
import 'package:aquanotes/features/tambak/domain/entities/regency.dart';
import 'package:aquanotes/features/tambak/domain/entities/village.dart';
import 'package:aquanotes/features/tambak/domain/usecases/get_provinces.dart';
import 'package:aquanotes/features/tambak/domain/usecases/post_tambak.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tambak_sreen_state.dart';

class TambakSreenCubit extends Cubit<TambakScreenState> {
  final GetProvinces _getProvinces;
  final PostTambak _postTambak;

  TambakSreenCubit(this._getProvinces, this._postTambak)
      : super(const TambakScreenUpdate(
          name: '',
          negara: 'Indonesia',
          provinsi: null,
          listProvinsi: [],
          kota: null,
          listKota: [],
          kecamatan: null,
          listKecamatan: [],
          desa: null,
          listDesa: [],
          alamat: '',
          jenisBudidaya: '',
          isLoading: false,
        ));

  Future<void> populateData() async {
    try {
      final List<Province> provinces = await _getProvinces(NoParams());
      emit(state.copyWith(listProvinsi: provinces));
    } catch (e) {
      return;
    }
  }

  Future<void> resetInput() async {
    emit(const TambakScreenUpdate(
      name: '',
      negara: 'Indonesia',
      provinsi: null,
      listProvinsi: [],
      kota: null,
      listKota: [],
      kecamatan: null,
      listKecamatan: [],
      desa: null,
      listDesa: [],
      alamat: '',
      jenisBudidaya: '',
      isLoading: false,
    ));
  }

  void onProvinceSelected(String name) {
    emit(state.copyWith(isLoading: true));
    final selected = state.listProvinsi.firstWhere((e) => e.name == name);
    emit(state.copyWith(
        provinsi: name,
        listKota: selected.regencies,
        kota: null,
        listKecamatan: [],
        kecamatan: null,
        listDesa: [],
        desa: null,
        isLoading: false));
  }

  void onKotaSelected(String name) {
    emit(state.copyWith(isLoading: true));
    final selected = state.listKota.firstWhere((e) => e.name == name);
    emit(state.copyWith(
      kota: name,
      listKecamatan: selected.districts,
      kecamatan: null,
      listDesa: [],
      desa: null,
      isLoading: false,
    ));
  }

  void onKecamatanSelected(String name) {
    emit(state.copyWith(isLoading: true));
    final selected = state.listKecamatan.firstWhere((e) => e.name == name);
    emit(state.copyWith(
      kecamatan: name,
      listDesa: selected.village,
      desa: null,
      isLoading: false,
    ));
  }

  void onDesaSelected(String name) {
    emit(state.copyWith(isLoading: true));
    emit(state.copyWith(
      desa: name,
      isLoading: false,
    ));
  }

  void updateTambakFields({
    String? name,
    String? negara,
    String? alamat,
    String? jenisBudidaya,
  }) {
    emit(state.copyWith(
      name: name,
      negara: negara,
      alamat: alamat,
      jenisBudidaya: jenisBudidaya,
    ));
  }

  void postTambak() async {
    emit(state.copyWith(isLoading: true));
    TambakParam param = TambakParam(
        state.name!,
        state.negara!,
        state.provinsi!,
        state.kota!,
        state.kecamatan!,
        state.desa!,
        state.alamat!,
        state.jenisBudidaya!);
    final response = await _postTambak.call(param);
    response.fold((failure) {
      emit(TambakScreenSubmissionFailed(
        message: failure.message,
        current: state as TambakScreenUpdate,
      ));
    }, (model) {
      emit(TambakScreenSubmissionSuccess(
        message: "Tambak ${model.name} telah ditambahkan!",
      ));
    });
  }
}
