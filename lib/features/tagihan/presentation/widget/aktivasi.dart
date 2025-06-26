import 'package:aquanotes/core/utils/validators.dart';
import 'package:aquanotes/features/tagihan/presentation/cubit/tagihan_screen_cubit.dart';
import 'package:aquanotes/shared/presentation/widgets/date_range_picker.dart';
import 'package:aquanotes/shared/presentation/widgets/label_form_field.dart';
import 'package:aquanotes/shared/presentation/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AktivasiWidget extends StatefulWidget {
  const AktivasiWidget({super.key});

  @override
  State<AktivasiWidget> createState() => _AktivasiWidgetState();
}

class _AktivasiWidgetState extends State<AktivasiWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TagihanScreenCubit>();
    return Form(
      key: _formKey,
      child: BlocBuilder<TagihanScreenCubit, TagihanScreenState>(
        builder: (context, state) {
          return Column(
            children: [
              DateRangeSelector(
                label: "Atur Waktu Berlaku",
                hint: "Pilih tanggal mulai dan akhir",
                startDate: state.dateStartTime,
                endDate: state.dateEndTime,
                validator: (value1, value2) {
                  final error1 =
                      Validators.requiredField(value1, "Tanggal awal");
                  if (error1 != null) return error1;
                  final error2 =
                      Validators.requiredField(value2, "Tanggal akhir");
                  if (error2 != null) return error2;
                  return null;
                },
                onDateRangePicked: (picked) {
                  final format = DateFormat("dd MMM yyyy");
                  final start = format.format(picked.start);
                  final end = format.format(picked.end);
                  cubit.updateState(dateStartTime: start, dateEndTime: end);
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              LabelFormField(
                  hint: "Masukkan Kode",
                  initialValue: state.reffCode,
                  onChanged: (value) => cubit.updateState(reffCode: value),
                  validator: (value) => Validators.requiredField(value, "Kode"),
                  label: "Kode Referral"),
              const SizedBox(
                height: 8.0,
              ),
              MainButton(
                  buttonText: "Aktivasi",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Aktivasi")));
                    }
                  }),
            ],
          );
        },
      ),
    );
  }
}
