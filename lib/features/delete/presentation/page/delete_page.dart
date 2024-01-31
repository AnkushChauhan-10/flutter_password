import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password/core/utiles/NetworkConnectivityController.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/delete/presentation/provider/delete_provider.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key, required DeleteProvider deleteProvider, required DataMap dataMap})
      : _deleteProvider = deleteProvider,
        _data = dataMap;

  final DeleteProvider _deleteProvider;
  final DataMap _data;

  @override
  Widget build(BuildContext context) {
    print(_data);
    return GetBuilder<NetworkConnectivityController>(
      builder: (ctrl) {
        return ctrl.connection
            ? AlertDialog(
                title: const Text("Remove Account"),
                content: const Text("Are you sure you want to remove this Account ?"),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      _deleteProvider.delete(() {
                        Navigator.of(context).pop(true);
                      }, _data);
                    },
                    child: const Text("Yes"),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("No"),
                  ),
                ],
              )
            : const AlertDialog(
                title: Text("No internet connection"),
              );
      },
    );
  }
}
