import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final String title;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const RadioButton({
    super.key,
    required this.title,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(title,
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            Radio<String>(
              value: title,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
