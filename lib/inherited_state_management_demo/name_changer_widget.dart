import 'package:flutter/material.dart';

import 'simple_inherit_widget.dart';

class NameChanger extends StatelessWidget {
  const NameChanger({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return Column(
      children: [
        Text("Current Name is : ${SimplInheritedWidget.of(context)?.simplState.userName}"),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: nameController,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  String newName = nameController.text;
                  SimplInheritedWidget.of(context)?.simplState.updateUserPrefs(newName: newName);
                },
                child: const Text("Update"))
          ],
        ),
      ],
    );
  }
}
