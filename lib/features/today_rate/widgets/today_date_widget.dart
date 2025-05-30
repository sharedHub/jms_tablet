import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayDateDisplay extends StatelessWidget {
  const TodayDateDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final String today = DateFormat('dd-MM-yyyy').format(DateTime.now());

    return TextFormField(
      initialValue: today,
      enabled: false,
      decoration: InputDecoration(
        labelText: "Today's Date",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
