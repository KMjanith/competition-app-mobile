import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:competition_app/Constants/AppConstants.dart';
import 'package:competition_app/Constants/KarateEvents.dart';
import 'package:competition_app/services/CompetitionService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/Competition.dart';
import '../model/Player.dart';
import '../services/AuthService.dart';

part 'fed_shol_competiton_state.dart';

class FedSholCompetitionCubit extends Cubit<FedSholCompetitionState> {
  FedSholCompetitionCubit() : super(FedSholCompetitionInitial());

  final auth = Authservice();
  final competitonService = CompetitionService();

  void loadCompetitions(FirebaseFirestore db, String type) async {
    emit(FedSholCompetitonLoading());

    try {
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
            var paymentStatus = player[8].trim().toString();
            var paidAmount = player[9].trim().toString();
            var paidDate = player[10].trim().toString();

            final playerObject = Player(
                name: name,
                birthCertificateNumber: birthCertificateNumber,
                level: level,
                competeCategory: competeCategory,
                kata: kata,
                kumite: kumite,
                teamKata: teamKata,
                weight: weight,
                paymentStatus: paymentStatus,
                paidAmount: paidAmount,
                paidDate: paidDate);

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

      emit(FedSholCompetitonLoaded(competitions, const [], const [], const [],
          const [], const [], const {}, const []));
    } catch (e) {
      emit(FedSholCompetitonError(e.toString()));
    }
  }

  void clearPlayerLists() {
    if (state is FedSholCompetitonLoaded) {
      final currentState = state as FedSholCompetitonLoaded;
      emit(FedSholCompetitonLoaded(currentState.competitions, const [],
          const [], const [], const [], const [], const {}, []));
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
          currentState.lv5KataPlayers,
          currentState.kumitePlayers,
          currentState.kataPlayerByCategory));
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
          currentState.lv5KataPlayers,
          currentState.kumitePlayers,
          currentState.kataPlayerByCategory)); // Emit the updated state
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
          currentState.lv5KataPlayers,
          currentState.kumitePlayers,
          currentState.kataPlayerByCategory)); // Emit the updated state
    }
  }

  List<Player> getLv1KataPlayers() {
    final currentState = state as FedSholCompetitonLoaded;
    return currentState.lv1KataPlayers;
  }

  void setL1List(List<Player> player) {
    final currentState = state as FedSholCompetitonLoaded;
    emit(FedSholCompetitonLoaded(
        currentState.competitions,
        player,
        currentState.lv2KataPlayers,
        currentState.lv3KataPlayers,
        currentState.lv4KataPlayers,
        currentState.lv5KataPlayers,
        currentState.kumitePlayers,
        currentState.kataPlayerByCategory));
  }

  List<Player> getLv2KataPlayers() {
    final currentState = state as FedSholCompetitonLoaded;
    return currentState.lv2KataPlayers;
  }

  void setL2List(List<Player> player) {
    final currentState = state as FedSholCompetitonLoaded;
    emit(FedSholCompetitonLoaded(
        currentState.competitions,
        currentState.lv1KataPlayers,
        player,
        currentState.lv3KataPlayers,
        currentState.lv4KataPlayers,
        currentState.lv5KataPlayers,
        currentState.kumitePlayers,
        currentState.kataPlayerByCategory));
  }

  List<Player> getLv3KataPlayers() {
    final currentState = state as FedSholCompetitonLoaded;
    return currentState.lv3KataPlayers;
  }

  void setL3List(List<Player> player) {
    final currentState = state as FedSholCompetitonLoaded;
    emit(FedSholCompetitonLoaded(
        currentState.competitions,
        currentState.lv1KataPlayers,
        currentState.lv2KataPlayers,
        player,
        currentState.lv4KataPlayers,
        currentState.lv5KataPlayers,
        currentState.kumitePlayers,
        currentState.kataPlayerByCategory));
  }

  List<Player> getLv4KataPlayers() {
    final currentState = state as FedSholCompetitonLoaded;
    return currentState.lv4KataPlayers;
  }

  void setL4List(List<Player> player) {
    final currentState = state as FedSholCompetitonLoaded;
    emit(FedSholCompetitonLoaded(
        currentState.competitions,
        currentState.lv1KataPlayers,
        currentState.lv2KataPlayers,
        currentState.lv3KataPlayers,
        player,
        currentState.lv5KataPlayers,
        currentState.kumitePlayers,
        currentState.kataPlayerByCategory));
  }

  List<Player> getLv5KataPlayers() {
    final currentState = state as FedSholCompetitonLoaded;
    return currentState.lv5KataPlayers;
  }

  void setL5List(List<Player> player) {
    final currentState = state as FedSholCompetitonLoaded;
    emit(FedSholCompetitonLoaded(
        currentState.competitions,
        currentState.lv1KataPlayers,
        currentState.lv2KataPlayers,
        currentState.lv3KataPlayers,
        currentState.lv4KataPlayers,
        player,
        currentState.kumitePlayers,
        currentState.kataPlayerByCategory));
  }

  List<Competition> getCompetitions() {
    final currentState = state as FedSholCompetitonLoaded;
    return currentState.competitions;
  }

  //since kumite players has a map no need to go through the if else statements to update the state lists
  void addKumitePlayers(Map<String, List<Player>> kumitePLayers) {
    if (state is FedSholCompetitonLoaded) {
      final currentState = state as FedSholCompetitonLoaded;
      emit(FedSholCompetitonLoaded(
          currentState.competitions,
          currentState.lv1KataPlayers,
          currentState.lv2KataPlayers,
          currentState.lv3KataPlayers,
          currentState.lv4KataPlayers,
          currentState.lv5KataPlayers,
          kumitePLayers,
          currentState.kataPlayerByCategory));
    }
  }

  void addPlayer(Player player) {
    final currentState = state as FedSholCompetitonLoaded;
    if (player.kata) {
      if (player.level == AppConstants.levels[0]) {
        emit(FedSholCompetitonLoaded(
            currentState.competitions,
            [...currentState.lv1KataPlayers, player],
            currentState.lv2KataPlayers,
            currentState.lv3KataPlayers,
            currentState.lv4KataPlayers,
            currentState.lv5KataPlayers,
            currentState.kumitePlayers,
            currentState.kataPlayerByCategory));
        //log("new level 1list : ${currentState.lv1KataPlayers}");
      } else if (player.level == AppConstants.levels[1]) {
        emit(FedSholCompetitonLoaded(
            currentState.competitions,
            currentState.lv1KataPlayers,
            [...currentState.lv2KataPlayers, player],
            currentState.lv3KataPlayers,
            currentState.lv4KataPlayers,
            currentState.lv5KataPlayers,
            currentState.kumitePlayers,
            currentState.kataPlayerByCategory));
        //log("new level 2list : ${currentState.lv2KataPlayers}");
      } else if (player.level == AppConstants.levels[2]) {
        emit(FedSholCompetitonLoaded(
            currentState.competitions,
            currentState.lv1KataPlayers,
            currentState.lv2KataPlayers,
            [...currentState.lv3KataPlayers, player],
            currentState.lv4KataPlayers,
            currentState.lv5KataPlayers,
            currentState.kumitePlayers,
            currentState.kataPlayerByCategory));
        //log("new level 3list : ${currentState.lv3KataPlayers}");
      } else if (player.level == AppConstants.levels[3]) {
        emit(FedSholCompetitonLoaded(
            currentState.competitions,
            currentState.lv1KataPlayers,
            currentState.lv2KataPlayers,
            currentState.lv3KataPlayers,
            [...currentState.lv4KataPlayers, player],
            currentState.lv5KataPlayers,
            currentState.kumitePlayers,
            currentState.kataPlayerByCategory));
        //log("new level 4list : ${currentState.lv4KataPlayers}");
      } else if (player.level == AppConstants.levels[4]) {
        emit(FedSholCompetitonLoaded(
            currentState.competitions,
            currentState.lv1KataPlayers,
            currentState.lv2KataPlayers,
            currentState.lv3KataPlayers,
            currentState.lv4KataPlayers,
            [...currentState.lv5KataPlayers, player],
            currentState.kumitePlayers,
            currentState.kataPlayerByCategory));
        //log("new level 5list : ${currentState.lv5KataPlayers}");
      }
    } else {
      //find the list to update
      String? keyToAdd = competitonService.findWeightCategory(
          currentState.kumitePlayers, player.weight);
      if (keyToAdd != null) {
        final List<Player> updatedList = currentState.kumitePlayers[keyToAdd]!;
        updatedList.add(player);
        currentState.kumitePlayers[keyToAdd] = updatedList;
        emit(FedSholCompetitonLoaded(
            currentState.competitions,
            currentState.lv1KataPlayers,
            currentState.lv2KataPlayers,
            currentState.lv3KataPlayers,
            currentState.lv4KataPlayers,
            currentState.lv5KataPlayers,
            currentState.kumitePlayers,
            currentState.kataPlayerByCategory));
      }
    }
  }

