import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../services/ViewStudent.dart';

part 'view_data_event.dart';
part 'view_data_state.dart';

class ViewDataBloc extends Bloc<ViewDataEvent, ViewDataState> {
  final Viewstudent viewstudent;

  ViewDataBloc(this.viewstudent) : super(ViewDataInitial()) {
    on<viewIntialData>((event, emit) async {
      emit(ViewDataLoading());

      try {
        await viewstudent.getCollection();
        emit(ViewDataLoaded(viewstudent.students));
      } catch (e) {}
      Viewstudent viewStudent = Viewstudent();
      List<Map<String, dynamic>> students = viewStudent.students;
      print(students);
    });
  }
}
