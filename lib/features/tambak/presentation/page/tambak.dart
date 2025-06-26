import 'package:aquanotes/core/const/strings.dart';
import 'package:aquanotes/core/utils/validators.dart';
import 'package:aquanotes/features/dashboard/presentation/cubit/dashboard_screen_cubit.dart';
import 'package:aquanotes/features/tambak/presentation/cubit/tambak_sreen_cubit.dart';
import 'package:aquanotes/features/divais/presentation/page/divais.dart';
import 'package:aquanotes/shared/presentation/pages/popup_screen.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_appbar.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_dropdown.dart';
import 'package:aquanotes/shared/presentation/widgets/label_form_field.dart';
import 'package:aquanotes/shared/presentation/widgets/main_button.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TambakScreen extends StatefulWidget {
  const TambakScreen({super.key});

  static const routeName = "/tambak";

  @override
  State<TambakScreen> createState() => _TambakScreenState();
}

class _TambakScreenState extends State<TambakScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TambakSreenCubit>();
    cubit.populateData();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: CustomAppBar(
          titleText: "Daftar Tambak",
          onBackButton: () {
            Navigator.of(context).pop();
            cubit.resetInput();
          },
        ),
        body: BlocConsumer<TambakSreenCubit, TambakScreenState>(
          listener: (context, state) {
            if (state is TambakScreenSubmissionSuccess) {
              context.read<DashboardScreenCubit>().getTambakData();
              Navigator.pushReplacementNamed(
                context,
                PopupScreen.routeName,
                arguments: ScreenArgument(
                  buttonConfig: [
                    const ButtonConfig(
                        text: "Instalasi Aquanotes",
                        route: DivaisScreen.routeName,
                        isMain: true)
                  ],
                  title: "Selamat! Tambak Anda Berhasil Didaftarkan",
                  subtitle:
                      "Sekarang anda sudah dapat melakukan monitoring kolam menggunakan perangkat aquanotes",
                  asset: "assets/images/home/menu/tambak/Like.png",
                ),
              );
            } else if (state is TambakScreenSubmissionFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TambakScreenView(
                                state: state,
                                cubit: cubit,
                              ),
                              MainButton(
                                  buttonText: "Simpan",
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      cubit.postTambak();
                                      // Navigator.pushNamed(
                                      //   context,
                                      //   PopupScreen.routeName,
                                      //   arguments: ScreenArgument(
                                      //     child: MainButton(
                                      //       buttonText: "Instalasi Aquanotes",
                                      //       onPressed: () {
                                      //         Navigator.pushReplacementNamed(
                                      //             context,
                                      //             DivaisScreen.routeName);
                                      //       },
                                      //     ),
                                      //     title:
                                      //         "Selamat! Tambak Anda Berhasil Didaftarkan",
                                      //     subtitle:
                                      //         "Sekarang anda sudah dapat melakukan monitoring kolam menggunakan perangkat aquanotes",
                                      //     asset:
                                      //         "assets/images/home/menu/tambak/Like.png",
                                      //   ),
                                      // );
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Loading overlay
                if (state.isLoading == true)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withAlpha(127),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TambakScreenView extends StatelessWidget {
  const TambakScreenView({super.key, required this.state, required this.cubit});
  final TambakScreenState state;
  final TambakSreenCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelFormField(
            label: "Nama Tambak",
            hint: "Masukkan Nama Tambak",
            initialValue:
                state.name?.trim().isNotEmpty == true ? state.name : null,
            onChanged: (value) => cubit.updateTambakFields(name: value),
            validator: (value) =>
                Validators.requiredField(value, "Nama Tambak")),
        // CustomDropdown(
        //     label: "Negara",
        //     currentValue:
        //         state.negara?.trim().isNotEmpty == true ? state.negara : null,
        //     items: List.generate(7, (index) => "Negara $index"),
        //     onChanged: (value) => cubit.updateTambakFields(negara: value),
        //     validator: (value) => Validators.requiredField(value, "Negara")),
        LabelFormField(
            isEnabled: false,
            hint: "Negara",
            initialValue: state.negara,
            onChanged: (value) {
              null;
            },
            validator: (value) => Validators.requiredField(value, "Negara"),
            label: "Negara"),
        CustomDropdown(
          label: "Provinsi",
          currentValue: state.provinsi,
          items: state.listProvinsi.map((e) => e.name).toList(),
          onChanged: (value) => cubit.onProvinceSelected(value!),
          validator: (value) => Validators.requiredField(value, "Provinsi"),
        ),
        CustomDropdown(
          label: "Kota/Kabupaten",
          currentValue: state.kota != null &&
                  state.listKota.any((r) => r.name == state.kota)
              ? state.kota
              : null,
          items: state.listKota.map((e) => e.name).toList(),
          onChanged: (value) {
            if (state.provinsi != null || value != null) {
              cubit.onKotaSelected(value!);
            }
          },
          validator: (value) =>
              Validators.requiredField(value, "Kota/Kabupaten"),
        ),
        CustomDropdown(
          label: "Kecamatan",
          currentValue: state.kecamatan != null &&
                  state.listKecamatan.any((r) => r.name == state.kecamatan)
              ? state.kecamatan
              : null,
          items: state.listKecamatan.map((e) => e.name).toList(),
          onChanged: (value) {
            if (state.kota != null || value != null) {
              cubit.onKecamatanSelected(value!);
            }
          },
          validator: (value) => Validators.requiredField(value, "Kecamatan"),
        ),
        CustomDropdown(
          label: "Desa",
          currentValue: state.desa != null &&
                  state.listDesa.any((r) => r.name == state.desa)
              ? state.desa
              : null,
          items: state.listDesa.map((e) => e.name).toList(),
          onChanged: (value) {
            if (state.kecamatan != null || value != null) {
              cubit.onDesaSelected(value!);
            }
          },
          validator: (value) => Validators.requiredField(value, "Desa"),
        ),

        LabelFormField(
          label: "Alamat",
          hint: "Nama Jalan, Dusun, dan keterangan lainnya",
          initialValue:
              state.alamat?.trim().isNotEmpty == true ? state.alamat : null,
          maxLines: 3,
          onChanged: (value) => cubit.updateTambakFields(alamat: value),
          validator: (value) => Validators.requiredField(value, "Alamat"),
        ),
        CustomDropdown(
            label: "Jenis Budidaya",
            currentValue: state.jenisBudidaya?.trim().isNotEmpty == true
                ? state.jenisBudidaya
                : null,
            items: StringsConst.jenisBudidaya,
            onChanged: (value) =>
                cubit.updateTambakFields(jenisBudidaya: value),
            validator: (value) =>
                Validators.requiredField(value, "Jenis Budidaya")),
      ],
    );
  }
}
