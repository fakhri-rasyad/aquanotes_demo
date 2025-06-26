import 'package:aquanotes/core/const/strings.dart';
import 'package:aquanotes/features/dashboard/presentation/cubit/dashboard_screen_cubit.dart';
import 'package:aquanotes/features/welcome/presentation/page/welcome_screen.dart';
import 'package:aquanotes/features/profile/presentation/cubit/profile_screen_cubit.dart';
import 'package:aquanotes/features/profile/presentation/widget/profile_actions.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_appbar.dart';
import 'package:aquanotes/shared/presentation/widgets/main_button.dart';
import 'package:aquanotes/shared/presentation/widgets/secondary_button.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileScreenCubit>();
    cubit.setUserCred();
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: "Profile",
        showBackButton: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, bottom: 80, top: 32),
          child: BlocBuilder<ProfileScreenCubit, ProfileScreenState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.fadeLightBlue,
                      child: Icon(Icons.person,
                          size: 48, color: AppColors.blueAccent),
                    ),
                    Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.gradientEnd),
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.white,
                            )))
                  ]),
                  const SizedBox(height: 16),
                  Text(state.email ?? ""),
                  const Text("Barru, Sulawesi Selatan, Indonesia"),
                  const SizedBox(
                    height: 16,
                  ),
                  ...List.generate(
                      StringsConst.options.length,
                      (index) => ProfileActions(
                          optionName: StringsConst.options[index],
                          onTap: () {})),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12.0)), // Rounded corners
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize
                                      .min, // Prevent unnecessary stretching
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      'Keluar',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Anda yakin ingin keluar?',
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: SecondaryButton(
                                          buttonText: "Tidak",
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )),
                                        const SizedBox(width: 12),
                                        Expanded(
                                            child: MainButton(
                                          buttonText: "Keluar",
                                          onPressed: () {
                                            context
                                                .read<DashboardScreenCubit>()
                                                .resetInput();
                                            cubit.logOut();
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute<void>(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const WelcomeScreen()),
                                                (Route<dynamic> route) =>
                                                    false);
                                          },
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Keluar",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
