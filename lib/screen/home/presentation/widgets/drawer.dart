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
      backgroundColor: const Color.fromRGBO(22, 105, 122, 1.0),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(22, 105, 122, 1.0),
            ),
            onDetailsPressed: () {
              print("press");
            },
            otherAccountsPictures: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.sunny,
                  color: Colors.white,
                ),
              )
            ],
            currentAccountPicture: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  name[0],
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            accountName: Text(name),
            accountEmail: Text(email),
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
