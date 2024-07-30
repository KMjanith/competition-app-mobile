class Scoreboard {
  final String akaPlayerName;
  final String awoPLayerName;
  final String timeDuration;
  final List<int> akaPlayerPoints;
  final List<int> awoPlayerPoints;
  final String winner;
  final List<String> akaPenalties;
  final List<String> awoPenalties;
  final String firstPoint;

  Scoreboard(
      {required this.akaPlayerName,
      required this.firstPoint,
      required this.awoPLayerName,
      required this.timeDuration,
      required this.akaPlayerPoints,
      required this.awoPlayerPoints,
      required this.winner,
      required this.akaPenalties, required this.awoPenalties, 
      });
}
