import 'package:flutter/material.dart';
import 'package:password/features/sign_out/presentation/page/sign_out_page.dart';
import 'package:password/features/sign_out/presentation/provider/sign_out_provider.dart';
import 'package:password/injection_container.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.onLogOut,
    required this.name,
    required this.email,
  });

  final String name;
  final String email;
  final GestureTapCallback onLogOut;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: RichText(
              text: TextSpan(
                children: [
                  const WidgetSpan(child: Icon(Icons.person)),
                  TextSpan(text: name),
                ],
              ),
            ),
            accountEmail:RichText(
              text: TextSpan(
                children: [
                  const WidgetSpan(child: Icon(Icons.email)),
                  TextSpan(text: email),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SignOutPage(
                        signOutProvider: sl<SignOutProvider>(),
                      );
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
