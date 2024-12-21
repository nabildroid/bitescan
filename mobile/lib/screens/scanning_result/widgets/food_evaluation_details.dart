import 'dart:math';

import 'package:bitescan/extentions/food_values.dart';
import 'package:bitescan/models/food.dart';
import 'package:bitescan/utils/utils.dart';
import 'package:flutter/material.dart';

class FoodEvaluationDetails extends StatefulWidget {
  final Food food;
  const FoodEvaluationDetails({super.key, required this.food});

  @override
  State<FoodEvaluationDetails> createState() => _FoodEvaluationDetailsState();
}

class _FoodEvaluationDetailsState extends State<FoodEvaluationDetails>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
            controller: tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            dividerHeight: 0,
            indicatorPadding: EdgeInsets.all(0),
            indicator: CircleTabIndicator(
              color: Colors.white,
              radius: 3,
            ),
            tabs: const [
              Tab(
                text: "Nutrition",
                height: 40,
              ),
              Tab(
                text: "Calories",
                height: 40,
              ),
              Tab(
                text: "Score",
                height: 40,
              ),
            ]),
        ConstrainedBox(
          constraints: BoxConstraints.expand(height: 150),
          child: TabBarView(
            viewportFraction: 1,
            controller: tabController,
            children: [
              NutritionDetails(widget.food),
              Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_fire_department_outlined,
                      color: Colors.amber,
                      size: 50,
                    ),
                    Text(
                      widget.food.calories.round().toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    )
                  ],
                ),
              ),
              Text("!"),
            ],
          ),
        )
      ],
    );
  }
}

class NutritionDetails extends StatelessWidget {
  final Food food;
  const NutritionDetails(this.food, {super.key});

  // ([ Name, Color  ]-> [ smoothedRatio, RealValue ] )
  List<MapEntry<MapEntry<String, Color>, MapEntry<double, double>>>
      get getItemsWithRatio {
    final allVals = food.nutritions.entries.map((k) => k.value).toList();

    final smoothed = food.nutritions.entries
        .map((k) => MapEntry(
            k.key.display, MapEntry(smoothValue(allVals, k.value), k.value)))
        .where((e) => e.value.key > 0)
        .toList();

    final total = max(smoothed.fold(0.0, (acc, v) => acc + v.value.key), 1.0);

    return smoothed
        .map((k) =>
            MapEntry(k.key, MapEntry(k.value.key / total, k.value.value)))
        .where((e) => e.value.key > 0)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: getItemsWithRatio
              .map((e) => Flexible(
                  flex: (e.value.key * 10).round(),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: e.key.value,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    height: 8,
                  )))
              .toList(),
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0).copyWith(top: 12),
            child: Wrap(
              spacing: 20,
              alignment: WrapAlignment.spaceAround,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.spaceBetween,
              runSpacing: 20,
              children: getItemsWithRatio
                  .map((e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                  backgroundColor: e.key.value, radius: 4),
                              SizedBox(width: 6),
                              Text(
                                e.key.key,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 2),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 16),
                              Text(
                                e.value.value.toString(),
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          )
                        ],
                      ))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }
}

class CircleTabIndicator extends Decoration {
  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  final BoxPainter _painter;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  final Paint _paint;
  final double radius;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius * 3);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
