import 'package:flutter/cupertino.dart';

Widget infoItem(IconData icon, String text, Color color)  {
  return Row(
    children: [
      Icon(icon, color: color, size: 20),
      const SizedBox(width: 6),
      Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ],
  );
}
