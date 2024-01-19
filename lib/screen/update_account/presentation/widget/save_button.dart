import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.originalStrings, required this.newStrings, required this.onClick});

  final List<String> originalStrings;
  final List<String> newStrings;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: check(),
      child: ElevatedButton(
        onPressed: ()=>onClick.call(),
        style: ElevatedButton.styleFrom(),
        child: const Text("Save"),
      ),
    );
  }

  bool check() {
    try {
      for (int i = 0; i < originalStrings.length; i++) {
        if (originalStrings[i] != newStrings[i]) return true;
      }
      return false;
    } catch (e) {
      return true;
    }
  }
}
