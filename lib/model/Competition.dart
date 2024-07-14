import 'Player.dart';

class Competition {
  final String id;
  final DateTime date;
  final String place;
  final String userId;
  final String name;
  final String type;
  final String weights;
  List<Player> player;

  Competition(
      {required this.id,
      required this.player,
      required this.date,
      required this.place,
      required this.type,
      required this.userId,
      required this.weights,
      required this.name});
}
