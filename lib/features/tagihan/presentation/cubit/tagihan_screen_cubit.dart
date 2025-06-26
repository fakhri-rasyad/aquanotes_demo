import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tagihan_screen_state.dart';

class TagihanScreenCubit extends Cubit<TagihanScreenState> {
  TagihanScreenCubit()
      : super(const TagihanScreenUpdate(
          activeTabIndex: 0,
        ));

  void changeTab(int index) {
    emit(state.copyWith(activeTabIndex: index));
  }

  void resetInput() {
    emit(const TagihanScreenUpdate(activeTabIndex: 0));
  }

  void updateState({
    int? activeTabIndex,
    double? totalAmount,
    String? dateStartTime,
    String? dateEndTime,
    String? reffCode,
    String? package,
    String? divaisCount,
  }) {
    emit(state.copyWith(
        activeTabIndex: activeTabIndex,
        totalAmount: totalAmount,
        dateEndTime: dateEndTime,
        dateStartTime: dateStartTime,
        reffCode: reffCode,
        package: package,
        divaisCount: divaisCount));
  }

//   void toggleBillSelection(String billId, double amount) {
//     final updatedSelectedBillIds = Set<String>.from(state.selectedBillIds);
//     double newTotal = state.totalSelectedAmount;

//     if (updatedSelectedBillIds.contains(billId)) {
//       updatedSelectedBillIds.remove(billId);
//       newTotal -= amount;
//     } else {
//       updatedSelectedBillIds.add(billId);
//       newTotal += amount;
//     }

//     emit(state.copyWith(
//       selectedBillIds: updatedSelectedBillIds,
//       totalSelectedAmount: newTotal,
//     ));
//   }
// }

// List<List<Bill>> _generateAllMockBills() {
//   List<Bill> penyewaan = _generateMockBills("PENYEWAAN");
//   List<Bill> pembelian = _generateMockBills("PEMBELIAN");
//   List<Bill> lunas = _generateMockBills("LUNAS");

//   return [penyewaan, pembelian, lunas];
// }

// List<Bill> _generateMockBills(String category) {
//   return List.generate(5, (index) {
//     return Bill(
//       id: "$category-$index", // Unique ID per category
//       name: "$category Tagihan ${index + Random().nextInt(6)}",
//       dueDate: "2025-02-${Random().nextInt(7) + index}",
//       amount: (100000 * (index + Random().nextInt(7))).toDouble(),
//       category: category, // Assign category
//     );
//   });
}
