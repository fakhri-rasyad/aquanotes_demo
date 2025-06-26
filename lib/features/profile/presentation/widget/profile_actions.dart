import 'package:flutter/material.dart';

class ProfileActions extends StatelessWidget {
  final String optionName;
  final VoidCallback onTap;

  const ProfileActions(
      {super.key, required this.onTap, required this.optionName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(optionName),
                const Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
