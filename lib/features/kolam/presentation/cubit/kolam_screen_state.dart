part of 'kolam_screen_cubit.dart';

abstract class KolamScreenState extends Equatable {
  final String? tambak;
  final List<TambakResponseModel>? listTambak;
  final String? kolam;
  final String? tipeKolam;
  final String? komoditas;
  final String? divais;
  final List<DivaisResponseModel>? listDivais;
  final String? panjang;
  final String? lebar;
  final String? kedalaman;

  const KolamScreenState({
    this.tambak,
    this.listTambak,
    this.kolam,
    this.tipeKolam,
    this.komoditas,
    this.divais,
    this.listDivais,
    this.panjang,
    this.lebar,
    this.kedalaman,
  });

  KolamScreenState copyWith({
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
  });
  @override
  List<Object?> get props => [
        tambak,
        listTambak,
        kolam,
        tipeKolam,
        komoditas,
        panjang,
        lebar,
        kedalaman,
        divais,
        listDivais
      ];
}

class KolamScreenUpdate extends KolamScreenState {
  const KolamScreenUpdate({
    super.tambak,
    super.listTambak,
    super.kolam,
    super.tipeKolam,
    super.komoditas,
    super.divais,
    super.listDivais,
    super.panjang,
    super.lebar,
    super.kedalaman,
  });
  @override
  KolamScreenState copyWith({
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
    return KolamScreenUpdate(
        tambak: tambak ?? this.tambak,
        listTambak: listTambak ?? this.listTambak,
        kolam: kolam ?? this.kolam,
        tipeKolam: tipeKolam ?? this.tipeKolam,
        panjang: panjang ?? this.panjang,
        lebar: lebar ?? this.lebar,
        kedalaman: kedalaman ?? this.kedalaman,
        komoditas: komoditas ?? this.komoditas,
        divais: divais ?? this.divais,
        listDivais: listDivais ?? this.listDivais);
  }
}

class KolamScreenLoading extends KolamScreenUpdate {
  KolamScreenLoading({required KolamScreenUpdate current})
      : super(
          tambak: current.tambak,
          listTambak: current.listTambak,
          kolam: current.kolam,
          tipeKolam: current.tipeKolam,
          komoditas: current.komoditas,
          divais: current.divais,
          listDivais: current.listDivais,
          panjang: current.panjang,
          lebar: current.lebar,
          kedalaman: current.kedalaman,
        );

  @override
  List<Object?> get props => [...super.props];
}

class KolamScreenError extends KolamScreenUpdate {
  final String msg;
  KolamScreenError({required this.msg, required KolamScreenUpdate current})
      : super(
          tambak: current.tambak,
          listTambak: current.listTambak,
          kolam: current.kolam,
          tipeKolam: current.tipeKolam,
          komoditas: current.komoditas,
          divais: current.divais,
          listDivais: current.listDivais,
          panjang: current.panjang,
          lebar: current.lebar,
          kedalaman: current.kedalaman,
        );
  @override
  List<Object?> get props => [...super.props, msg];
}

class KolamScreenSuccess extends KolamScreenUpdate {
  KolamScreenSuccess({required KolamScreenUpdate current})
      : super(
          tambak: current.tambak,
          listTambak: current.listTambak,
          kolam: current.kolam,
          tipeKolam: current.tipeKolam,
          komoditas: current.komoditas,
          divais: current.divais,
          listDivais: current.listDivais,
          panjang: current.panjang,
          lebar: current.lebar,
          kedalaman: current.kedalaman,
        );

  @override
  List<Object?> get props => [...super.props];
}
