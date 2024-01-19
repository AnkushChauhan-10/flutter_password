import 'package:flutter/material.dart';

class UpdateField extends StatelessWidget {
  UpdateField({
    super.key,
    required this.controller,
    required this.label,
    this.edit,
    this.copy,
    this.funEdit,
    this.funCopy,
  });

  final TextEditingController controller;
  final String label;
  bool? copy;
  bool? edit;
  Function? funCopy;
  Function? funEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              enabled: edit ?? false,
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(onPressed: ()=>funCopy?.call(), icon: Icon(copy != null ? (copy! ? Icons.copy_all : Icons.copy) : null)),
          IconButton(onPressed: ()=>funEdit?.call(), icon: Icon(edit != null ? (edit! ? Icons.mode_edit_rounded : Icons.edit_outlined) : null)),
        ],
      ),
    );
  }
}
