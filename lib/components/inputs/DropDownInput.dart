import 'package:flutter/material.dart';

class DropDownInput extends StatefulWidget {
  final List<DropdownMenuItem<String>> itemList;
  final ValueChanged<String?> onChanged;
  final String title;
  const DropDownInput(
      {Key? key, required this.itemList, required this.onChanged, required this.title})
      : super(key: key);
  @override
  _DropDownInputState createState() => _DropDownInputState();
}

class _DropDownInputState extends State<DropDownInput> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 8.0, top: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          filled: true,
            fillColor: const Color.fromARGB(150, 255, 255, 255),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none, // No border side color
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: Colors.transparent), // Transparent border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: Colors.transparent), // Transparent border
          ),
        ),
        value: selectedItem,
        hint:Text(
          widget.title,
          style: TextStyle(color: Color.fromARGB(255, 61, 61, 61)),
        ),
        items: widget.itemList,
        onChanged: (String? newValue) {
          setState(() {
            selectedItem = newValue;
          });
          widget.onChanged(newValue);
        },
      ),
    );
  }
}
