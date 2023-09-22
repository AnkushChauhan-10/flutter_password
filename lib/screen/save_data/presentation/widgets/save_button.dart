import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          child: const Text("Save"),
        ),
      ),
    );
  }
}