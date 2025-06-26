import 'dart:async';

import 'package:aquanotes/features/notifikasi/domain/entities/notification_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifikasi_screen_state.dart';

class NotifikasiScreenCubit extends Cubit<NotifikasiScreenState> {
  NotifikasiScreenCubit() : super(NotifikasiScreenInitial());

  Future<void> fetchNotifications() async {
    try {
      emit(NotifikasiScreenLoading());

      // Simulate API fetching delay
      await Future.delayed(const Duration(seconds: 2));

      final List<NotificationModel> notifications = [
        NotificationModel(
          title: "Perubahan Suhu",
          subtitle: "Suhu air meningkat 2°C",
          date: "2025-02-11 08:30",
          category: "Warning",
        ),
        NotificationModel(
          title: "pH Tidak Stabil",
          subtitle: "pH air turun menjadi 6.5",
          date: "2025-02-10 14:15",
          category: "Alert",
        ),
      ];

      emit(NotifikasiScreenLoaded(notifications));
    } catch (e) {
      emit(NotifikasiScreenError("Gagal memuat notifikasi."));
    }
  }
}
