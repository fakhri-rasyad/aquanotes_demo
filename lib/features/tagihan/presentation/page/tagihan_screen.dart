import 'package:aquanotes/core/const/strings.dart';
import 'package:aquanotes/features/status/presentation/page/status_screen.dart';
import 'package:aquanotes/features/tagihan/presentation/cubit/tagihan_screen_cubit.dart';
import 'package:aquanotes/features/tagihan/presentation/widget/aktivasi.dart';
import 'package:aquanotes/features/tagihan/presentation/widget/pembayaran.dart';
import 'package:aquanotes/features/tagihan/presentation/widget/pembelian.dart';
import 'package:aquanotes/shared/presentation/pages/popup_screen.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_appbar.dart';
import 'package:aquanotes/shared/presentation/widgets/main_button.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagihanScreen extends StatefulWidget {
  const TagihanScreen({super.key});

  static const routeName = "/tagihan";

  @override
  State<TagihanScreen> createState() => _TagihanScreenState();
}

class _TagihanScreenState extends State<TagihanScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TagihanScreenCubit>().resetInput();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TagihanScreenCubit>();
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: "TAGIHAN",
        onBackButton: null,
        showBackButton: false,
      ),
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, bottom: 80, top: 24),
        child: BlocBuilder<TagihanScreenCubit, TagihanScreenState>(
          builder: (context, state) {
            // final bills = state.bills[state.activeTabIndex];
            return Column(
              children: [
                // _buildTutorialCard(),
                // const SizedBox(height: 24.0),
                Row(
                  children: List.generate(StringsConst.tabs.length, (index) {
                    return Expanded(
                      child: _buildChipButton(
                        StringsConst.tabs[index],
                        state.activeTabIndex == index,
                        () => cubit.updateState(activeTabIndex: index),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Builder(
                    builder: (_) {
                      switch (state.activeTabIndex) {
                        case 0:
                          return PembelianWidget(
                            currentDevice: state.divaisCount,
                            currentPackage: state.package,
                            updatePackage: (value) =>
                                cubit.updateState(package: value),
                            updateDevice: (value) =>
                                cubit.updateState(divaisCount: value),
                          );
                        case 1:
                          return const PembayaranWidget();
                        case 2:
                          return const AktivasiWidget();
                        default:
                          return const SizedBox(); // Fallback UI
                      }
                    },
                  ),
                ),

                const Divider(
                  color: AppColors.blueAccent,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(builder: (_) {
                        return state.activeTabIndex == 1
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Total Tagihan:",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${state.totalAmount}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.gradientStart),
                                  )
                                ],
                              )
                            : const SizedBox();
                      }),
                      MainButton(
                          buttonText: state.activeTabIndex == 0
                              ? "Bayar"
                              : state.activeTabIndex == 1
                                  ? "Transaksi"
                                  : "Aktivasi",
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, PopupScreen.routeName,
                                arguments: ScreenArgument(
                                    buttonConfig: [
                                      const ButtonConfig(
                                          text: "Cek Status",
                                          route: StatusScreen.routeName,
                                          isMain: true)
                                    ],
                                    title:
                                        "Selamat! Aktivasi Fitur Premium Aeraseaku telah berhasil",
                                    subtitle:
                                        "Selamat menikmati fitur premium dari Aeraseaku dalam optimaliasi manajemen budidaya. Semoga bermanfaat!",
                                    asset:
                                        "assets/images/home/menu/tambak/Like.png"));
                            // final selectedBills = state.bills
                            //     .expand((bills) => bills)
                            //     .where((bill) =>
                            //         state.selectedBillIds.contains(bill.id))
                            //     .toList();

                            // showModalBottomSheet(
                            //   context: context,
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(16.0),
                            //   ),
                            //   builder: (ctx) =>
                            //       _buildBottomSheet(context, selectedBills),
                            // );
                          }),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Tab Button
  Widget _buildChipButton(String label, bool selected, VoidCallback change) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: change,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: selected ? AppColors.gradientStart : AppColors.fadeLightBlue,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: selected ? AppColors.secondary : AppColors.gradientStart,
            ),
          ),
        ),
      ),
    );
  }
}
