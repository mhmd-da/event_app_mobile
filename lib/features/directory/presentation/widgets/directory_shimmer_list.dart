import 'package:flutter/material.dart';

class DirectoryShimmerList extends StatelessWidget {
  const DirectoryShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (_, __) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: Colors.grey.shade300.withOpacity(0.5),
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        );
      },
    );
  }
}
