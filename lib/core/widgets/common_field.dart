import 'package:flutter/material.dart';

class CommonField extends StatelessWidget {
  CommonField({super.key, required this.controller, required this.label, required this.validation, this.arg, this.enable});

  final TextEditingController controller;
  final String label;
  String? arg;
  bool? enable;
  Function validation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: enable,
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
