import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Constants/StyleConstants.dart';
import '../../blocs/cubit/recentgradings_cubit.dart';
import '../../components/common/HedingAnimation.dart';
import '../../model/Grading.dart';

class Pastgradings extends StatefulWidget {
  const Pastgradings({super.key});

  @override
  State<Pastgradings> createState() => _PastgradingsState();
}

class _PastgradingsState extends State<Pastgradings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: StyleConstants.pageBackground,
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
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ],
            ),
            const HeadingAnimation(heading: "Past Gradings"),
            const Text(
              "click one to see the details",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              height: 400,
              child: BlocBuilder<RecentgradingsCubit, List<Grading>>(
                builder: (context, state) {
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        var today = DateTime.now();
                        var gradingDate =
                            DateTime.parse(state[index].gradingTime);
                        print(
                            "today - ${today} gradigDate - ${gradingDate} index - ${index}");
                        if (gradingDate.isBefore(today)) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: StyleConstants.cardBackGround,
                                  borderRadius: BorderRadius.circular(16)),
                              height: 75,
                              child: ListTile(
                                onTap: () {},
                                trailing: Icon(Icons.menu),
                                leading: Icon(Icons.account_tree_rounded),
                                title: Text(
                                  state[index].gradingPlace,
                                  style: TextStyle(fontSize: 20),
                                ),
                                subtitle: Text(state[index].gradingTime),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
