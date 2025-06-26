part of 'dashboard_screen_cubit.dart';

sealed class DashboardScreenState extends Equatable {
  const DashboardScreenState();

  @override
  List<Object> get props => [];
}

final class DashboardScreenInitial extends DashboardScreenState {}

final class DashboardScreenLoaded extends DashboardScreenState {
  final List<TambakResponseModel> tambakList;
  const DashboardScreenLoaded(this.tambakList);

  @override
  List<Object> get props => [tambakList];
}

final class DashboardScreenError extends DashboardScreenState {
  final String msg;
  const DashboardScreenError(this.msg);

  @override
  List<Object> get props => [msg];
}
