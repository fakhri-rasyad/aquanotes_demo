import 'package:aquanotes/core/styles/text_style.dart';
import 'package:aquanotes/features/tagihan/presentation/widget/pembayaran_card.dart';
import 'package:flutter/material.dart';

class PembayaranWidget extends StatelessWidget {
  const PembayaranWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Rincian Tagihan", style: ThemeTextStyle.labelStyle),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 7,
              itemBuilder: (context, index) {
                return const PembayaranCard(
                    paymentType: "Berlangganan",
                    paymentName: "Fitur Premium Premium Premium Premium",
                    paymentLength: "90 Hari",
                    paymentPrice: "Rp.500,000");
              }),
        )
      ],
    );
  }
}
