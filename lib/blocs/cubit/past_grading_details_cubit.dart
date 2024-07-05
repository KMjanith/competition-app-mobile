import 'package:bloc/bloc.dart';
import 'package:competition_app/model/GradingStudentDetals.dart';
import 'package:meta/meta.dart';

part 'past_grading_details_state.dart';

class PastGradingDetailsCubit extends Cubit<PastGradingDetailsState> {
  PastGradingDetailsCubit() : super(PastGradingDetailsInitial());

  void loadData(List<Gradingstudentdetails> gradingStudentDetails) {
    emit(PastGradingDetailsLoaded(gradingStudentDetails));
  }

  
}

