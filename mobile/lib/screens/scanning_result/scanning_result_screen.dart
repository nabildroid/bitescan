import 'package:bitescan/cubits/data/data_cubit.dart';
import 'package:bitescan/cubits/data/data_state.dart';
import 'package:bitescan/cubits/onboarding/onboarding_cubit.dart';
import 'package:bitescan/cubits/scanning/scanning_cubit.dart';
import 'package:bitescan/main.dart';
import 'package:bitescan/models/food.dart';
import 'package:bitescan/models/goal.dart';
import 'package:bitescan/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'widgets/food_view.dart';

class ScanningResultScreen extends StatefulWidget {
  final String code;
  const ScanningResultScreen({required this.code, super.key});

  @override
  State<ScanningResultScreen> createState() => _ScanningResultScreenState();
}

class _ScanningResultScreenState extends State<ScanningResultScreen> {
  bool loading = true;

  final viewedSubject = BehaviorSubject<Food>();

  final PageController pageController = PageController();
  Food? product;

  Goal? goal;

  List<Food> get foods {
    return context.read<DataCubit>().state.foods;
  }

  List<Food> get similar {
    final result = foods.where((f) => f.category == product?.category).toList();
    result.sort((a, b) {
      if (goal == null) return 0;
      final values = result.map((e) => Goal.rank(e, goal!)).toList();
      final sa = smoothValue(values, Goal.rank(a, goal!));
      final sb = smoothValue(values, Goal.rank(b, goal!));

      return (-sa + sb).round();
    });

    return result;
  }

  @override
  void initState() {
    super.initState();

    context.read<ScanningCubit>().dispatchScannedFood(widget.code);
    prepareTargetFood();

    viewedSubject.debounceTime(Duration(seconds: 3)).listen((data) {
      if (!mounted) return;

      context.read<ScanningCubit>().dispatchViewedFood(data.code);
    });

    pageController.addListener(() {
      final page = pageController.page?.round() ?? 0;
      if (page == 0) return;

      viewedSubject.add(similar[page - 1]);
    });
  }

  void prepareTargetFood() {
    void onChange() {
      late final Food target;
      try {
        target = foods.firstWhere((result) => result.code == widget.code);
        product = target;

        setState(() {
          loading = false;
          goal = context.read<OnboardingCubit>().state.initalGoal;
        });
      } catch (e) {}
    }

    MergeStream([
      context.read<OnboardingCubit>().stream,
      context.read<DataCubit>().stream,
    ]).listen((event) => onChange());

    onChange();

    Future.delayed(Duration(seconds: 2)).then((_) {
      if (product == null && mounted) {
        Navigator.of(context).pop();
        return;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    viewedSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, //Colors.grey.shade100,
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              color: loading ? Colors.transparent : Colors.white,
            ),
          ),
          Positioned.fill(
            child: PageView(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              children: [
                FoodView(
                  pageController: pageController,
                  loading: loading,
                  similar: similar,
                  food: product,
                  goal: goal,
                ),
                ...similar
                    .map((similarFood) => FoodView(
                          pageController: pageController,
                          loading: loading,
                          similar: similar,
                          goal: goal,
                          food: similarFood,
                        ))
                    .toList()
              ],
            ),
          ),
          if (!loading)
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      pageController.previousPage(
                          duration: Duration(milliseconds: 850),
                          curve: Curves.decelerate);
                    },
                    icon: Icon(Icons.chevron_left_rounded),
                    color: Colors.white38,
                  ),
                  IconButton(
                    onPressed: () {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 850),
                          curve: Curves.decelerate);
                    },
                    icon: Icon(Icons.chevron_right_rounded),
                    color: Colors.white38,
                  ),
                ],
              ),
            ),
          if (loading)
            Center(
              child: CircularProgressIndicator(
                color: Colors.greenAccent,
              ),
            ),
        ],
      ),

      floatingActionButton: loading
          ? SizedBox.shrink()
          : FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.document_scanner_outlined),
            ),
    );
  }
}
