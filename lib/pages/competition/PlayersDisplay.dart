import 'dart:developer';

import 'package:competition_app/cubit/fed_shol_competiton_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Constants/StyleConstants.dart';
import '../../components/common/HedingAnimation.dart';
import '../../model/Player.dart';

class PlayersDisplay extends StatefulWidget {
  final String heading;
  final List<Player> players;
  const PlayersDisplay(
      {super.key, required this.players, required this.heading});

  @override
  State<PlayersDisplay> createState() => _PlayersDisplayState();
}

class _PlayersDisplayState extends State<PlayersDisplay> {
  get heading => widget.heading;

  @override
  Widget build(BuildContext context) {
    log("players: ${widget.players}");
    return Scaffold(
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          StyleConstants.lowerBackgroundContainer,
          Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ],
              ),
              HeadingAnimation(heading: "$heading"),
              const Text(
                "All Players Details are here",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(child: BlocBuilder<FedSholCompetitionCubit, FedSholCompetitionState>(
                builder: (context, state) {
                  
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: widget.players.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 184, 40),
                              borderRadius: BorderRadius.circular(15)),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                bottom: 0,
                                child: Container(
                                  height: 100,
                                  width: 250,
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 50, 212, 1),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          topRight: Radius.circular(55),
                                          bottomRight: Radius.circular(55))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        details("Name ",
                                            widget.players[index].name),
                                        details("level",
                                            widget.players[index].level),
                                        details(
                                            "competeCategory",
                                            widget.players[index]
                                                .competeCategory),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ))
            ],
          )
        ],
      ),
    );
  }

  Row details(String key, String value) {
    return Row(
      children: [
        Text(
          key,
          style: const TextStyle(
              color: Color.fromARGB(
                255,
                0,
                0,
                0,
              ),
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          value,
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ],
    );
  }
}
