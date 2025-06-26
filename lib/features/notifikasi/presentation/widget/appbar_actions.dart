import 'package:aquanotes/features/add_alarm/presentation/page/add_alarm_screen.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class AppbarActions extends StatelessWidget {
  const AppbarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: AppColors.secondary,
      onSelected: (item) => _handleAction(item, context),
      itemBuilder: (context) => const [
        PopupMenuItem<int>(value: 0, child: Text("Bersihkan")),
        PopupMenuItem<int>(value: 1, child: Text("Riwayat")),
        PopupMenuItem<int>(value: 2, child: Text("Atur Alarm")),
      ],
    );
  }

  void _handleAction(int index, BuildContext context) {
    switch (index) {
      case 0:
        // TODO: Implement clear notifications logic
        break;
      case 1:
        // TODO: Implement view history logic
        break;
      case 2:
        Navigator.of(context).pushNamed(AddAlarmScreen.routeName);
        break;
    }
  }
}
