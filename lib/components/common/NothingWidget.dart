import 'package:flutter/material.dart';

class NothingWidget extends StatelessWidget {
  final String content;
  final IconData icon;
  const NothingWidget({super.key, required this.content, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(153, 235, 95, 95)),
        child:  Column(
          children: [
            Icon(
              icon,
              size: 100,
              color: const Color.fromARGB(255, 247, 252, 188),
            ),
            
            Padding(
              padding:const EdgeInsets.all(8.0),
              child: Text(content, style: const TextStyle(color: Colors.white, fontSize: 16),),
            ),
          ],
        ),
      ),
    );
  }
}
