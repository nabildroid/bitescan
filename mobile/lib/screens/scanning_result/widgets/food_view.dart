import 'package:bitescan/main.dart';
import 'package:bitescan/models/food.dart';
import 'package:bitescan/models/goal.dart';
import 'package:bitescan/utils/utils.dart';
import 'package:flutter/material.dart';

import 'scanning_results_widgets.dart';

class FoodView extends StatelessWidget {
  final Food? food;
  final List<Food> similar;
  final bool loading;
  final Goal? goal;
  final PageController pageController;
  const FoodView({
    super.key,
    this.food,
    this.goal,
    required this.similar,
    required this.loading,
    required this.pageController,
  });

  int getScore(Food evaluatedFood) {
    if (goal == null || food == null) return 0;
    return smoothValue(
      similar.map((e) => Goal.rank(e, goal!)).toList(),
      Goal.rank(evaluatedFood, goal!),
    ).round();
  }

  @override
  Widget build(BuildContext context) {
    double score = 120;
    if (food != null && goal != null) {
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
                                "${score < 20 ? "Bad" : score < 70 ? "Ok" : "Good"} For ${goal?.name}",
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
