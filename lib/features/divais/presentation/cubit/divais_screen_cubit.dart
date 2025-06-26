import 'package:aquanotes/features/divais/domain/entity/divais_entity.dart';
import 'package:aquanotes/features/divais/domain/usecase/post_divais.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'divais_screen_state.dart';

class DivaisScreenCubit extends Cubit<DivaisScreenState> {
  DivaisScreenCubit(this.postDivais) : super(const DivaisScreenUpdate());

  DivaisScreenUpdate get current => state as DivaisScreenUpdate;

  final PostDivais postDivais;

  void updateDivais({
    String? name,
    String? id,
  }) {
    emit(state.copyWith(
      name: name,
      id: id,
    ));
  }

  void resetInput() {
    emit(const DivaisScreenUpdate());
  }

  void processData() async {
    emit(DivaisScreenLoading(current: state as DivaisScreenUpdate));
    final divaisEntity = DivaisEntity(state.id ?? "", state.name ?? "");

    final response = await postDivais.call(divaisEntity);

    response.fold((error) {
      emit(DivaisScreenError(
          message: error, current: state as DivaisScreenUpdate));
    }, (model) {
      emit(DivaisScreenSucceess(
          message: model.name, current: state as DivaisScreenUpdate));
    });
  }
}
