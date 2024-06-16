import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DbCubit extends Cubit<FirebaseFirestore> {
  DbCubit() : super(FirebaseFirestore.instance);

  FirebaseFirestore get firestore => state;
}
