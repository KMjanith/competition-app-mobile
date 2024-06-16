import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../model/Grading.dart';
import 'db_cubit.dart';

part 'recentgradings_state.dart';

class RecentgradingsCubit extends Cubit<List<Grading>> {
  RecentgradingsCubit() : super([]);

  void loadData(BuildContext context) async {
  var db = BlocProvider.of<DbCubit>(context).firestore;

  QuerySnapshot querySnapshot = await db.collection('Gradings').get();
  print("data ${querySnapshot.docs[0]['date']}");
  for (var doc in querySnapshot.docs) {
    var grading = Grading(
      gradingPlace: doc['place'],
      gradingTime:(doc['date']), // Parse the String to DateTime
    );
    emit([...state, grading]);
  }
}

  void addGrading(Grading grading, BuildContext context) {
    emit([...state, grading]);
  }
}
