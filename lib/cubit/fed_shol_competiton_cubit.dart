import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:competition_app/Constants/AppConstants.dart';
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
              id: element.id,
              player: players,
              date: DateTime.parse(element["date"]),
              place: element["place"],
              type: element["type"],
              userId: element["userId"],
              weights: element["weights"],
              name: element["name"]);

          competitions.add(competition);
        }
      }

      emit(FedSholCompetitonLoaded(competitions, const [], const [], const [], const [], const []));
    } catch (e) {
      emit(FedSholCompetitonError(e.toString()));
    }
  }

  void clearPlayerLists() {
    if (state is FedSholCompetitonLoaded) {
      final currentState = state as FedSholCompetitonLoaded;
      emit(FedSholCompetitonLoaded(
          currentState.competitions, const [], const [], const [], const [], const []));
    }
  }

  void addCompetition(Competition newCompetition) {
    if (state is FedSholCompetitonLoaded) {
      final currentState = state as FedSholCompetitonLoaded;
      emit(FedSholCompetitonLoaded(
          [...currentState.competitions, newCompetition],
          currentState.lv1KataPlayers,
          currentState.lv2KataPlayers,
          currentState.lv3KataPlayers,
          currentState.lv4KataPlayers,
          currentState.lv5KataPlayers));
    }
  }

  void deleteCompetiton(int index, List<Competition> currentList) {
    if (state is FedSholCompetitonLoaded) {
      final updatedList = List<Competition>.from(currentList);
      final currentState = state as FedSholCompetitonLoaded;
      updatedList.removeAt(index);
      emit(FedSholCompetitonLoaded(
          updatedList,
          currentState.lv1KataPlayers,
          currentState.lv2KataPlayers,
          currentState.lv3KataPlayers,
          currentState.lv4KataPlayers,
          currentState.lv5KataPlayers)); // Emit the updated state
    }
  }

  void updateCompetitions(List<Competition> updatedList) {
    if (state is FedSholCompetitonLoaded) {
      final currentState = state as FedSholCompetitonLoaded;
      emit(FedSholCompetitonLoaded(
          updatedList,
          currentState.lv1KataPlayers,
          currentState.lv2KataPlayers,
          currentState.lv3KataPlayers,
          currentState.lv4KataPlayers,
          currentState.lv5KataPlayers));
    }
  }

  List<Player> getLv1KataPlayers() {
    final currentState = state as FedSholCompetitonLoaded;
    return currentState.lv1KataPlayers;
  }

  List<Player> getLv2KataPlayers() {
    final currentState = state as FedSholCompetitonLoaded;
    return currentState.lv2KataPlayers;
  }

  List<Player> getLv3KataPlayers() {
    final currentState = state as FedSholCompetitonLoaded;
    return currentState.lv3KataPlayers;
  }

  List<Player> getLv4KataPlayers() {
    final currentState = state as FedSholCompetitonLoaded;
    return currentState.lv4KataPlayers;
  }

  List<Player> getLv5KataPlayers() {
    final currentState = state as FedSholCompetitonLoaded;
    return currentState.lv5KataPlayers;
  }

  List<Competition> getCompetitions() {
    final currentState = state as FedSholCompetitonLoaded;
    return currentState.competitions;
  }

  void addPlayer(Player player) {
    final currentState = state as FedSholCompetitonLoaded;
    if (player.level == AppConstants.levels[0]) {
      emit(FedSholCompetitonLoaded(
          currentState.competitions,
          [...currentState.lv1KataPlayers, player],
          currentState.lv2KataPlayers,
          currentState.lv3KataPlayers,
          currentState.lv4KataPlayers,
          currentState.lv5KataPlayers));
      log("new level 1list : ${currentState.lv1KataPlayers}");
    } else if (player.level == AppConstants.levels[1]) {
      emit(FedSholCompetitonLoaded(
          currentState.competitions,
          currentState.lv1KataPlayers,
          [...currentState.lv2KataPlayers, player],
          currentState.lv3KataPlayers,
          currentState.lv4KataPlayers,
          currentState.lv5KataPlayers));
      log("new level 2list : ${currentState.lv2KataPlayers}");
    } else if (player.level == AppConstants.levels[2]) {
      emit(FedSholCompetitonLoaded(
          currentState.competitions,
          currentState.lv1KataPlayers,
          currentState.lv2KataPlayers,
          [...currentState.lv3KataPlayers, player],
          currentState.lv4KataPlayers,
          currentState.lv5KataPlayers));
      log("new level 3list : ${currentState.lv3KataPlayers}");
    } else if (player.level == AppConstants.levels[3]) {
      emit(FedSholCompetitonLoaded(
          currentState.competitions,
          currentState.lv1KataPlayers,
          currentState.lv2KataPlayers,
          currentState.lv3KataPlayers,
          [...currentState.lv4KataPlayers, player],
          currentState.lv5KataPlayers));
      log("new level 4list : ${currentState.lv4KataPlayers}");
    } else if (player.level == AppConstants.levels[4]) {
      emit(FedSholCompetitonLoaded(
          currentState.competitions,
          currentState.lv1KataPlayers,
          currentState.lv2KataPlayers,
          currentState.lv3KataPlayers,
          currentState.lv4KataPlayers,
          [...currentState.lv5KataPlayers, player]));
      log("new level 5list : ${currentState.lv5KataPlayers}");
    }
  }
}
