import 'package:flutter/material.dart';
import '../../model/Player.dart';
import '../../pages/competition/PlayersDisplay.dart';

class KatKumiteTile extends StatelessWidget {
  final String competitonId;
  final String title;
  final List<Player> players;
  final String itemCount;
  const KatKumiteTile(
      {super.key,
      required this.title,
      required this.players,
      required this.competitonId,
      required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 7.0, left: 18, bottom: 5, right: 18),
        child: Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(137, 10, 10, 9),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: GestureDetector(
            onTap: () {
              
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlayersDisplay(
                        competitonId: competitonId,
                        players: players,
                        heading: "$title kata players",
                      )));
            },
            child: ListTile(
                title: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                trailing: Text(
                  "Players: $itemCount",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                )),
          ),
        ));
  }
}
