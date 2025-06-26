import 'package:aquanotes/features/authentication/presentation/widget/name_email_password_ui.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_appbar.dart';
import 'package:aquanotes/shared/presentation/widgets/loading_overlay.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/registration/registration_screen_cubit.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  static const routeName = "/registration";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationScreenCubit, RegistrationScreenState>(
      builder: (context, state) {
        final cubit = context.read<RegistrationScreenCubit>();
        return Scaffold(
          backgroundColor: AppColors.secondary,
          appBar: CustomAppBar(
              titleText: "Registration",
              onBackButton: () => state is! RegistrationScreenLoading
                  ? {Navigator.of(context).pop(), cubit.resetInput()}
                  : null),
          body: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: RegisrationScreenView(),
              ),
              if (state is RegistrationScreenLoading) const LoadingOverlay()
            ],
          ),
        );
      },
    );
  }
}
