import 'package:flutter/material.dart';

class ErrorMsg extends StatelessWidget {
  const ErrorMsg({super.key, required this.isError, required });

  final String? isError;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isError != null,
      child: Center(
        child: Text(
          isError??"Something went wrong",
          style: const TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
