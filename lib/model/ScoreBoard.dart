class ScoreboardDetails {
  String id;
  String akaPlayerName;
  String awoPLayerName;
  String timeDuration;
  List<int> akaPlayerPoints;
  List<int> awoPlayerPoints;
  String winner;
  List<int> akaPenalties;
  List<int> awoPenalties;
  String firstPoint;
  String date;

  ScoreboardDetails({
    required this.id,
    required this.akaPlayerName,
    required this.firstPoint,
    required this.awoPLayerName,
    required this.timeDuration,
    required this.akaPlayerPoints,
    required this.awoPlayerPoints,
    required this.winner,
    required this.akaPenalties,
    required this.awoPenalties,
    required this.date,
  });
}
