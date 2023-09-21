import 'package:flutter/material.dart';
import 'package:password/features/sign_out/presentation/page/sign_out_page.dart';
import 'package:password/features/sign_out/presentation/provider/sign_out_provider.dart';
import 'package:password/injection_container.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key, required this.onLogOut});

  GestureTapCallback onLogOut;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Ankush"),
            accountEmail: Text("email.com"),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SignOutPage(signOutProvider: sl<SignOutProvider>(),);
                    },
                  );
                },
                child: Text("Log out")),
          ),
        ],
      ),
    );
  }
}
