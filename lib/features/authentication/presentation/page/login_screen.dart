import 'package:aquanotes/core/utils/snackbar_message_handler.dart';
import 'package:aquanotes/core/utils/validators.dart';
import 'package:aquanotes/features/home/presentation/page/home_screen.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_appbar.dart';
import 'package:aquanotes/shared/presentation/widgets/label_form_field.dart';
import 'package:aquanotes/shared/presentation/widgets/loading_overlay.dart';
import 'package:aquanotes/shared/presentation/widgets/main_button.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login/login_screen_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const routeName = "/login";
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginScreenCubit>();

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: CustomAppBar(
        titleText: "Login",
        onBackButton: () => {cubit.resetInput(), Navigator.of(context).pop()},
      ),
      body: BlocConsumer<LoginScreenCubit, LoginScreenState>(
        listener: (context, state) => {
          if (state is LoginScreenError)
            {showSnackBarHander(context, state.message)}
          else if (state is LoginScreenSuccess)
            {
              cubit.resetInput(),
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName)
            }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildWelcomeText(),
                              LabelFormField(
                                  hint: "Alamat Email",
                                  initialValue: state.email,
                                  onChanged: cubit.updateEmail,
                                  validator: (val) =>
                                      Validators.requiredEmail(val, "Email"),
                                  label: "Email"),

                              LabelFormField(
                                  hint: "Password",
                                  label: "Password",
                                  initialValue: state.password,
                                  isVisible: state.showPassword,
                                  isPassword: true,
                                  onChanged: cubit.updatePassword,
                                  iconAction: cubit.updateShowPassword,
                                  validator: (value) =>
                                      Validators.requiredPassword(
                                          value, "Password")),
                              const SizedBox(height: 8.0),
                              const Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Lupa Sandi?",
                                  style: TextStyle(
                                    color: AppColors.mediumGray,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              MainButton(
                                  buttonText: "Masuk",
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.sendData();
                                    }
                                  }),
                              // const SizedBox(height: 24.0),
                              // _buildDividerWithText(),
                              // const SizedBox(height: 24.0),
                              // _buildSocialMediaButtons(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: RichText(
                        text: TextSpan(
                          text: "Belum Memiliki Akun? ",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: "Daftar di sini",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.gradientStart,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, "/registration");
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (state is LoginScreenLoading) const LoadingOverlay(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWelcomeText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Selamat Datang!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: AppColors.gradientStart,
          ),
        ),
        Text(
          "Optimalkan Budidaya Dengan Aquanotes",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
