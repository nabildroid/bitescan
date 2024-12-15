import 'dart:async';

import 'package:bitescan/config/paths.dart';
import 'package:bitescan/cubits/data/data_cubit.dart';
import 'package:bitescan/cubits/onboarding/onboarding_cubit.dart';
import 'package:bitescan/cubits/onboarding/onboarding_state.dart';
import 'package:bitescan/models/goal.dart';
import 'package:bitescan/screens/home/widgets/goal_detail_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreen extends StatefulWidget {
  final bool firstTime;
  const HomeScreen({super.key, this.firstTime = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = PageController(
    viewportFraction: .5,
  );

  @override
  void initState() {
    if (widget.firstTime) {
      Future.delayed(Duration(milliseconds: 500)).then((_) {
        if (mounted == false) return;

        context
            .push(Paths.scan.landing)
            .then((_) => Future.delayed(Duration(seconds: 3)))
            .then((_) {
          if (mounted == false) return;
          // Navigator.of(context).push(
          //   DialogRoute(context: context, builder: (_) => NameDialog()),
          // );
        });
      });
    }

    super.initState();
  }

  bool visibleGoalDetails = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 247, 229, 153),
        ).copyWith(
          onSurface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 16, 24, 27),
      ),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            titleTextStyle: TextStyle(
              color: Colors.white,
            ),
            backgroundColor: Colors.transparent,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Walcome Nabil Lakrib",
                ),
                BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                  if (state.initalGoal == null) {
                    return Text("Let's make food better");
                  } else {
                    return Text("Let's work on ${state.initalGoal!.name}");
                  }
                }),
              ],
            ),
            actions: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage("https://github.com/nabildroid.png"),
              ),
              SizedBox(width: 8),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 32,
                    ),
                    fillColor: Color.fromARGB(255, 30, 44, 49),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text("Category"),
                    Spacer(),
                    Text(
                      "See All",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.all(8),
                child: LayoutBuilder(
                    builder: (_, constraints) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: ["water", "cake", "meat", "fridge"]
                              .map((item) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: constraints.maxWidth * 0.19,
                                        height: constraints.maxWidth * 0.19,
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 30, 44, 49),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                              "assets/categories/" +
                                                  item +
                                                  ".png"),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      FittedBox(child: Text(item))
                                    ],
                                  ))
                              .toList(),
                        )),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Your Goal"),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GoalsPageView(
                        setGoalIsOpen: (val) => setState(() {
                              visibleGoalDetails = val;
                            }))),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          floatingActionButton: !visibleGoalDetails
              ? FloatingActionButton.extended(
                  onPressed: () {
                    context.push(Paths.scan.landing);
                  },
                  label: Text("Scan the Food"),
                  icon: Icon(Icons.document_scanner_outlined),
                )
              : null,
        );
      }),
    );
  }
}

class GoalsPageView extends StatefulWidget {
  final Function(bool val) setGoalIsOpen;
  const GoalsPageView({super.key, required this.setGoalIsOpen});

  @override
  State<GoalsPageView> createState() => _GoalsPageViewState();
}

class _GoalsPageViewState extends State<GoalsPageView> {
  final controller = PageController(
    viewportFraction: .5,
  );

  StreamSubscription? _sub;

  List<Goal> goals = [];

  @override
  void initState() {
    super.initState();

    listenForGoals();
  }

  void listenForGoals() {
    void onChange() {
      final onboarding = context.read<OnboardingCubit>();
      final data = context.read<DataCubit>().state;
      goals = onboarding.getSuggestion(data.goals);
      setState(() {});

      if (onboarding.state.initalGoal != null) {
        final index = goals.indexWhere((g) => g == onboarding.state.initalGoal);

        Future.delayed(Duration(milliseconds: 450)).then((_) {
          controller.animateToPage(index,
              curve: Curves.easeInOut,
              duration: Duration(
                milliseconds: 450,
              ));
        });
      }
    }

    _sub = MergeStream([
      context.read<OnboardingCubit>().stream,
      context.read<DataCubit>().stream,
    ]).listen((event) => onChange());

    onChange();
  }

  @override
  void dispose() {
    _sub?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: List.generate(
        goals.length,
        (i) => AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final item = goals[i % goals.length];
              final indice = i -
                  (controller.position.haveDimensions
                          ? controller.page!
                          : goals.length / 2 + 0.1)
                      .clamp(i - 0.5, i + 0.5);
              final val = 1 - indice.abs();

              return Opacity(
                opacity: val,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: AspectRatio(
                    aspectRatio: 5.5 / 7,
                    child: AnimatedContainer(
                      key: ValueKey(i),
                      duration: Duration(milliseconds: 250),
                      transformAlignment: Alignment.center,
                      transform: Transform.rotate(
                            angle: val < 0.8 ? (indice < 0 ? -1 : 1) * 0.08 : 0,
                          ).transform *
                          Transform.scale(
                            scale: val < 0.8 ? 0.9 : 1,
                          ).transform,
                      child: Container(
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          boxShadow: [
                            if (val > 0.5)
                              BoxShadow(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.3),
                                blurRadius: 12,
                                spreadRadius: 5,
                              ),
                          ],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: InkWell(
                          onTap: () async {
                            widget.setGoalIsOpen(true);

                            await Scaffold.of(context)
                                .showBottomSheet(
                                  (_) => GoalDetailSheet(
                                    goal: item,
                                  ),
                                  elevation: 8,
                                  backgroundColor:
                                      Color.fromARGB(255, 32, 48, 54),
                                )
                                .closed;
                            setState(() {
                              widget.setGoalIsOpen(false);
                            });
                          },
                          child: Image.asset(item.picture),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
