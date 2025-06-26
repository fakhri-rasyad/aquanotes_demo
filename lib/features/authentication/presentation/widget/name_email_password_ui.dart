import 'package:aquanotes/core/const/strings.dart';
import 'package:aquanotes/core/utils/snackbar_message_handler.dart';
import 'package:aquanotes/core/utils/validators.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_dropdown.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_text_form_field.dart';
import 'package:aquanotes/shared/presentation/widgets/label_form_field.dart';
import 'package:aquanotes/shared/presentation/widgets/main_button.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/registration/registration_screen_cubit.dart';

class RegisrationScreenView extends StatefulWidget {
  const RegisrationScreenView({super.key});

  @override
  State<RegisrationScreenView> createState() => _RegisrationScreenViewState();
}

class _RegisrationScreenViewState extends State<RegisrationScreenView> {
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegistrationScreenCubit>();

    return BlocConsumer<RegistrationScreenCubit, RegistrationScreenState>(
      listener: (context, state) {
        if (state is RegistrationScreenSuccess) {
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  contentPadding: const EdgeInsetsGeometry.all(16.0),
                  title: const Text("Registrasi Sukses"),
                  children: [
                    const Icon(
                      size: 64.0,
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    MainButton(
                        buttonText: "Ok",
                        onPressed: () => {
                              cubit.resetInput(),
                              Navigator.pop(context),
                              Navigator.pop(context),
                            })
                  ],
                );
              });
        }
        if (state is RegistrationScreenError) {
          showSnackBarHander(context, state.message);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelFormField(
                  hint: "Name",
                  initialValue: state.name,
                  onChanged: cubit.updateName,
                  validator: (val) => Validators.requiredField(val, "Nama"),
                  label: "Name",
                ),
                LabelFormField(
                  hint: "name@email.com",
                  initialValue: state.email,
                  onChanged: cubit.updateEmail,
                  validator: (val) =>
                      Validators.requiredEmail(val, "Email Address"),
                  label: "Email Address",
                ),
                _buildPasswordFields(
                  state.password,
                  state.confirmPassword,
                  cubit.updatePassword,
                  cubit.updateConfirmPassword,
                ),
                const SizedBox(height: 12.0),
                CustomDropdown(
                  label: "Pilih peran anda",
                  currentValue: state.role.isNotEmpty ? state.role : null,
                  items: StringsConst.roles,
                  onChanged: (value) => cubit.updateRole(value),
                  validator: (value) =>
                      Validators.requiredField(value, "Peran"),
                ),
                _buildCheckbox(),
                const SizedBox(height: 12.0),
                SizedBox(
                  width: double.infinity,
                  child: MainButton(
                    buttonText: state is RegistrationScreenLoading
                        ? "Loading..."
                        : "Submit",
                    onPressed: isChecked && state is! RegistrationScreenLoading
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              cubit.sendData();
                            }
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPasswordFields(
    String password,
    String passwordConfirm,
    Function(String) onPasswordChanged,
    Function(String) onPasswordConfirmChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        PasswordField(
          password: password,
          confirmPassword: passwordConfirm,
          passwordOnChanged: onPasswordChanged,
          confirmPasswordChange: onPasswordConfirmChanged,
        )
      ],
    );
  }

  Widget _buildCheckbox() {
    return Row(
      children: [
        Checkbox(
          fillColor: WidgetStateProperty.resolveWith<Color?>(
            (states) => states.contains(WidgetState.selected)
                ? AppColors.gradientStart
                : null,
          ),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: "I've read and agree with the ",
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: "Terms and Conditions",
                  style: const TextStyle(
                    color: AppColors.gradientStart,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => debugPrint("Terms and Conditions clicked"),
                ),
                const TextSpan(text: " and the "),
                TextSpan(
                  text: "Privacy Policy",
                  style: const TextStyle(
                    color: AppColors.gradientStart,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => debugPrint("Privacy Policy clicked"),
                ),
                const TextSpan(text: "."),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField(
      {super.key,
      required this.password,
      required this.confirmPassword,
      required this.passwordOnChanged,
      required this.confirmPasswordChange});
  final String password;
  final String confirmPassword;
  final Function(String) passwordOnChanged;
  final Function(String) confirmPasswordChange;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          hint: "Masukkan kata sandi",
          initialValue: widget.password,
          onChanged: widget.passwordOnChanged,
          isPassword: true,
          validator: (val) => Validators.requiredPassword(val, "Password"),
          isVisible: _isPasswordVisible,
          iconAction: () => setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          }),
        ),
        const SizedBox(
          height: 8,
        ),
        CustomTextFormField(
          hint: "Konfirmasi kata sandi",
          initialValue: widget.confirmPassword,
          onChanged: widget.confirmPasswordChange,
          validator: (val) => Validators.confirmPassword(
              val, widget.password, "Konfirmasi Password"),
          isVisible: _isConfirmPasswordVisible,
          isPassword: true,
          iconAction: () => setState(() {
            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
          }),
        ),
      ],
    );
  }
}
