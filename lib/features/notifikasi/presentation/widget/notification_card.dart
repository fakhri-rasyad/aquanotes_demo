import 'package:aquanotes/features/notifikasi/domain/entities/notification_entity.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    switch (notification.category) {
      case "Warning":
        bgColor = Colors.orange;
        break;
      case "Info":
        bgColor = Colors.blue;
        break;
      default:
        bgColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: bgColor.withAlpha(47),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.notification_important_outlined,
              color: AppColors.blueAccent),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: AppColors.gradientStart,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Implement dismiss logic
                      },
                      child: const Icon(Icons.cancel_outlined,
                          color: AppColors.mediumGray, size: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notification.subtitle,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    notification.date,
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.mediumGray),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
