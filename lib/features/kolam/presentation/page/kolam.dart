import 'package:aquanotes/core/const/strings.dart';
import 'package:aquanotes/core/utils/snackbar_message_handler.dart';
import 'package:aquanotes/core/utils/validators.dart';
import 'package:aquanotes/features/kolam/presentation/cubit/kolam_screen_cubit.dart';
import 'package:aquanotes/features/status/presentation/page/status_screen.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_appbar.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_dropdown.dart';
import 'package:aquanotes/shared/presentation/widgets/label_form_field.dart';
import 'package:aquanotes/shared/presentation/widgets/loading_overlay.dart';
import 'package:aquanotes/shared/presentation/widgets/main_button.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/presentation/pages/popup_screen.dart';

class KolamScreen extends StatefulWidget {
  const KolamScreen({super.key});

  static const routeName = "/kolam";

  @override
  State<KolamScreen> createState() => _KolamScreenState();
}

class _KolamScreenState extends State<KolamScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<KolamScreenCubit>().getData();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<KolamScreenCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: CustomAppBar(
          titleText: "Tambah Kolam",
          onBackButton: () {
            Navigator.of(context).pop();
            cubit.resetInput();
          },
        ),
        body: BlocConsumer<KolamScreenCubit, KolamScreenState>(
          listener: (context, state) {
            if (state is KolamScreenSuccess) {
              Navigator.pushReplacementNamed(
                context,
                PopupScreen.routeName,
                arguments: ScreenArgument(
                  buttonConfig: [
                    const ButtonConfig(
                        text: "Cek Status",
                        route: StatusScreen.routeName,
                        isMain: true)
                  ],
                  title: "Kolam Berhasil Dikonfigurasi Aquanotes",
                  subtitle:
                      "Sekarang anda sudah dapat melakukan monitoring kolam menggunakan perangkat Aquanotes.",
                  asset: "assets/images/home/menu/divais/Shield.png",
                ),
              );
            } else if (state is KolamScreenError) {
              showSnackBarHander(context, state.msg);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header

                            GestureDetector(
                              onTap: () {
                                if (state.listTambak != null ||
                                    state.listTambak!.isEmpty) {
                                  showSnackBarHander(
                                      context, "Anda belum menambahkan tambak");
                                }
                              },
                              child: CustomDropdown(
                                  label: "Pilih Tambak",
                                  currentValue: state.tambak?.isNotEmpty == true
                                      ? state.tambak
                                      : null,
                                  items: state.listTambak != null
                                      ? state.listTambak!
                                          .map((e) => e.name)
                                          .toList()
                                      : [],
                                  onChanged: (value) =>
                                      cubit.updateKolam(tambak: value),
                                  validator: (value) =>
                                      Validators.requiredField(
                                          value, "Divais")),
                            ),

                            LabelFormField(
                                hint: "Masukkan Nama Kolam",
                                initialValue: state.kolam,
                                onChanged: (value) =>
                                    cubit.updateKolam(kolam: value),
                                validator: (value) =>
                                    Validators.requiredField(value, "Kolam"),
                                label: "Nama Kolam"),

                            CustomDropdown(
                                label: "Tipe Kolam",
                                currentValue:
                                    state.tipeKolam?.isNotEmpty == true
                                        ? state.tipeKolam
                                        : null,
                                items: StringsConst.tipeKolam,
                                onChanged: (value) =>
                                    cubit.updateKolam(tipeKolam: value),
                                validator: (value) => Validators.requiredField(
                                    value, "Tipe Kolam")),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: LabelFormField(
                                      isNumber: true,
                                      hint: "Panjang (m)",
                                      initialValue: state.panjang,
                                      onChanged: (value) =>
                                          cubit.updateKolam(panjang: value),
                                      validator: (value) =>
                                          Validators.requiredField(
                                              value, "Panjang"),
                                      label: "Panjang"),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: LabelFormField(
                                      isNumber: true,
                                      hint: "Lebar (m)",
                                      initialValue: state.lebar,
                                      onChanged: (value) =>
                                          cubit.updateKolam(lebar: value),
                                      validator: (value) =>
                                          Validators.requiredField(
                                              value, "Lebar"),
                                      label: "Lebar"),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: LabelFormField(
                                      isNumber: true,
                                      hint: "Kedalaman (m)",
                                      initialValue: state.kedalaman,
                                      onChanged: (value) =>
                                          cubit.updateKolam(kedalaman: value),
                                      validator: (value) =>
                                          Validators.requiredField(
                                              value, "Kedalaman"),
                                      label: "Kedalaman"),
                                ),
                              ],
                            ),

                            CustomDropdown(
                                label: "Pilih Komoditas",
                                currentValue:
                                    state.komoditas?.isNotEmpty == true
                                        ? state.komoditas
                                        : null,
                                items: StringsConst.komoditas,
                                onChanged: (value) =>
                                    cubit.updateKolam(komoditas: value),
                                validator: (value) => Validators.requiredField(
                                    value, "Komoditas")),

                            GestureDetector(
                              onTap: () => {
                                if (state.listDivais == null ||
                                    state.listDivais!.isEmpty)
                                  {
                                    showSnackBarHander(
                                        context, "Anda belum memiliki divais")
                                  }
                              },
                              child: CustomDropdown(
                                  label: "Pilih Divais",
                                  currentValue: state.divais?.isNotEmpty == true
                                      ? state.divais
                                      : null,
                                  items: state.listDivais != null
                                      ? state.listDivais!
                                          .map((e) => e.name)
                                          .toList()
                                      : [],
                                  onChanged: (value) =>
                                      cubit.updateKolam(divais: value),
                                  validator: (value) =>
                                      Validators.requiredField(
                                          value, "Divais")),
                            ),
                            MainButton(
                              buttonText: "Konfigurasi",
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  cubit.processData();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (state is KolamScreenLoading) const LoadingOverlay()
              ],
            );
          },
        ),
      ),
    );
  }
}
