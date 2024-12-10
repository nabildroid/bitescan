import 'package:flutter/material.dart';

class NameDialog extends StatelessWidget {
  const NameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text("Your Name"),
      icon: Icon(Icons.timer_3),
      actionsAlignment: MainAxisAlignment.center,
      content: TextField(
        autofocus: true,
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
