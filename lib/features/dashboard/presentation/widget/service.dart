import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ServiceItem> services = [
      ServiceItem(
        title: "Research Collaboration",
        subtitle:
            "Peluang kolaborasi riset pengembangan Aquatech bersama Aerasea",
        icon: "assets/images/home/dashboard/service/3.png",
      ),
      ServiceItem(
        title: "Aquatech Development",
        subtitle: "Teknologi pendukung budidaya berdasarkan kebutuhan",
        icon: "assets/images/home/dashboard/service/2.png",
      ),
      ServiceItem(
        title: "Maintenance Support",
        subtitle: "Pendampingan teknologi dan pemeliharaan perangkat",
        icon: "assets/images/home/dashboard/service/1.png",
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Layanan Kami",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12.0),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.6),
            itemCount: services.length,
            itemBuilder: (context, index) {
              return ServiceItemWidget(item: services[index]);
            },
          ),
        ],
      ),
    );
  }
}

class ServiceItem {
  final String title;
  final String subtitle;
  final String icon;

  ServiceItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class ServiceItemWidget extends StatelessWidget {
  final ServiceItem item;

  const ServiceItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient background container
        Container(
          padding: const EdgeInsets.only(top: 12, left: 12.0, right: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: const LinearGradient(
              colors: [AppColors.gradientEnd, AppColors.gradientStart],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon image
              Image.asset(
                item.icon,
                height: 48,
                width: 48,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8.0),
              // Title text
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1, // Ensure the title doesn't overflow
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 4.0),
              // Subtitle text
              Text(
                item.subtitle,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
                maxLines: 5, // Limit subtitle to 3 lines
                overflow: TextOverflow.ellipsis, // Show ellipsis for long text
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        // Background image
        Positioned.fill(
          child: Image.asset(
            "assets/images/home/dashboard/service/back.png",
            fit: BoxFit.cover, // Ensures the image covers the entire container
          ),
        ),
      ],
    );
  }
}


