import 'package:competition_app/Constants/StyleConstants.dart';
import 'package:competition_app/pages/competition/Custom.dart';
import 'package:competition_app/pages/competition/Ministry.dart';
import 'package:competition_app/pages/competition/SchoolAndFederation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/competition/SelectCompetition.dart';

class MakeCompetition extends StatelessWidget {
  const MakeCompetition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          StyleConstants.lowerBackgroundContainer,
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: const Icon(Icons.menu,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ],
                ),
                const HeadingAnimation(heading: "Make Competition"),
                const Text("You can select and make a competition here",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(48, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10)),
                    child:const  Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                               SelectCompetition(
                                pageToNavigate: SchoolAndFederation(
                                    type: "Federation",
                                    headingTitle: "National Federation Meet"),
                                competitionName: "National Federation Meet",
                                color: Colors.red,
                              ),
                              SelectCompetition(
                                pageToNavigate: SchoolAndFederation(
                                  type: "School",
                                  headingTitle: "National School Meet",
                                ),
                                competitionName: "National School Meet",
                                color: Colors.green,
                              ),
                            ],
                          ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SelectCompetition(
                                pageToNavigate: CustomMeet(
                                  headingTitle: "Custom Meet",
                                ),
                                competitionName: "Wado Meet",
                                color: Colors.blue,
                              ),
                              SelectCompetition(
                                pageToNavigate: Ministry(
                                  headingTitle: "Ministry Meet",
                                ),
                                competitionName: "Ministry Meet",
                                color: Color.fromARGB(255, 255, 59, 229),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("view past competitions analytics here",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                const Image(
                    image: AssetImage("assets/images/graph.png"),
                    height: 200,
                    width: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
