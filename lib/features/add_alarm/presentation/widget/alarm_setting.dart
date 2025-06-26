import 'package:aquanotes/features/add_alarm/presentation/cubit/alarm_setting_state.dart';
import 'package:flutter/material.dart';

import 'edit_dialog.dart';

class AlarmSettingCard extends StatelessWidget {
  final SensorSetting setting;

  const AlarmSettingCard({super.key, required this.setting});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEAF2FF),
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: () => showDialog(
          context: context,
          builder: (context) => EditDialog(
            name: setting.name,
            min: "Min",
            max: "Max",
            initiaMinlValue: setting.min.toString(),
            initialMaxValue: setting.max.toString(),
            onMaxChanged: (String newMax) {},
            onMinChanged: (String newMin) {},
          ),
        ),
        leading: Image.asset(
          _handleAlarmSettingIcon(setting.name),
          width: 48,
          height: 48,
        ),
        title: Text(setting.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Batas tertinggi:"),
                Text("${setting.max} >")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Batas terendah:",
                ),
                Text("${setting.min} >")
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String _handleAlarmSettingIcon(String name) {
  switch (name) {
    case "Suhu":
      return "assets/images/home/notification/add_alarm/1.png";
    case "pH":
      return "assets/images/home/notification/add_alarm/2.png";
    case "Salinitas":
      return "assets/images/home/notification/add_alarm/3.png";
    case "Oksigen Terlarut":
      return "assets/images/home/notification/add_alarm/4.png";
    case "Amonia":
      return "assets/images/home/notification/add_alarm/5.png";
    default:
      return "assets/images/home/notification/add_alarm/1.png";
  }
}
