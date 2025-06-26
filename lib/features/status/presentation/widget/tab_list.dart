import 'package:aquanotes/features/status/domain/entities/info_card_data.dart';
import 'package:aquanotes/features/status/presentation/widget/status_info_card.dart';
import 'package:flutter/material.dart';

class StatusList extends StatelessWidget {
  const StatusList({super.key, required this.data});

  final List<InfoCardData>? data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: data!.length,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 8.0),
      itemBuilder: (BuildContext context, int index) {
        InfoCardData info = data![index];
        return InfoCard(
          title: info.title,
          subtitle: info.subtitle,
          // status: info.status,
          statusText: info.statusText,
          // icon: info.icon,
        );
      },
    );
  }
}
