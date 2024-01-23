import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password/core/utiles/NetworkConnectivityController.dart';
import 'package:password/features/fetch_db/presentation/provider/fetch_provider.dart';

class FetchDialog extends StatelessWidget {
  const FetchDialog({
    super.key,
    required FetchProvider fetchProvider,
    required Widget child,
    required this.onDone,
    required Function(bool)? checkUpdate,
  })  : _child = child,
        _checkUpdate = checkUpdate,
        _fetchProvider = fetchProvider;

  final Widget _child;
  final Function(bool)? _checkUpdate;
  final FetchProvider _fetchProvider;
  final Function? onDone;

  @override
  Widget build(BuildContext context) {
    _fetchProvider.fetchInfo((value) => _checkUpdate?.call(value));
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return GetBuilder<NetworkConnectivityController>(
              builder: (ctrl) {
                return ctrl.connection
                    ? AlertDialog(
                        title: const Text("Download Data"),
                        content: const Text("Are you sure you want to download data ?"),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              _fetchProvider.fetch(() {
                                Navigator.of(context).pop(false);
                              });
                              onDone?.call();
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
          },
        );
      },
      child: _child,
    );
  }
}
