import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    // required this.icon,
    // required this.status,
    required this.statusText,
    // this.desc,
  });

  final String title;
  final String subtitle;
  // final String icon;
  // final bool status;
  final String statusText;
  // final String? desc;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondary,
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.blueAccent, width: 2)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //   height: 72,
          //   width: 72,
          //   decoration: BoxDecoration(
          //     color: Colors.blue.withAlpha(127),
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   alignment: Alignment.center,
          //   child: Image.asset(
          //     icon,
          //     height: 36,
          //     width: 36, // Icon size
          //     color: AppColors.gradientStart,
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 72,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              // Row(
                              //   mainAxisSize: MainAxisSize.min,
                              //   children: [
                              //     Icon(Icons.circle,
                              //         color: status ? Colors.green : Colors.red,
                              //         size: 12),
                              //     const SizedBox(width: 5),
                              //     Text(
                              //       statusText,
                              //       style: TextStyle(
                              //           color:
                              //               status ? Colors.green : Colors.red,
                              //           fontSize: 14),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    // if (desc != null && desc!.isNotEmpty)
                    //   Positioned(
                    //     bottom: 8,
                    //     right: 0,
                    //     child: Text(
                    //       desc!,
                    //       style:
                    //           TextStyle(fontSize: 10, color: Colors.grey[700]),
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
