import 'package:bitescan/cubits/scanning/scanning_cubit.dart';
import 'package:bitescan/screens/home/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingConfirmationScreen extends StatelessWidget {
  const ShoppingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ScanningCubit>().state;

    var items = [...state.shoppings];

    if (state.session != null) {
      items = [state.session!, ...items];
    }

    return Scaffold(
        appBar: AppBar(),
        body: PageView(
          controller: PageController(
            viewportFraction: 0.5,
          ),
          children: List.generate(
            items.length,
            (i) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(items[i].id),
                Text(items[i].duration.toString()),
                Text("items: " + items[i].visitedFoodCodes.length.toString()),
              ],
            ),
          ),
        ));
  }
}
