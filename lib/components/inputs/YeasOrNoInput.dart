import 'package:flutter/material.dart';

class YeasOrNoInput extends StatelessWidget {
  final String title;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const YeasOrNoInput({
    Key? key,
    required this.title,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color.fromARGB(150, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Text(title),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<String>(
                      value: "Yes",
                      groupValue: groupValue,
                      onChanged: onChanged,
                    ),
                    const Text("Yes", style: TextStyle(color: Colors.white),),
                    Radio<String>(
                      value: "No",
                      groupValue: groupValue,
                      onChanged: onChanged,
                    ),
                    const Text("No",style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
