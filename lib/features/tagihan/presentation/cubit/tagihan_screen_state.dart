part of 'tagihan_screen_cubit.dart';

abstract class TagihanScreenState extends Equatable {
  final int activeTabIndex;
  final double? totalAmount;
  final String? dateStartTime;
  final String? dateEndTime;
  final String? reffCode;
  final String? package;
  final String? divaisCount;

  const TagihanScreenState(
      {required this.activeTabIndex,
      this.totalAmount,
      this.dateStartTime,
      this.dateEndTime,
      this.reffCode,
      this.package,
      this.divaisCount});

  TagihanScreenState copyWith({
    int? activeTabIndex,
    double? totalAmount,
    String? dateStartTime,
    String? dateEndTime,
    String? reffCode,
    String? package,
    String? divaisCount,
  });

  @override
  List<Object?> get props => [
        activeTabIndex,
        totalAmount,
        dateStartTime,
        dateEndTime,
        reffCode,
        package,
        divaisCount
      ];
}

class TagihanScreenUpdate extends TagihanScreenState {
  const TagihanScreenUpdate({
    super.activeTabIndex = 0,
    super.totalAmount,
    super.dateStartTime,
    super.dateEndTime,
    super.reffCode,
    super.package,
    super.divaisCount,
  });

  @override
  TagihanScreenState copyWith(
      {int? activeTabIndex,
      double? totalAmount,
      String? dateStartTime,
      String? dateEndTime,
      String? reffCode,
      String? package,
      String? divaisCount}) {
    return TagihanScreenUpdate(
        activeTabIndex: activeTabIndex ?? this.activeTabIndex,
        totalAmount: totalAmount ?? this.totalAmount,
        dateStartTime: dateStartTime ?? this.dateStartTime,
        dateEndTime: dateEndTime ?? this.dateEndTime,
        reffCode: reffCode ?? this.reffCode,
        package: package ?? this.package,
        divaisCount: divaisCount ?? this.divaisCount);
  }

  @override
  List<Object?> get props => [...super.props];
}
