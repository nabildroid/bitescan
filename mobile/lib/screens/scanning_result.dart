import 'dart:math';

import 'package:bitescan/main.dart';
import 'package:bitescan/models/food.dart';
import 'package:bitescan/models/goal.dart';
import 'package:bitescan/screens/home_screen.dart';
import 'package:bitescan/utils/utils.dart';
import 'package:bitescan/widgets/scanning_results_widgets.dart';
import 'package:flutter/material.dart';

class ScanningResult extends StatefulWidget {
  final String code;
  const ScanningResult({required this.code, super.key});

  @override
  State<ScanningResult> createState() => _ScanningResultState();
}

class _ScanningResultState extends State<ScanningResult> {
  bool loading = true;

  final PageController pageController = PageController();
  Food? product;

  List<Food> get similar {
    final result =
        foodDB.where((f) => f.category == product?.category).toList();
    result.sort((a, b) {
      if (Storage.goal.value == null) return 0;
      final values =
          result.map((e) => Goal.rank(e, Storage.goal.value!)).toList();
      final sa = smoothValue(values, Goal.rank(a, Storage.goal.value!));
      final sb = smoothValue(values, Goal.rank(b, Storage.goal.value!));

      return (-sa + sb).round();
    });

    return result;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((_) {
      late final Food target;
      try {
        target = foodDB.firstWhere((result) => result.code == widget.code);
      } catch (e) {
        if (mounted) {
          Navigator.of(context).pop();
        }
      }

      setState(() {
        loading = false;
        product = target;
      });
    });
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
                ),
                ...similar
                    .map((similarFood) => FoodView(
                          pageController: pageController,
                          loading: loading,
                          similar: similar,
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

class FoodView extends StatelessWidget {
  final Food? food;
  final List<Food> similar;
  final bool loading;
  final PageController pageController;
  const FoodView({
    super.key,
    this.food,
    required this.similar,
    required this.loading,
    required this.pageController,
  });

  int getScore(Food evaluatedFood) {
    if (Storage.goal.value == null || food == null) return 0;
    return smoothValue(
      similar.map((e) => Goal.rank(e, Storage.goal.value!)).toList(),
      Goal.rank(evaluatedFood, Storage.goal.value!),
    ).round();
  }

  @override
  Widget build(BuildContext context) {
    double score = 120;
    if (food != null && Storage.goal.value != null) {
      score = getScore(food!) + 0.0;
    }

    final feedbackColor = score < 20
        ? const Color(0xffA30015)
        : score < 70
            ? const Color(0xffEE964B)
            : const Color(0xff009B72);

    return Column(
      children: [
        Flexible(
          key: ValueKey("top"),
          flex: 8,
          child: AnimatedSlide(
            duration: Duration(seconds: 1),
            curve: Curves.easeOutCirc,
            offset: loading ? Offset(0, -1) : Offset(0, 0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(25)),
                color: Theme.of(context).primaryColor,
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).viewPadding.top,
                  ),
                  Row(
                    children: [
                      Text(
                        food?.name ?? "Product Name",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      Spacer(),
                      Chip(
                        backgroundColor: Color(0xffAFE3C0),
                        label: Text("${score.round()} points",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 14, 46, 16))),
                        avatar: Icon(Icons.upload,
                            color: const Color.fromARGB(255, 14, 46, 16)),
                      )
                    ],
                  ),
                  SizedBox(height: 12),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: Column(
                        children: [
                          LayoutBuilder(
                              builder: (_, constraints) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                        3,
                                        (i) => Container(
                                              width: constraints.maxWidth * .3,
                                              color: Colors.white12,
                                              padding: EdgeInsets.all(2),
                                              child: AspectRatio(
                                                aspectRatio: 1,
                                                child: food?.image != null
                                                    ? Image.network(
                                                        food!.image,
                                                      )
                                                    : SizedBox.expand(),
                                              ),
                                            )),
                                  )),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 25),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                feedbackColor.withOpacity(.45),
                                feedbackColor,
                                feedbackColor.withOpacity(.45),
                                Colors.transparent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )),
                            child: FittedBox(
                              child: Text(
                                "${score < 20 ? "Bad" : score < 70 ? "Ok" : "Good"} For ${Storage.goal.value?.name}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      BoxShadow(
                                        blurRadius: 12,
                                        spreadRadius: 2,
                                        color: Colors.black45,
                                      )
                                    ]),
                              ),
                            ),
                          ),
                          if (food != null)
                            FoodEvaluationDetails(
                              food: food!,
                            ),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
        Flexible(
          key: ValueKey("Bottom"),
          flex: 6,
          child: AnimatedSlide(
            duration: Duration(milliseconds: 850),
            offset: loading ? Offset(0, 1) : Offset(0, 0),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Text(
                    "Other Alternatives",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (_, i) {
                      final food = similar[i];

                      return ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            pageController.animateToPage(i + 1,
                                curve: Curves.easeInExpo,
                                duration: Duration(milliseconds: 500));
                          },
                          icon: Icon(Icons.input_outlined),
                        ),
                        leading: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: 40,
                          height: 40,
                          padding: EdgeInsets.all(8),
                          child: Image.network(food.image),
                        ),
                        title: Text(food.name),
                        subtitle: Text(getScore(food).toString()),
                        visualDensity: VisualDensity.compact,
                      );
                    },
                    itemCount: similar.length,
                  ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
