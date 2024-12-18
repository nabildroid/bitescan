import 'dart:async';
import 'dart:math';

import 'package:bitescan/cubits/scanning/scanning_cubit.dart';
import 'package:bitescan/cubits/session_confirmation/session_confirmation_cubit.dart';
import 'package:bitescan/cubits/session_confirmation/session_confirmation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class ShoppingConfirmationScreen extends StatefulWidget {
  final String id;
  const ShoppingConfirmationScreen({super.key, required this.id});

  @override
  State<ShoppingConfirmationScreen> createState() =>
      _ShoppingConfirmationScreenState();
}

class _ShoppingConfirmationScreenState extends State<ShoppingConfirmationScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  int max = 0;
  int current = 1;

  @override
  void initState() {
    super.initState();

    context.read<SessionConfirmationCubit>().startConfirming();

    _controller = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: Duration(milliseconds: 500),
    );

    Future.delayed(Duration(milliseconds: 100)).then((_) {
      _controller.forward();
    });

    setState(() {
      max = context.read<SessionConfirmationCubit>().state.queue.length;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ScanningCubit>().state;

    var items = [...state.shoppings];

    if (state.session != null) {
      items = [state.session!, ...items];
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        context.read<SessionConfirmationCubit>().finishConfirming();
        _controller.reverse();
        if (didPop) return;
        Future.delayed(Duration(milliseconds: 500)).then((_) {
          if (mounted) {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          }
        });
      },
      child: BlocListener<SessionConfirmationCubit, SessionConfirmationState>(
        listenWhen: (n, o) => n.queue.isNotEmpty && o.queue.isEmpty,
        listener: (ctx, state) {
          if (state.queue.isEmpty && mounted) {
            Navigator.maybePop(ctx);
          }
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: AnimatedBuilder(
            animation: _controller,
            builder: (_, child) => Container(
              color: ColorTween(begin: Colors.black12, end: Colors.black54)
                  .transform(_controller.value),
              child: child,
            ),
            child: Column(
              children: [
                Flexible(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SizedBox.expand(),
                  ),
                ),
                Flexible(
                  flex: 12,
                  child: SlideTransition(
                    position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                        .animate(CurvedAnimation(
                            parent: _controller,
                            curve: Curves.fastLinearToSlowEaseIn)),
                    child: BottomSheet(
                      key: Key("bottom"),
                      onClosing: () {
                        Navigator.of(context).pop();
                      },
                      builder: (_) => Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Confirmed $current of $max",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            LinearProgressIndicator(
                              value: current / max,
                              color: Colors.black,
                              minHeight: 5,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Shopping Confirmation",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                              ),
                            ),
                            SizedBox(height: 24),
                            Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 300),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      child: Cards3D(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red.shade400,
                                      foregroundColor: Colors.black,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<SessionConfirmationCubit>()
                                          .confirm(false);

                                      setState(() => current++);
                                    },
                                    child: Text("didn't purchase"),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green.shade400,
                                      foregroundColor: Colors.black,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<SessionConfirmationCubit>()
                                          .confirm(true);
                                      setState(() => current++);
                                    },
                                    child: Text("Yes Bought it!"),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      animationController: _controller,
                      enableDrag: true,
                      showDragHandle: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Cards3D extends StatefulWidget {
  const Cards3D({
    super.key,
  });

  @override
  State<Cards3D> createState() => _Cards3DState();
}

class _Cards3DState extends State<Cards3D> with TickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
      lowerBound: 0,
      upperBound: 1,
    );

    controller.addListener(() => animationListener());

    controller.repeat();
  }

  void animationListener() {}

  String current = "background";
  String previous = "face";
  String temp = "face";

  int index = 1;

  @override
  Widget build(BuildContext context) {
    const len = 3.0;
    return PopScope(
      onPopInvokedWithResult: (_, __) => {},
      child: Stack(
        clipBehavior: Clip.antiAlias,
        fit: StackFit.expand,
        children: List.generate(
          len.round(),
          (i) => Page3D(
              i: i,
              child: BlocBuilder<SessionConfirmationCubit,
                  SessionConfirmationState>(builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.queue.lastOrNull?.name ?? "Food Name",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            color: Colors.white70,
                            icon: Icon(Icons.ac_unit_rounded),
                          ),
                        ],
                      ),
                      SizedBox(height: 9),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.queue.lastOrNull?.category ??
                                    "Food Category",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer_sharp,
                                    color: Colors.white54,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "8 aout 2024",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                          Image.network(
                            state.queue.lastOrNull?.image ??
                                "https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg",
                            width: 100,
                            height: 100,
                            color: const Color.fromARGB(255, 42, 53, 59),
                            colorBlendMode: BlendMode.multiply,
                          ),
                        ],
                      ),
                      SizedBox(height: 9),
                      Container(
                        height: 80,
                        child: SfBarcodeGenerator(
                          value: state.queue.lastOrNull?.code ?? "656565656565",
                          symbology: EAN13(),
                          barColor: Colors.black,
                          showValue: true,
                          textStyle: TextStyle(color: Colors.black87),
                        ),
                      )
                    ],
                  ),
                );
              })),
        ),
      ),
    );
  }
}

class Page3D extends StatelessWidget {
  const Page3D({
    super.key,
    required this.child,
    required this.i,
  });

  final Widget child;
  final int i;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: Duration(milliseconds: 100),
      scale: min(1, (i * 0.8 + 1) / 3) - (i * 0.05 + pow(i, 1.5) * 0.02) * 0.1,
      alignment: Alignment.topCenter,
      child: AnimatedSlide(
        duration: Duration(milliseconds: 100),
        offset: Offset(0, i * 0.05 + pow(i, 1.5) * 0.02),
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, -0.3),
                  blurRadius: 12,
                  spreadRadius: 3,
                )
              ],
              color: Color.fromARGB(255, 43, 55, 59),
              borderRadius: BorderRadius.circular(20),
            ),
            child: child),
      ),
    );
  }
}