//when updating the payment details need to add the new players in the current competition into the database
  List<Player> getCurrentAllKataPlayers(String competitionType) {
    List<Player> playerList = [];
    final currentState = state as FedSholCompetitonLoaded;
    playerList.addAll(currentState.lv1KataPlayers);
    playerList.addAll(currentState.lv2KataPlayers);
    playerList.addAll(currentState.lv3KataPlayers);
    playerList.addAll(currentState.lv4KataPlayers);
    playerList.addAll(currentState.lv5KataPlayers);
    if (competitionType == KarateConst.MINISTRY) {
      for (var player in currentState.kataPlayerByCategory) {
        playerList.addAll(player);
      }
    }

    return playerList;
  }

  List<Player> allPLayer(String competitionType) {
    List<Player> allPLayers = [];
    allPLayers.addAll(getCurrentAllKataPlayers(competitionType));
    final currentState = state as FedSholCompetitonLoaded;
    currentState.kumitePlayers.forEach((key, value) {
      allPLayers.addAll(value);
    });
    return allPLayers;
  }

  List<List<Player>> sortKataPlayerInCategories(List<Player> playerList) {
    final currentState = state as FedSholCompetitonLoaded;
    List<List<Player>> kataPlayerByCategory = [[], [], [], []];

    for (var i in playerList) {
      if (i.competeCategory == AppConstants.catagories[0]) {
        kataPlayerByCategory[0].add(i);
      } else if (i.competeCategory == AppConstants.catagories[1]) {
        kataPlayerByCategory[1].add(i);
      } else if (i.competeCategory == AppConstants.catagories[2]) {
        kataPlayerByCategory[2].add(i);
      } else if (i.competeCategory == AppConstants.catagories[3]) {
        kataPlayerByCategory[3].add(i);
      }
    }

    log("kata players by category : $kataPlayerByCategory");
    emit(FedSholCompetitonLoaded(
        currentState.competitions,
        currentState.lv1KataPlayers,
        currentState.lv2KataPlayers,
        currentState.lv3KataPlayers,
        currentState.lv4KataPlayers,
        currentState.lv5KataPlayers,
        currentState.kumitePlayers,
        kataPlayerByCategory));

    return kataPlayerByCategory;
  }
}
