import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:aquanotes/features/dashboard/domain/usecases/dash_get_tambak_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_screen_state.dart';

class DashboardScreenCubit extends Cubit<DashboardScreenState> {
  DashboardScreenCubit(this.dashGetTambakData)
      : super(DashboardScreenInitial());

  final DashGetTambakData dashGetTambakData;

  Future<void> checkData() async {
    if (state is DashboardScreenLoaded &&
        (state as DashboardScreenLoaded).tambakList.isNotEmpty) {
      return;
    }
    getTambakData();
  }

  Future<void> getTambakData() async {
    emit(DashboardScreenInitial());
    final response = await dashGetTambakData.call(NoParams());
    response.fold((failure) {
      emit(DashboardScreenError(failure));
    }, (tambakList) {
      emit(DashboardScreenLoaded(tambakList));
    });
  }

  Future<void> resetInput() async {
    emit(DashboardScreenInitial());
  }
}
