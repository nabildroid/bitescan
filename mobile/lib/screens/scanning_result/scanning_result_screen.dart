import 'package:bitescan/main.dart';
import 'package:bitescan/models/food.dart';
import 'package:bitescan/models/goal.dart';
import 'package:bitescan/utils/utils.dart';
import 'package:bitescan/screens/scanning_result/widgets/scanning_results_widgets.dart';
import 'package:flutter/material.dart';

import 'widgets/food_view.dart';

class ScanningResultScreen extends StatefulWidget {
  final String code;
  const ScanningResultScreen({required this.code, super.key});

  @override
  State<ScanningResultScreen> createState() => _ScanningResultScreenState();
}

class _ScanningResultScreenState extends State<ScanningResultScreen> {
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
