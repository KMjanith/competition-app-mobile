import 'package:flutter/material.dart';

class SelectCompetition extends StatelessWidget {
  final Widget pageToNavigate;
  final String competitionName;
  final Color color;
  const SelectCompetition(
      {super.key, required this.competitionName, required this.color, required this.pageToNavigate});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 125,
          width: 155,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(85, 255, 255, 255)),
            //color: Color.fromARGB(92, 255, 255, 255),
            gradient: LinearGradient(
              colors: [color, Color.fromARGB(255, 232, 191, 240)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => pageToNavigate),
                    );
                  },
                  child: Column(
                    children: [
                      const Image(
                          image: AssetImage("assets/images/medal.png"),
                          height: 40,
                          width: 40),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        competitionName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Color.fromARGB(255, 250, 250, 250)),
                      ),
                    ],
                  )),
            ),
          ),
        ));
  }
}
