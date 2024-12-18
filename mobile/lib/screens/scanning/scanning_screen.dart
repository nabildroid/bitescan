import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bitescan/config/custom_router.dart';
import 'package:bitescan/config/paths.dart';
import 'package:bitescan/cubits/data/data_cubit.dart';
import 'package:bitescan/cubits/data/data_state.dart';
import 'package:bitescan/cubits/scanning/scanning_cubit.dart';
import 'package:bitescan/extentions/loggable.dart';
import 'package:bitescan/models/food.dart';
import 'package:bitescan/screens/scanning_result/scanning_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class ScanningScreen extends StatefulWidget {
  ScanningScreen({super.key});

  static get title {
    const examples = [
      "Unlock Your Food's Secrets",
      "Scan. Discover. Achieve.",
      "See Food Fit Faster",
      "Goal: Met? Scan Now!",
      "The Truth, Scanned Here",
      "Scan: Your Goal Awaits"
    ];

    return examples[Random().nextInt(examples.length)];
  }

  @override
  State<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen>
    with WidgetsBindingObserver, Loggable {
  final MobileScannerController controller = MobileScannerController();

  late Timer _timer;

  final wakeLockSubject = BehaviorSubject<void>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    startTimer();

    context.read<ScanningCubit>().startShoppingSession();

    wakeLockSubject.listen((_) {
      logTrace("-> Enabling Wakelock ");
      WakelockPlus.enable();
    });
    wakeLockSubject.debounceTime(Duration(minutes: 5)).listen((data) {
      if (!mounted) return;

      WakelockPlus.disable();
      logTrace("-> Disabling Wakelock ");
    });
  }

  void manuelScan() async {
    final byteData = await rootBundle.load("assets/barcode.png");

    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/temp_image.png');

    // Write the image data to the temporary file
    await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    final data =
        await controller.analyzeImage('${tempDir.path}/temp_image.png');

    if (data?.barcodes.first != null && data!.barcodes.first.rawValue != null) {
      openResult(data.barcodes.first.rawValue!);
    }
  }

  void openResult(String value) {
    HapticFeedback.lightImpact();

    wakeLockSubject.add(null);
    context.push(Paths.result.link(value)).then((_) {
      if (!mounted) return;
      try {
        controller.start();
      } catch (e) {}
    });
  }

  @override
  void dispose() async {
    super.dispose();

    _timer.cancel();

    wakeLockSubject.close();
    WidgetsBinding.instance.removeObserver(this);

    try {
      await controller.dispose();
      await WakelockPlus.disable();
    } catch (e) {}
  }

  void startTimer() {
    const duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, (timer) {
      context.read<ScanningCubit>().dispatchShoppingSecond();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        startTimer();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        _timer.cancel();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: FittedBox(child: Text(ScanningScreen.title)),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Flexible(
            flex: 6,
            child: Align(
                alignment: Alignment(0, -.5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.white10,
                        Colors.white10.withOpacity(.02),
                      ],
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * .6,
                  height: MediaQuery.of(context).size.width * .6,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Platform.isAndroid
                              ? MobileScanner(
                                  controller: controller,
                                  onDetect: (BarcodeCapture capture) {
                                    final List<Barcode> barcodes =
                                        capture.barcodes;

                                    if (barcodes.first.rawValue != null) {
                                      openResult(barcodes.first.rawValue!);
                                      controller.stop();
                                    }
                                  },
                                )
                              : SizedBox.shrink(),
                        ),
                      ),
                      ClipPath(
                        clipper: ScanCameraFrameClipper(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                              strokeAlign: -2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Flexible(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -2),
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 3,
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Text(
                    "Or Select Bellow",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  BlocBuilder<DataCubit, DataState>(builder: (context, state) {
                    return Expanded(
                        child: ListView.separated(
                      itemBuilder: (_, index) => ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            openResult(state.foods[index].code);
                          },
                          icon: Icon(Icons.real_estate_agent_rounded),
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
                          child: Image.network(state.foods[index].image),
                        ),
                        title: Text(state.foods[index].name),
                      ),
                      separatorBuilder: (_, __) => SizedBox(height: 8),
                      itemCount: state.foods.length,
                    ));
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  String get logIdentifier => "ScanningScreen-State";
}

class ScanCameraFrameClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = Path();

    final ratio = size * 0.5;
    path.addRect(
      Rect.fromLTWH(
          size.width / 2 - ratio.width / 2, 0, ratio.width, size.height),
    );

    path.addRect(
      Rect.fromLTWH(
          0, size.height / 2 - ratio.height / 2, size.width, ratio.height),
    );

    final test = Path.combine(
        PathOperation.difference,
        Path()
          ..addRect(Rect.fromCircle(
              center: size.center(Offset.zero), radius: 1000000)),
        path);

    return test;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
