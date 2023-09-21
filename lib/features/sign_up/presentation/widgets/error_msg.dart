import 'package:flutter/material.dart';

class ErrorMsg extends StatelessWidget {
  const ErrorMsg({super.key, required this.isError});

  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isError,
      child: const Center(
        child: Text(
          "Account already created using this email",
          style: TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
