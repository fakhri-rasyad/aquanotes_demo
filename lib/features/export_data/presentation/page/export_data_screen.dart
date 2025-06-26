import 'package:aquanotes/core/utils/snackbar_message_handler.dart';
import 'package:aquanotes/core/utils/validators.dart';
import 'package:aquanotes/features/export_data/presentation/cubit/export_data_screen_cubit.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_appbar.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_dropdown.dart';
import 'package:aquanotes/shared/presentation/widgets/date_range_picker.dart';
import 'package:aquanotes/shared/presentation/widgets/loading_overlay.dart';
import 'package:aquanotes/shared/presentation/widgets/main_button.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExportDataScreen extends StatefulWidget {
  const ExportDataScreen({super.key});
  static const routeName = "/export_data";

  @override
  State<ExportDataScreen> createState() => _ExportDataScreenState();
}

class _ExportDataScreenState extends State<ExportDataScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExportDataScreenCubit>().getData();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExportDataScreenCubit>();

    return BlocConsumer<ExportDataScreenCubit, ExportDataScreenState>(
      listener: (context, state) {
        if (state is ExportDataError) {
          showSnackBarHander(context, state.message);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.secondary,
                appBar: CustomAppBar(
                  titleText: "Eksport Data",
                  onBackButton: () {
                    context.read<ExportDataScreenCubit>().resetInput();
                    Navigator.of(context).pop();
                  },
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (state.tambakList != null ||
                                  state.tambakList!.isEmpty) {
                                showSnackBarHander(
                                    context, "Anda belum menambahkan tambak");
                              }
                            },
                            child: CustomDropdown(
                                label: "Pilih Tambak",
                                currentValue: state.tambak?.isNotEmpty == true
                                    ? state.tambak
                                    : null,
                                items: state.tambakList != null
                                    ? List.generate(
                                        state.tambakList!.length,
                                        (index) =>
                                            state.tambakList![index].name)
                                    : [],
                                onChanged: (value) =>
                                    cubit.updateData(tambak: value),
                                validator: (value) =>
                                    Validators.requiredField(value, "Tambak")),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (state.kolamList != null ||
                                  state.kolamList!.isEmpty) {
                                showSnackBarHander(
                                    context, "Anda belum menambahkan kolam");
                              }
                            },
                            child: CustomDropdown(
                                label: "Pilih Kolam",
                                currentValue: state.kolam?.isNotEmpty == true
                                    ? state.kolam
                                    : null,
                                items: state.kolamList != null
                                    ? List.generate(state.kolamList!.length,
                                        (index) => state.kolamList![index].nama)
                                    : [],
                                onChanged: (value) =>
                                    cubit.updateData(kolam: value),
                                validator: (value) =>
                                    Validators.requiredField(value, "Kolam")),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (state.divaisList != null ||
                                  state.divaisList!.isEmpty) {
                                showSnackBarHander(
                                    context, "Anda belum menambahkan divais");
                              }
                            },
                            child: CustomDropdown(
                                label: "Pilih Divais",
                                currentValue: state.divais?.isNotEmpty == true
                                    ? state.divais
                                    : null,
                                items: state.divaisList != null
                                    ? List.generate(
                                        state.divaisList!.length,
                                        (index) =>
                                            state.divaisList![index].name)
                                    : [],
                                onChanged: (value) =>
                                    cubit.updateData(divais: value),
                                validator: (value) =>
                                    Validators.requiredField(value, "Divais")),
                          ),
                          DateRangeSelector(
                            startDate: state.startTime,
                            endDate: state.endTime,
                            label: "Pilih Tanggal",
                            hint: "xx xx xxxx - xx xx xxxx",
                            onDateRangePicked: (DateTimeRange<DateTime> date) {
                              final format = DateFormat('dd MMM yyyy');
                              final start = format.format(date.start);
                              final end = format.format(date.end);
                              cubit.updateData(startTime: start, endTime: end);
                            },
                            validator: (value1, value2) {
                              final error1 = Validators.requiredField(
                                  value1, "Tanggal awal");
                              if (error1 != null) return error1;
                              final error2 = Validators.requiredField(
                                  value2, "Tanggal akhir");
                              if (error2 != null) return error2;
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          MainButton(
                              buttonText: "Unduh",
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  cubit.processData();
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (state is ExportDataLoading) const LoadingOverlay(),
          ],
        );
      },
    );
  }
}
