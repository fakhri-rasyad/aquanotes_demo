part of 'tambak_sreen_cubit.dart';

@immutable
abstract class TambakScreenState extends Equatable {
  final String? name;
  final String? negara;
  final String? provinsi;
  final List<Province> listProvinsi;
  final String? kota;
  final List<Regency> listKota;
  final String? kecamatan;
  final List<District> listKecamatan;
  final String? desa;
  final List<Village> listDesa;
  final String? alamat;
  final String? jenisBudidaya;
  final bool? isLoading;

  const TambakScreenState({
    this.name,
    this.negara,
    this.provinsi,
    this.listProvinsi = const [],
    this.kota,
    this.listKota = const [],
    this.kecamatan,
    this.listKecamatan = const [],
    this.desa,
    this.listDesa = const [],
    this.alamat,
    this.jenisBudidaya,
    this.isLoading = false,
  });

  TambakScreenState copyWith({
    String? name,
    String? negara,
    String? provinsi,
    List<Province>? listProvinsi,
    String? kota,
    List<Regency>? listKota,
    String? kecamatan,
    List<District>? listKecamatan,
    String? desa,
    List<Village>? listDesa,
    String? alamat,
    String? jenisBudidaya,
    bool? isLoading,
  });

  @override
  List<Object?> get props => [
        name,
        negara,
        provinsi,
        listProvinsi,
        kota,
        listKota,
        kecamatan,
        listKecamatan,
        desa,
        listDesa,
        alamat,
        jenisBudidaya,
        isLoading,
      ];
}

class TambakScreenUpdate extends TambakScreenState {
  const TambakScreenUpdate({
    super.name,
    super.negara,
    super.provinsi,
    super.listProvinsi = const [],
    super.kota,
    super.listKota = const [],
    super.kecamatan,
    super.listKecamatan = const [],
    super.desa,
    super.listDesa = const [],
    super.alamat,
    super.jenisBudidaya,
    super.isLoading = false,
  });

  @override
  TambakScreenState copyWith({
    String? name,
    String? negara,
    String? provinsi,
    List<Province>? listProvinsi,
    String? kota,
    List<Regency>? listKota,
    String? kecamatan,
    List<District>? listKecamatan,
    String? desa,
    List<Village>? listDesa,
    String? alamat,
    String? jenisBudidaya,
    bool? isLoading,
  }) {
    return TambakScreenUpdate(
      name: name ?? this.name,
      negara: negara ?? this.negara,
      provinsi: provinsi ?? this.provinsi,
      listProvinsi: listProvinsi ?? this.listProvinsi,
      kota: kota ?? this.kota,
      listKota: listKota ?? this.listKota,
      kecamatan: kecamatan ?? this.kecamatan,
      listKecamatan: listKecamatan ?? this.listKecamatan,
      desa: desa ?? this.desa,
      listDesa: listDesa ?? this.listDesa,
      alamat: alamat ?? this.alamat,
      jenisBudidaya: jenisBudidaya ?? this.jenisBudidaya,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class TambakScreenSubmissionFailed extends TambakScreenUpdate {
  final String message;

  TambakScreenSubmissionFailed({
    required this.message,
    required TambakScreenUpdate current,
  }) : super(
          name: current.name,
          negara: current.negara,
          provinsi: current.provinsi,
          listProvinsi: current.listProvinsi,
          kota: current.kota,
          listKota: current.listKota,
          kecamatan: current.kecamatan,
          listKecamatan: current.listKecamatan,
          desa: current.desa,
          listDesa: current.listDesa,
          alamat: current.alamat,
          jenisBudidaya: current.jenisBudidaya,
          isLoading: false,
        );

  @override
  List<Object?> get props => [...super.props, message];
}

class TambakScreenSubmissionSuccess extends TambakScreenUpdate {
  final String message;

  const TambakScreenSubmissionSuccess({
    required this.message,
  }) : super(
          name: '',
          negara: 'Indonesia',
          provinsi: null,
          listProvinsi: const [],
          kota: null,
          listKota: const [],
          kecamatan: null,
          listKecamatan: const [],
          desa: null,
          listDesa: const [],
          alamat: '',
          jenisBudidaya: '',
          isLoading: false,
        );

  @override
  List<Object?> get props => [...super.props, message];
}
