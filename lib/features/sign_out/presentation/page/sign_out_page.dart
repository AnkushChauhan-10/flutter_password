import 'package:flutter/material.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/features/sign_out/presentation/provider/sign_out_provider.dart';

class SignOutPage extends StatelessWidget {
  const SignOutPage({super.key, required SignOutProvider signOutProvider}) : _signOutProvider = signOutProvider;

  final SignOutProvider _signOutProvider;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Logg Out"),
      content: const Text("Are you sure you want to log out custom"),
      actions: <Widget>[
        ElevatedButton(
            onPressed: () {
              _signOutProvider.signOut((){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, signInPageRoute);
              });
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
