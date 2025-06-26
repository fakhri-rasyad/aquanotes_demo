part of 'divais_screen_cubit.dart';

abstract class DivaisScreenState extends Equatable {
  final String? name;
  final String? id;

  const DivaisScreenState({
    this.name,
    this.id,
  });

  DivaisScreenState copyWith({
    String? name,
    String? id,
  });
  @override
  List<Object?> get props => [
        name,
        id,
      ];
}

class DivaisScreenUpdate extends DivaisScreenState {
  const DivaisScreenUpdate({
    String? name,
    String? id,
  }) : super(
          name: name ?? "",
          id: id ?? "",
        );

  @override
  DivaisScreenState copyWith({
    String? name,
    String? id,
  }) {
    return DivaisScreenUpdate(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}

class DivaisScreenSucceess extends DivaisScreenUpdate {
  final String message;

  DivaisScreenSucceess(
      {required this.message, required DivaisScreenUpdate current})
      : super(
          name: current.name,
          id: current.id,
        );

  @override
  List<Object?> get props => [...super.props, message];
}

class DivaisScreenLoading extends DivaisScreenUpdate {
  DivaisScreenLoading({required DivaisScreenUpdate current})
      : super(name: current.name, id: current.id);

  @override
  List<Object?> get props => [...super.props];
}

class DivaisScreenError extends DivaisScreenUpdate {
  final String message;
  DivaisScreenError(
      {required DivaisScreenUpdate current, required this.message})
      : super(name: current.name, id: current.id);

  @override
  List<Object?> get props => [...super.props, message];
}
