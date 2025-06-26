import 'package:aquanotes/core/styles/text_style.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class PembayaranCard extends StatelessWidget {
  final String paymentType;
  final String paymentName;
  final String paymentLength;
  final String paymentPrice;

  const PembayaranCard({
    super.key,
    required this.paymentType,
    required this.paymentName,
    required this.paymentLength,
    required this.paymentPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.fadeLightBlue,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              paymentType,
              style: ThemeTextStyle.cardLabelStyle,
            ),
            Row(
              children: [
                Expanded(flex: 2, child: Text(paymentName)),
                Expanded(child: Text(paymentLength)),
                Expanded(child: Text(paymentPrice))
              ],
            )
          ],
        ),
      ),
    );
  }
}
