import 'package:bitescan/cubits/onboarding/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameDialog extends StatelessWidget {
  const NameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    return AlertDialog.adaptive(
      title: Text("Your Name"),
      icon: Icon(Icons.timer_3),
      actionsAlignment: MainAxisAlignment.center,
      content: TextField(
        autofocus: true,
        onChanged: (val) {
          cubit.setName(val);
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Save"),
        )
      ],
    );
  }
}
