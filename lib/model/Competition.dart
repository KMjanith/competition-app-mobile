import 'Player.dart';

class Competition {
  final DateTime date;
  final String place;
  final String userId;
  final String name;
  final String type;
  List<Player> player;

  Competition({required this.player, required this.date, required this.place, required this.type, required this.userId, required this.name});
}
