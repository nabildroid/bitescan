import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 103, 58, 183)),
        useMaterial3: true,
      ),
      home: OnboardingScreen1(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = PageController(
    initialPage: 3,
    viewportFraction: .5,
  );
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 247, 229, 153),
        ).copyWith(
          onSurface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 16, 24, 27),
      ),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            titleTextStyle: TextStyle(
              color: Colors.white,
            ),
            backgroundColor: Colors.transparent,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Walcome Nabil Lakrib",
                ),
                Text("Let's make food better"),
              ],
            ),
            actions: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage("https://github.com/nabildroid.png"),
              ),
              SizedBox(width: 8),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 32,
                    ),
                    fillColor: Color.fromARGB(255, 30, 44, 49),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text("Category"),
                    Spacer(),
                    Text(
                      "See All",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.all(8),
                child: LayoutBuilder(
                    builder: (_, constraints) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              4,
                              (__) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: constraints.maxWidth * 0.19,
                                        height: constraints.maxWidth * 0.19,
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 30, 44, 49),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Image.network(
                                              "https://github.com/nabildroid.png"),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      FittedBox(child: Text("Watermel"))
                                    ],
                                  )),
                        )),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Your Goal"),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    children: List.generate(
                      6,
                      (i) => AnimatedBuilder(
                          animation: controller,
                          builder: (context, _) {
                            final val = 1 -
                                (i -
                                        (controller.position.haveDimensions
                                                ? controller.page!
                                                : 3 + 0.1)
                                            .clamp(i - 0.5, i + 0.5))
                                    .abs();

                            return Opacity(
                              opacity: val,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: AspectRatio(
                                  aspectRatio: 5.5 / 7,
                                  child: AnimatedContainer(
                                    key: ValueKey(i),
                                    duration: Duration(seconds: 10),
                                    child: Container(
                                      margin: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          if (val > 0.5)
                                            BoxShadow(
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.3),
                                              blurRadius: 12,
                                              spreadRadius: 5,
                                            ),
                                        ],
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            label: Text("Scan the Food"),
            icon: Icon(Icons.document_scanner_outlined),
          ),
        );
      }),
    );
  }
}

class ScanningResult extends StatelessWidget {
  const ScanningResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Flexible(
            flex: 8,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(35)),
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
                        "Bottle 1L Water",
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
                        label: Text("120 points",
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
                                                child: Image.network(
                                                  "https://www.taibaoline.com/wp-content/uploads/2024/03/FB_IMG_1710805951909.jpg",
                                                ),
                                              ),
                                            )),
                                  )),
                          SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            color: Colors.red.shade200.withOpacity(0.3),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      "Bad For Attention",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red.shade900,
                                          shadows: [
                                            BoxShadow(
                                              color: Colors.black87,
                                            )
                                          ]),
                                    ),
                                  ),
                                  Center(child: Text("Hated by 100 shopers"))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {}, child: Text("Nutritions")),
                              SizedBox(width: 12),
                              ElevatedButton(
                                  onPressed: () {}, child: Text("Nutritions")),
                            ],
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Flexible(
                                  flex: 3,
                                  child:
                                      Container(color: Colors.red, height: 8)),
                              SizedBox(width: 5),
                              Flexible(
                                  flex: 2,
                                  child:
                                      Container(color: Colors.blue, height: 8)),
                              SizedBox(width: 5),
                              Flexible(
                                  flex: 5,
                                  child: Container(
                                      color: Colors.green, height: 8)),
                              SizedBox(width: 5),
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                      color: Colors.white, height: 8)),
                              SizedBox(width: 5),
                            ],
                          ),
                          SizedBox(height: 6),
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              runSpacing: 2,
                              spacing: 20,
                              children: List.generate(
                                  4,
                                  (_) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 3),
                                              SizedBox(width: 2),
                                              Text("Hello Nutrition")
                                            ],
                                          ),
                                          Text("60")
                                        ],
                                      )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: Container(
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
                      child: ListView.separated(
                    itemBuilder: (_, __) => ListTile(
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => HomeScreen()));
                        },
                        icon: Icon(Icons.add),
                      ),
                      leading: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.all(8),
                        child:
                            Image.network("https://github.com/nabildroid.png"),
                      ),
                      title: Text("Water Saida"),
                    ),
                    separatorBuilder: (_, __) => SizedBox(height: 8),
                    itemCount: 20,
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
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

class ScanTest extends StatelessWidget {
  const ScanTest({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: FittedBox(child: Text(title)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.close))],
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
                  child: ClipPath(
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
                  Expanded(
                      child: ListView.separated(
                    itemBuilder: (_, __) => ListTile(
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ScanningResult()));
                        },
                        icon: Icon(Icons.add),
                      ),
                      leading: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.all(8),
                        child:
                            Image.network("https://github.com/nabildroid.png"),
                      ),
                      title: Text("Water Saida"),
                    ),
                    separatorBuilder: (_, __) => SizedBox(height: 8),
                    itemCount: 20,
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 28),
            Text(
              "Finding your Goal!",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: 16),
            Text(
              "What is your\nGender?",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 16),
            RadioListTile(
              value: "hello",
              groupValue: "hello",
              onChanged: (_) {},
              title: Text("Male"),
              subtitle: Text("Fitness, Focus, Alertness ..."),
            ),
            SizedBox(height: 16),
            RadioListTile(
              value: false,
              groupValue: "hello",
              onChanged: (_) {},
              title: Text("Female"),
              subtitle: Text("Scancare, weight, Focus ..."),
            ),
            Spacer(),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: double.infinity),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => ScanTest()));
                },
                child: Text("Continue"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(height: 42),
          ],
        ),
      ),
    );
  }
}

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 28),
            CircleAvatar(
              backgroundImage:
                  NetworkImage("https://github.com/nabildroid.png"),
              radius: 36,
            ),
            SizedBox(height: 28),
            Text(
              "Start Creating\nYour Individual\nportfolio",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 16),
            Text(
              "Scan the codebar and see the nutrition of the food and how much it aligns with your goal, if not that good pick the suggested alternatives",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black54),
            ),
            Spacer(),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: double.infinity),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => OnboardingScreen2()));
                },
                child: Text("Continue"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(height: 42),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
  }) : super(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
                3,
                (_) => const Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                          backgroundColor: Colors.black87, radius: 6),
                    )),
          ),
          centerTitle: true,
          leading: IconButton.outlined(
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {},
            icon: Icon(Icons.arrow_back),
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.close))],
        );
}
