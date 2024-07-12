class Player {
  final String name;
  final String birthCertificateNumber;
  final String level;
  final String competeCategory;
  final bool kata;
  final bool kumite;
  final bool teamKata;
  final int weight;

  Player({
    required this.name,
    required this.birthCertificateNumber,
    required this.level,
    required this.competeCategory,
    required this.kata,
    required this.kumite,
    required this.teamKata,
    required this.weight,
  });
}
