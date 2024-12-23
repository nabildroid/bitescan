import 'dart:ui';

import 'package:bitescan/cubits/onboarding/onboarding_cubit.dart';
import 'package:bitescan/extentions/translated_data.dart';
import 'package:bitescan/models/goal.dart';
import 'package:bitescan/screens/scanning_result/widgets/food_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalDetailSheet extends StatefulWidget {
  final Goal goal;

  GoalDetailSheet({
    super.key,
    required this.goal,
  });

  @override
  State<GoalDetailSheet> createState() => _GoalDetailSheetState();
}

class _GoalDetailSheetState extends State<GoalDetailSheet> {
  final background = ValueNotifier(Colors.grey.shade900.withOpacity(0.9));

  @override
  void initState() {
    ColorScheme.fromImageProvider(provider: AssetImage(widget.goal.picture))
        .then((v) {
      background.value =
          Color.alphaBlend(Colors.black54, v.secondary).withOpacity(0.86);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isSelected =
        context.watch<OnboardingCubit>().state.goal == widget.goal;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(),
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: ValueListenableBuilder(
                      valueListenable: background,
                      builder: (context, color, child) {
                        return Container(
                          color: color,
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(
                    top: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withOpacity(1),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Image.asset(
                              widget.goal.picture,
                              width: MediaQuery.of(context).size.width * .6,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: GoalHighlight(
                                        icon: Icons.golf_course_sharp,
                                        label: "Category",
                                        value: widget.goal
                                            .translateCategory(context),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: GoalHighlight(
                                        icon: Icons.timer,
                                        label: "Duration",
                                        value: widget.goal.duration,
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: GoalHighlight(
                                        icon: Icons.star,
                                        label: "Rating",
                                        value: widget.goal.rating,
                                      )),
                                ]),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        widget.goal.translateLongName(context),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Colors.white,
                            ),
                      ),
                      Divider(
                        height: 20,
                        color: Colors.white12,
                      ),
                      Text(
                        widget.goal.translateDescription(context),
                        style: TextStyle(color: Colors.white70, height: 2),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: !isSelected
            ? FloatingActionButton.extended(
                onPressed: () {
                  HapticFeedback.selectionClick();
                  context.read<OnboardingCubit>().setGoal(widget.goal);
                  Navigator.of(context).pop();
                },
                label: Text("Let's Start"),
                icon: Icon(Icons.lens_outlined),
              )
            : null);
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
                  TextStyle(fontSize: 12, height: 0.6, color: Colors.white38),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                height: 0.6,
                color: Colors.white60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
