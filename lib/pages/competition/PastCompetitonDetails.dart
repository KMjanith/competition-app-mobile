import 'package:competition_app/model/Competition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Constants/StyleConstants.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/competition/PastCompetitonDetailsTile.dart';
import '../../cubit/db_cubit.dart';
import '../../cubit/fed_shol_competiton_cubit.dart';
import '../../services/CompetitionService.dart';

class PastCompetitionDetails extends StatefulWidget {
  final Competition competiton;
  const PastCompetitionDetails({super.key, required this.competiton});

  @override
  State<PastCompetitionDetails> createState() => _PastCompetitionDetailsState();
}

class _PastCompetitionDetailsState extends State<PastCompetitionDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          StyleConstants.lowerBackgroundContainer,
          Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu,
                          color: Color.fromARGB(255, 250, 250, 250)),
                    ),
                  ),
                ],
              ),
              const HeadingAnimation(heading: "Players"),
              const Text(
                "All Player Details are Here",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: widget.competiton.player.length,
                      itemBuilder: (context, index) {
                        return PastCompetitonDetailsTile(
                            player: widget.competiton.player[index]);
                      }))
            ],
          )
        ],
      ),
    );
  }

  void doNothing(BuildContext context, String competitionId, int index,
      List<Competition> currentList) async {
    final competitionService = CompetitionService();

    final db = BlocProvider.of<DbCubit>(context).firestore;
    String result = await competitionService.deleteCompetiton(
        competitionId, db); // Await deletion
    if (result == "Success") {
      //update the state
      BlocProvider.of<FedSholCompetitionCubit>(context)
          .deleteCompetiton(index, currentList);

      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 18, 189, 2),
        content: Text(
          "Successfully deleted the competition with ID: $competitionId",
          style: const TextStyle(fontSize: 20),
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 189, 2, 2),
        content: Text(
          "Error deleting competiton: ${result.toString()}",
          style: const TextStyle(fontSize: 20),
        ),
      ));
    }
  }

  Row textBuilder(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: const TextStyle(fontSize: 19),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
