import 'package:aquanotes/features/status/domain/entities/card_data.dart';
import 'package:aquanotes/features/status/presentation/cubit/status_screen_cubit.dart';
import 'package:aquanotes/features/status/presentation/widget/status_info_card.dart';
import 'package:aquanotes/features/status/presentation/widget/tab_button.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_appbar.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  static const routeName = "/status";

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StatusScreenCubit>().getData();
  }

  @override
  Widget build(BuildContext context) {
    List<CardItem> tabs = [
      CardItem(title: "Tambak", icon: "assets/images/home/status/package.png"),
      CardItem(title: "Kolam", icon: "assets/images/home/status/inventory.png"),
      CardItem(title: "Divais", icon: "assets/images/home/status/database.png")
    ];

    final cubit = context.read<StatusScreenCubit>();

    return Scaffold(
      appBar: const CustomAppBar(
        titleText: "Status",
        backGroundColor: AppColors.gradientStart,
        textColors: AppColors.secondary,
      ),
      backgroundColor: AppColors.gradientStart,
      body: BlocConsumer<StatusScreenCubit, StatusScreenState>(
        listener: (context, state) {
          if (state is StatusScreenError) {
            final snackBar = SnackBar(content: Text(state.msg));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    // White rounded container at the bottom
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.85,
                        constraints: const BoxConstraints(maxHeight: 800),
                        decoration: const BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(48.0)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 60), // Spacer for avatar
                            if (state is StatusScreenLoading)
                              const CircularProgressIndicator()
                            else if (state.tambakData != null &&
                                state.tambakData!.isNotEmpty) ...[
                              Text(
                                state.tambakData!.first.name,
                                style: const TextStyle(
                                  color: AppColors.gradientStart,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                state.tambakData!.first.cultivationType,
                                style: const TextStyle(
                                  color: AppColors.mediumGray,
                                  fontSize: 12,
                                ),
                              ),
                            ] else ...[
                              const Text(
                                "Anda belum menambahkan tambak anda!",
                                style: TextStyle(
                                  color: AppColors.mediumGray,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(tabs.length, (index) {
                                  return TabButton(
                                    label: tabs[index].title,
                                    isSelected: index == state.selectedTab,
                                    icon: tabs[index].icon,
                                    changeTab: () => cubit.updateTab(index),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: Stack(
                                children: [
                                  if (state is StatusScreenLoading)
                                    const Center(
                                        child: CircularProgressIndicator())
                                  else if (state.selectedList == null ||
                                      state.selectedList!.isEmpty)
                                    const Center(
                                      child: Text(
                                        "Sepertinya anda belum menambahkan data?",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    )
                                  else
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView.builder(
                                        itemCount: state.selectedList!.length,
                                        itemBuilder: (context, index) {
                                          final data =
                                              state.selectedList![index];
                                          return InfoCard(
                                            title: data.title,
                                            subtitle: data.subtitle,
                                            statusText: data.statusText,
                                          );
                                        },
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Profile picture on top center
                    Positioned(
                      bottom: MediaQuery.of(context).size.height *
                          0.80, // Adjust as needed
                      left: 0,
                      right: 0,
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.fadeLightBlue,
                        child: Icon(Icons.person,
                            size: 48, color: AppColors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
