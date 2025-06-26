part of 'notifikasi_screen_cubit.dart';

@immutable
sealed class NotifikasiScreenState {}

final class NotifikasiScreenInitial extends NotifikasiScreenState {}

final class NotifikasiScreenLoading extends NotifikasiScreenState {}

final class NotifikasiScreenLoaded extends NotifikasiScreenState {
  final List<NotificationModel> notifications;

  NotifikasiScreenLoaded(this.notifications);
}

final class NotifikasiScreenError extends NotifikasiScreenState {
  final String message;

  NotifikasiScreenError(this.message);
}
