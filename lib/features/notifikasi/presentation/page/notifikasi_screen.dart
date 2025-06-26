import 'package:aquanotes/features/notifikasi/presentation/widget/appbar_actions.dart';
import 'package:aquanotes/features/notifikasi/presentation/widget/empty_notification.dart';
import 'package:aquanotes/features/notifikasi/presentation/widget/notification_list.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aquanotes/features/notifikasi/presentation/cubit/notifikasi_screen_cubit.dart';
import 'package:aquanotes/theme/colors.dart';

class NotifikasiScreen extends StatelessWidget {
  static const routeName = "/notifikasi";
  const NotifikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: false,
        titleText: "Notifikasi",
        actions: [AppbarActions()],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<NotifikasiScreenCubit, NotifikasiScreenState>(
                builder: (context, state) {
                  if (state is NotifikasiScreenLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.blueAccent,
                      ),
                    );
                  } else if (state is NotifikasiScreenLoaded) {
                    return state.notifications.isNotEmpty
                        ? NotificationList(
                            notifications: state.notifications,
                          )
                        : const EmptyNotification();
                  } else if (state is NotifikasiScreenError) {
                    return Center(
                      child: Text(state.message,
                          style: const TextStyle(color: Colors.red)),
                    );
                  }
                  return const EmptyNotification();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
