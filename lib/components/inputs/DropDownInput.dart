import 'package:flutter/material.dart';

class DropDownInput extends StatefulWidget {
  final List<DropdownMenuItem<String>> itemList;
  final ValueChanged<String?> onChanged;
  final String title;

  const DropDownInput({
    Key? key,
    required this.itemList,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  @override
  _DropDownInputState createState() => _DropDownInputState();
}

class _DropDownInputState extends State<DropDownInput> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 8.0, top: 8.0),
      child: DropdownButtonFormField<String>(
        icon: Icon(Icons.arrow_circle_down_outlined, color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(64, 139, 139, 139),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
        value: selectedItem,
        hint: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        items: widget.itemList,
        onChanged: (String? newValue) {
          setState(() {
            selectedItem = newValue;
          });
          widget.onChanged(newValue);
        },
        selectedItemBuilder: (BuildContext context) {
          return widget.itemList.map((DropdownMenuItem<String> item) {
            return Text(
              item.value ?? '',
              style: TextStyle(
                color: item.value == selectedItem ? Colors.white : Colors.black,
              ),
            );
          }).toList();
        },
      ),
    );
  }
}
