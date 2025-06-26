import 'package:aquanotes/core/utils/snackbar_message_handler.dart';
import 'package:aquanotes/core/utils/validators.dart';
import 'package:aquanotes/features/divais/presentation/cubit/divais_screen_cubit.dart';
import 'package:aquanotes/features/kolam/presentation/page/kolam.dart';
import 'package:aquanotes/features/divais/presentation/widget/qr_scanner.dart';
import 'package:aquanotes/shared/presentation/pages/popup_screen.dart';
import 'package:aquanotes/features/status/presentation/page/status_screen.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_appbar.dart';
import 'package:aquanotes/shared/presentation/widgets/label_form_field.dart';
import 'package:aquanotes/shared/presentation/widgets/loading_overlay.dart';
import 'package:aquanotes/shared/presentation/widgets/main_button.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DivaisScreen extends StatefulWidget {
  const DivaisScreen({super.key});

  static const routeName = "/divais";

  @override
  State<DivaisScreen> createState() => _DivaisScreenState();
}

class _DivaisScreenState extends State<DivaisScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController idController;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
  }

  @override
  void dispose() {
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: CustomAppBar(
          titleText: "Daftar Divais",
          onBackButton: () {
            context.read<DivaisScreenCubit>().resetInput();
            Navigator.of(context).pop();
          },
        ),
        body: BlocConsumer<DivaisScreenCubit, DivaisScreenState>(
          listener: (context, state) {
            if (state is DivaisScreenSucceess) {
              Navigator.pushReplacementNamed(
                context,
                PopupScreen.routeName,
                arguments: ScreenArgument(
                    buttonConfig: [
                      const ButtonConfig(
                          text: "Hubungkan",
                          route: KolamScreen.routeName,
                          isMain: false),
                      const ButtonConfig(
                          text: "Cek Status",
                          route: StatusScreen.routeName,
                          isMain: true)
                    ],
                    title:
                        "Selamat! Tambak Anda Berhasil Terintegrasi Aquanotes",
                    subtitle:
                        "Sekarang anda sudah dapat menambahkan kolam menggunakan perangkat aquanotes secara real-time",
                    // icon: Icons.thumb_up_alt_outlined,
                    asset: "assets/images/home/menu/divais/Shield.png"),
              );
            } else if (state is DivaisScreenError) {
              showSnackBarHander(context, state.message);
            }
          },
          builder: (context, state) {
            if (state.id != null && idController.text != state.id) {
              idController.text = state.id!;
            }
            final cubit = context.read<DivaisScreenCubit>();
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
                            content(state, cubit, idController),
                            const SizedBox(
                              height: 8,
                            ),
                            MainButton(
                              buttonText: "Simpan",
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
                if (state is DivaisScreenLoading) const LoadingOverlay()
              ],
            );
          },
        ),
      ),
    );
  }

  Widget content(DivaisScreenState state, DivaisScreenCubit cubit,
      TextEditingController idController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelFormField(
          hint: "Masukkan Nama Divais",
          initialValue: state.name?.trim().isNotEmpty == true ? state.name : "",
          onChanged: (value) => cubit.updateDivais(name: value),
          validator: (value) => Validators.requiredField(value, "Nama Divais"),
          label: "Nama Divais",
        ),
        const SizedBox(height: 16),
        const Text("ID Perangkat",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: idController,
          onChanged: (value) => cubit.updateDivais(id: value),
          validator: (value) => Validators.requiredField(value, "ID"),
          decoration: InputDecoration(
            hintText: "ID pada alat",
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.gradientStart, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.gradientStart, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.gradientStart, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.camera_alt_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QrScanner(
                      onDetect: (String result) {
                        cubit.updateDivais(id: result);
                        Navigator.pop(context); // Close scanner
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
