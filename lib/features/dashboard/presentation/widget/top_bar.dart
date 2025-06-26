import 'package:aquanotes/features/dashboard/presentation/cubit/dashboard_screen_cubit.dart';
import 'package:aquanotes/features/dashboard/presentation/widget/rectangular_avatar.dart';
import 'package:aquanotes/features/tambak/presentation/page/tambak.dart';
import 'package:aquanotes/shared/presentation/widgets/loading_overlay.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardScreenCubit>().checkData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardScreenCubit, DashboardScreenState>(
      builder: (context, state) {
        Widget content;

        if (state is DashboardScreenInitial) {
          content = const LoadingOverlay();
        } else if (state is DashboardScreenLoaded) {
          final isEmpty = state.tambakList.isEmpty;
          final tambakName = isEmpty ? null : state.tambakList.first.name;
          final cultivationType =
              isEmpty ? null : state.tambakList.first.cultivationType;

          content = Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RectangularAvatar(
                imageLink: 'assets/images/home/dashboard/topbar/profile.png',
                isEmpty: isEmpty,
                onPressed: () {
                  isEmpty
                      ? Navigator.of(context).pushNamed(TambakScreen.routeName)
                      : null;
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tambakName ?? "Registrasi Tambak",
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        cultivationType ?? "Klik + dan lengkapi informasi",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
              Image.asset(
                'assets/images/home/dashboard/topbar/aeraseaku_logo.png',
                width: 76,
              ),
            ],
          );
        } else if (state is DashboardScreenError) {
          content = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  state.msg,
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: () {
                  context.read<DashboardScreenCubit>().getTambakData();
                },
              )
            ],
          );
        } else {
          // Just in case an unexpected state is encountered
          content = const Center(child: CircularProgressIndicator());
        }

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              colors: [
                AppColors.gradientStart,
                AppColors.skyBlue,
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32.0),
              bottomRight: Radius.circular(32.0),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: content,
          ),
        );
      },
    );
  }
}
