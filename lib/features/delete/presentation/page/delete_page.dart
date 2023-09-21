import 'package:flutter/material.dart';
import 'package:password/features/delete/presentation/provider/delete_provider.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required DeleteProvider deleteProvider,
    required String name,
  })  : _deleteProvider = deleteProvider,
        _name = name;

  final DeleteProvider _deleteProvider;
  final String _name;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Remove Account"),
      content: const Text("Are you sure you want to remove this Account ?"),
      actions: <Widget>[
        ElevatedButton(
            onPressed: () {
              _deleteProvider.delete(() {
                Navigator.of(context).pop(true);
              }, _name);
            },
            child: const Text("Yes")),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("No"),
        ),
      ],
    );
  }
}
