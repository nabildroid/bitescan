import 'package:bitescan/config/locator.dart';
import 'package:bitescan/services/local_notification_service.dart';
import 'package:flutter/material.dart';

class OnboardingRadioOptions<T> extends StatefulWidget {
  final List<MapEntry<MapEntry<String, String>, T>> options;

  final void Function(dynamic val) next;

  const OnboardingRadioOptions(
      {super.key, required this.options, required this.next});

  @override
  State<OnboardingRadioOptions> createState() =>
      _OnboardingRadioOptionsState<T>();
}

class _OnboardingRadioOptionsState<T> extends State<OnboardingRadioOptions>
    with TickerProviderStateMixin {
  T? value;

  late final AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 12,
    );

    animationController.addListener(() async {
      if (animationController.isCompleted) {
        if (value == null) return;

        widget.next(value);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: widget.options
            .map(
              (option) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    final active = option.value == value &&
                        (animationController.value % 4 > 2 ||
                            animationController.isCompleted);

                    return RadioListTile(
                      tileColor: active
                          ? Theme.of(context).primaryColor.withOpacity(0.2)
                          : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(
                          color: active
                              ? Theme.of(context).primaryColor.withOpacity(0.3)
                              : Theme.of(context).primaryColor.withOpacity(0.1),
                        ),
                      ),
                      value: option.value as T,
                      groupValue: value,
                      onChanged: (val) {
                        setState(() {
                          value = val as T;
                        });

                        animationController.forward(from: 0);
                      },
                      title: Text(option.key.key),
                      subtitle: Text(option.key.value),
                    );
                  },
                ),
              ),
            )
            .toList());
  }
}
