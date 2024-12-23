import 'package:bitescan/extentions/translated_data.dart';
import 'package:bitescan/main.dart';
import 'package:bitescan/models/food.dart';
import 'package:bitescan/models/goal.dart';
import 'package:bitescan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'food_evaluation_details.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        ? const Color(0xffFF595E)
        : score < 70
            ? const Color(0xffFFCA3A)
            : const Color(0xff8AC926);

    final feedback = (score < 20
            ? AppLocalizations.of(context)!.resut_bad_for
            : score < 70
                ? AppLocalizations.of(context)!.resut_ok_for
                : AppLocalizations.of(context)!.resut_good_for) +
        (isRTL(context) ? "" : " ") +
        (goal?.translateName(context) ?? "Health");

    return Column(
      children: [
        Flexible(
          flex: 8,
          child: AnimatedSlide(
            duration: Duration(seconds: 1),
            curve: Curves.easeOutCirc,
            offset: loading ? Offset(0, -1) : Offset(0, 0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(12)),
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade700,
                    Colors.grey.shade800,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black26,
                    width: 2,
                  ),
                ),
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
                        food?.translateName(context) ?? "Product Name",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      Spacer(),
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: score > 50
                            ? Color.fromARGB(129, 64, 185, 104)
                            : Color.fromARGB(129, 207, 72, 72),
                        padding: EdgeInsets.zero,
                        label: Text(
                            "${score.round().toString().padLeft(2, "0")}%",
                            style: GoogleFonts.silkscreen(
                                color: score > 50
                                    ? Color.fromARGB(255, 14, 46, 16)
                                    : Color.fromARGB(255, 46, 14, 14))),
                        avatar: Icon(
                            score > 50 ? Icons.upload : Icons.download_rounded,
                            color: score > 50
                                ? const Color.fromARGB(255, 14, 46, 16)
                                : const Color.fromARGB(255, 46, 14, 14)),
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
                                feedback,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      BoxShadow(
                                        blurRadius: 6,
                                        spreadRadius: 3,
                                        color: Colors.black87,
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
                    AppLocalizations.of(context)!.resut_other_alternatives,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black87),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (_, i) {
                      final food = similar[i];

                      return ListTile(
                        onTap: () {
                          pageController.animateToPage(i + 1,
                              curve: Curves.easeInExpo,
                              duration: Duration(milliseconds: 500));
                        },
                        trailing: IconButton(
                          onPressed: () {
                            pageController.animateToPage(i + 1,
                                curve: Curves.easeInExpo,
                                duration: Duration(milliseconds: 500));
                          },
                          icon: Icon(Icons.chevron_right_rounded),
                        ),
                        leading: Container(
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: 40,
                          height: 40,
                          padding: EdgeInsets.all(8),
                          child: Image.network(food.image),
                        ),
                        title: Text(
                          food.translateName(context),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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
