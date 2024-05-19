import 'package:flutter/material.dart';

class DropDownInput extends StatefulWidget {
  final List<DropdownMenuItem<String>> itemList;

  const DropDownInput({Key? key, required this.itemList}) : super(key: key);

  @override
  _DropDownInputState createState() => _DropDownInputState();
}

class _DropDownInputState extends State<DropDownInput> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:8.0, left: 8.0, bottom: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        value: selectedItem,
        hint: const Text("Select Grade"),
        items: widget.itemList,
        onChanged: (String? newValue) {
          setState(() {
            selectedItem = newValue;
          });
        },
      ),
    );
  }
}
