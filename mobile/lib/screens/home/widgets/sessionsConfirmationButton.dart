import 'dart:async';

import 'package:bitescan/config/paths.dart';
import 'package:bitescan/cubits/data/data_cubit.dart';
import 'package:bitescan/cubits/onboarding/onboarding_cubit.dart';
import 'package:bitescan/cubits/scanning/scanning_cubit.dart';
import 'package:bitescan/cubits/scanning/scanning_state.dart';
import 'package:bitescan/cubits/session_confirmation/session_confirmation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';

class SessionsconfirmationButton extends StatefulWidget {
  const SessionsconfirmationButton({super.key});

  @override
  State<SessionsconfirmationButton> createState() =>
      _SessionsconfirmationButtonState();
}

class _SessionsconfirmationButtonState
    extends State<SessionsconfirmationButton> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();

    listenForSessions();
    syncScanningWithConfirmation();
  }

  void syncScanningWithConfirmation() {
    context
        .read<SessionConfirmationCubit>()
        .attachToConfirmation((session, decision) {
      context.read<ScanningCubit>().confirmFood(
            sessionId: session,
            decision: decision,
          );
    });
  }

  void listenForSessions() {
    void onChange() {
      final scanning = context.read<ScanningCubit>().state;
      final data = context.read<DataCubit>().state;

      if (scanning.shoppings.isNotEmpty) {
        final cubit = context.read<SessionConfirmationCubit>();

        cubit.loadSessions(scanning.shoppings.toList());
        cubit.loadFoods(data.foods);
      }
    }

    _sub = MergeStream([
      context.read<ScanningCubit>().stream,
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
    return InkWell(
      onTap: () {
        final count = context
            .read<ScanningCubit>()
            .state
            .shoppings
            .where((e) => e.requiresConfirmation)
            .length;

        if (count < 1) return;
        context.push(Paths.shoppingConfirmation.link("12"));
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (_) => ShoppingConfirmationScreen(),
        // ));
      },
      child: CircleAvatar(
        backgroundImage: NetworkImage("https://github.com/nabildroid.png"),
        child: Align(
          alignment: Alignment.topRight,
          child: BlocBuilder<ScanningCubit, ScanningState>(
              builder: (context, state) {
            final count =
                state.shoppings.where((e) => e.requiresConfirmation).length;

            if (count > 0) {
              return Badge.count(count: count);
            } else {
              return AbsorbPointer(
                absorbing: true,
                child: SizedBox.expand(),
              );
            }
          }),
        ),
      ),
    );
  }
}
