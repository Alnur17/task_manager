import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/capitalization_utils.dart';

class SummeryCard extends StatelessWidget {
  const SummeryCard({
    super.key,
    required this.number,
    required this.title,
  });

  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: (width / 4) - 4, // Minus 4 cause cart has default margin
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$number',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(CapitalizationUtils.capitalize(title)),
          ],
        ),
      ),
    );
  }

}