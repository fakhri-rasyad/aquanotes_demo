import 'package:aquanotes/core/utils/snackbar_message_handler.dart';
import 'package:aquanotes/core/utils/validators.dart';
import 'package:aquanotes/features/add_alarm/presentation/cubit/alarm_setting_cubit.dart';
import 'package:aquanotes/features/add_alarm/presentation/cubit/alarm_setting_state.dart';
import 'package:aquanotes/features/add_alarm/presentation/widget/alarm_setting.dart';
import 'package:aquanotes/features/add_alarm/presentation/widget/divais_dropdown.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_appbar.dart';
import 'package:aquanotes/shared/presentation/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aquanotes/theme/colors.dart';

class AddAlarmScreen extends StatefulWidget {
  static const routeName = "addAlarm";
  const AddAlarmScreen({super.key});

  @override
  State<AddAlarmScreen> createState() => _AddAlarmScreenState();
}

class _AddAlarmScreenState extends State<AddAlarmScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AlarmSettingCubit>().populateDropdown();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: const CustomAppBar(titleText: "Atur Alarm"),
      body: BlocConsumer<AlarmSettingCubit, AlarmSettingState>(
        listener: (context, state) {
          if (state is AlarmSettingError) {
            showSnackBarHander(context, state.message);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Multiparameter Sensor",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  if (state.settings != null && state.settings!.isNotEmpty) ...{
                    ...state.settings!.map(
                      (setting) => AlarmSettingCard(setting: setting),
                    ),
                  },
                  const SizedBox(height: 16),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      if (state.divaisList != null ||
                          state.divaisList!.isEmpty) {
                        showSnackBarHander(
                            context, "Anda belum menambahkan divais");
                      }
                    },
                    child: DivaisDropdown<DivaisResponseModel>(
                        label: "Pilih Pasangan Divais",
                        currentValue: state.divais,
                        items:
                            state.divaisList != null ? state.divaisList! : [],
                        onChanged: (value) {
                          context.read<AlarmSettingCubit>().updateDivais(value);
                        },
                        valueMapper: (value) => value.name,
                        validator: (value) =>
                            Validators.requiredField(value?.name, "Divais")),
                  ),
                  const SizedBox(height: 16),
                  MainButton(
                      buttonText: "Simpan",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AlarmSettingCubit>().sendData();
                        }
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
