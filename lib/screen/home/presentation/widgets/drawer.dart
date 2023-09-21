import 'package:flutter/material.dart';

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
                      return AlertDialog(
                        title: const Text("Logg Out"),
                        content: const Text("Are you sure you want to log out"),
                        actions: <Widget>[
                          ElevatedButton(
                              onPressed: () {
                                onLogOut();
                                Navigator.of(context).pop(true);
                              },
                              child: const Text("Yes")),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("No"),
                          ),
                        ],
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
