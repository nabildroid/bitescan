import 'dart:async';
import 'dart:math';

import 'package:bitescan/config/locator.dart';
import 'package:bitescan/config/paths.dart';
import 'package:bitescan/cubits/data/data_cubit.dart';
import 'package:bitescan/cubits/onboarding/onboarding_cubit.dart';
import 'package:bitescan/cubits/onboarding/onboarding_state.dart';
import 'package:bitescan/cubits/system_config/system_config_cubit.dart';
import 'package:bitescan/models/goal.dart';
import 'package:bitescan/screens/home/widgets/goal_detail_sheet.dart';
import 'package:bitescan/screens/home/widgets/progress_chart.dart';
import 'package:bitescan/screens/home/widgets/sessionsConfirmationButton.dart';
import 'package:bitescan/screens/shopping_confirmation/shopping_confirmation_screen.dart';
import 'package:bitescan/services/local_notification_service.dart';
import 'package:bitescan/utils/utils.dart';
import 'package:bitescan/widgets/intelligent_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  final bool firstTime;
  const HomeScreen({super.key, this.firstTime = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final goalsKey = GlobalKey();

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

          locator.get<LocalNotificationService>().requestPermission();
          // // todo, make name request later on secon app use, first time it's only notification that is requested!
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
    return Builder(builder: (context) {
      return Stack(
        children: [
          Container(
            color: Color.alphaBlend(
                const Color(0xff8D4DB1).withOpacity(0.09), Colors.white),
            child: Align(
              alignment: isRTL(context)
                  ? Alignment(-1.05, -0.75)
                  : Alignment(1.05, -0.75),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 35,
                      spreadRadius: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              titleSpacing: 0,
              leading: Center(
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey.shade500,
                ),
              ),
              title: GestureDetector(
                onTap: () {
                  context.read<SystemConfigCubit>().toggleLanguage(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.title,
                  style: isRTL(context)
                      ? GoogleFonts.reemKufi()
                      : GoogleFonts.kameron(),
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.home_qoat,
                      textAlign: TextAlign.center,
                      style: isRTL(context)
                          ? GoogleFonts.harmattan(
                              color: Colors.grey.shade400,
                              fontSize: 28,
                              height: 1,
                              fontWeight: FontWeight.w600,
                            )
                          : GoogleFonts.itim(
                              color: Colors.grey.shade500,
                              fontSize: 23,
                              height: 1.2,
                              fontWeight: FontWeight.w500,
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.home_progress_label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: ProgressChart(),
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(
                        color: Colors.black12,
                        width: 2,
                      ))),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.home_goal_label,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: GoalsPageView(
                                setGoalIsOpen: (val) => setState(() {
                                  visibleGoalDetails = val;
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: isRTL(context)
                            ? Alignment(0.95, -0.65)
                            : Alignment(-0.95, -0.65),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 60,
                                spreadRadius: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton: !visibleGoalDetails
                ? FloatingActionButton.extended(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      context.push(Paths.scan.landing);
                    },
                    label: Text(AppLocalizations.of(context)!.home_cta),
                    icon: Icon(Icons.document_scanner_outlined),
                  )
                : null,
          ),
        ],
      );
    });
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

      if (onboarding.state.goal != null) {
        final index = goals.indexWhere((g) => g == onboarding.state.goal);

        Future.delayed(Duration(milliseconds: 450)).then((_) {
          controller.animateToPage(index,
              curve: Curves.easeInOut,
              duration: Duration(
                milliseconds: 450,
              ));

          setState(() {});
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
                opacity: min(1, val + 0.3),
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
                                    .withOpacity(0.2),
                                blurRadius: 11,
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
                                  backgroundColor: Colors.transparent,
                                )
                                .closed;
                            setState(() {
                              widget.setGoalIsOpen(false);
                            });
                          },
                          child: IntelligentImage(item.picture),
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
