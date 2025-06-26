import 'package:aquanotes/features/notifikasi/domain/entities/notification_entity.dart';
import 'package:aquanotes/features/notifikasi/presentation/widget/notification_card.dart';
import 'package:flutter/material.dart';

class NotificationList extends StatelessWidget {
  final List<NotificationModel> notifications;

  const NotificationList({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Aquanotes",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.separated(
            itemCount: notifications.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return NotificationCard(notification: notifications[index]);
            },
          ),
        ),
      ],
    );
  }
}
