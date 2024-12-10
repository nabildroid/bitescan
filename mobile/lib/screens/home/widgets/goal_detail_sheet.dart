import 'package:bitescan/models/goal.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class GoalDetailSheet extends StatelessWidget {
  final Goal goal;
  const GoalDetailSheet({
    super.key,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0).copyWith(
              top: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      goal.picture,
                      width: MediaQuery.of(context).size.width * .6,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: GoalHighlight(
                              icon: Icons.golf_course_sharp,
                              label: "Category",
                              value: goal.category,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: GoalHighlight(
                              icon: Icons.timer,
                              label: "Duration",
                              value: goal.duration,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: GoalHighlight(
                              icon: Icons.star,
                              label: "Rating",
                              value: goal.rating,
                            )),
                      ]),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  goal.longName,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Divider(
                  height: 20,
                  color: Colors.white12,
                ),
                Text(
                  goal.description,
                  style: TextStyle(color: Colors.white60, height: 2),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: ValueListenableBuilder(
            valueListenable: Storage.goalId,
            builder: (context, val, _) {
              if (val == goal.id) return SizedBox.shrink();
              return FloatingActionButton.extended(
                onPressed: () {
                  Storage.goalId.value = goal.id;
                  Storage.goal.value = goal;
                  Navigator.of(context).pop();
                },
                label: Text("Let's Start"),
                icon: Icon(Icons.lens_outlined),
              );
            }));
  }
}

class GoalHighlight extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const GoalHighlight({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.1,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Container(
                width: 80,
                height: 40,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.7,
                    colors: [
                      Colors.white24,
                      Colors.white10,
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              label,
              style:
                  TextStyle(fontSize: 12, height: 0.6, color: Colors.white60),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                height: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
