import 'package:flutter/material.dart';

class CommonField extends StatelessWidget {
  CommonField({super.key, required this.controller, required this.label, required this.validation, this.arg});

  final TextEditingController controller;
  final String label;
  String? arg;
  Function validation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (val) => arg == null ? validation(val) : validation(arg, val),
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
