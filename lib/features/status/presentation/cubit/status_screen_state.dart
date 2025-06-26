part of 'status_screen_cubit.dart';

abstract class StatusScreenState extends Equatable {
  final int selectedTab;
  final List<TambakResponseModel>? tambakData;
  final List<KolamRespModel>? kolamData;
  final List<DivaisResponseModel>? divaisData;
  final List? selectedList;
  // final bool isLoading;

  const StatusScreenState(
      {this.selectedTab = 0,
      this.tambakData,
      this.kolamData,
      this.divaisData,
      this.selectedList
      // this.isLoading = true,
      });

  StatusScreenState copyWith(
      {int? selectedTab,
      List<TambakResponseModel>? tambakData,
      List<KolamRespModel>? kolamData,
      List<DivaisResponseModel>? divaisData,
      List? selectedList
      // bool? isLoading,
      });

  @override
  List<Object?> get props => [
        selectedTab, tambakData, kolamData, divaisData, selectedList
        // isLoading
      ];
}

class StatusScreenUpdate extends StatusScreenState {
  const StatusScreenUpdate(
      {super.divaisData,
      super.kolamData,
      super.tambakData,
      super.selectedTab,
      super.selectedList});

  @override
  StatusScreenState copyWith(
      {int? selectedTab,
      List<TambakResponseModel>? tambakData,
      List<KolamRespModel>? kolamData,
      List<DivaisResponseModel>? divaisData,
      List? selectedList
      // bool? isLoading
      }) {
    return StatusScreenUpdate(
      divaisData: this.divaisData ?? [],
      kolamData: this.kolamData ?? [],
      tambakData: this.tambakData ?? [],
      selectedTab: this.selectedTab,
      selectedList: this.selectedList ?? [],
    );
  }
}

class StatusScreenLoading extends StatusScreenUpdate {
  StatusScreenLoading({required StatusScreenUpdate current})
      : super(
          divaisData: current.divaisData,
          tambakData: current.tambakData,
          kolamData: current.kolamData,
          selectedTab: current.selectedTab,
          selectedList: current.selectedList,
        );
  @override
  List<Object?> get props => [...super.props];
}

class StatusScreenError extends StatusScreenUpdate {
  final String msg;
  StatusScreenError({required StatusScreenUpdate current, required this.msg})
      : super(
          divaisData: current.divaisData,
          tambakData: current.tambakData,
          kolamData: current.kolamData,
          selectedTab: current.selectedTab,
          selectedList: current.selectedList,
        );

  @override
  List<Object?> get props => [...super.props];
}
