import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/Competition.dart';
import '../model/Player.dart';
import '../services/AuthService.dart';

part 'fed_shol_competiton_state.dart';

class FedSholCompetitionCubit extends Cubit<FedSholCompetitionState> {
  FedSholCompetitionCubit() : super(FedSholCompetitionInitial());

  void loadCompetitions(FirebaseFirestore db, String type) async {
    emit(FedSholCompetitonLoading());

    try {
      final auth = Authservice();
      final uid = auth.getCurrentUserId();
      final List<Competition> competitions = [];
      QuerySnapshot querySnapshot = await db
          .collection('Competitions')
          .where('userId', isEqualTo: uid)
          .get();

      final results = querySnapshot.docs;

      for (var i = 0; i < results.length; i++) {
        final element = results[i];
        if (element["name"] == type) {
          List<dynamic> playerString = element["players"];
          final List<Player> players = [];
          for (var j = 0; j < playerString.length; j++) {
            var player = playerString[j].split(',');
            var name = player[0].trim().toString();
            var birthCertificateNumber = player[1].trim().toString();
            var level = player[2].trim().toString();
            var competeCategory = player[3].trim().toString();
            var kata = bool.parse(player[4].trim());
            var kumite = bool.parse(player[5].trim());
            var teamKata = bool.parse(player[6].trim());
            var weight = int.parse(player[7].trim());

            final playerObject = Player(
                name: name,
                birthCertificateNumber: birthCertificateNumber,
                level: level,
                competeCategory: competeCategory,
                kata: kata,
                kumite: kumite,
                teamKata: teamKata,
                weight: weight);

            players.add(playerObject);
          }
          final competition = Competition(
              player: players,
              date: DateTime.parse(element["date"]),
              place: element["place"],
              type: element["type"],
              userId: element["userId"],
              name: element["name"]);

          competitions.add(competition);
        }
      }

      emit(FedSholCompetitonLoaded(competitions));
    } catch (e) {
      emit(FedSholCompetitonError(e.toString()));
    }
  }

  void addCompetition(Competition newCompetition) {
    if (state is FedSholCompetitonLoaded) {
      final currentState = state as FedSholCompetitonLoaded;
      emit(FedSholCompetitonLoaded(
          [...currentState.competitions, newCompetition]));
    }
  }
}
