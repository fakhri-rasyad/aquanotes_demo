import 'package:aquanotes/core/styles/text_style.dart';
import 'package:aquanotes/core/utils/snackbar_message_handler.dart';
import 'package:aquanotes/features/dashboard/presentation/cubit/dashboard_screen_cubit.dart';
import 'package:aquanotes/features/dashboard/presentation/widget/articles.dart';
import 'package:aquanotes/features/dashboard/presentation/widget/faq.dart';
import 'package:aquanotes/features/dashboard/presentation/widget/menu.dart';
import 'package:aquanotes/features/dashboard/presentation/widget/service.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/banner.dart';
import '../widget/top_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocListener<DashboardScreenCubit, DashboardScreenState>(
            listener: (context, state) {
              if (state is DashboardScreenError) {
                showSnackBarHander(context, state.msg);
              }
            },
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBar(),
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 8.0),
                          child: Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              text: "Optimalkan Manajemen Budidaya Dengan ",
                              style: ThemeTextStyle.labelStyle,
                              children: [
                                TextSpan(
                                    text: "aeraseaku",
                                    style: TextStyle(
                                        color: AppColors.gradientStart,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                              ],
                            ),
                          )),
                      Menu(),
                      PremiumBanner(),
                      ServiceWidget(),
                      ArticlesWidget(),
                      FrequentAskedQuestion()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
