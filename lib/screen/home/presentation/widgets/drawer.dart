import 'package:flutter/material.dart';
import 'package:password/features/sign_out/presentation/page/sign_out_page.dart';
import 'package:password/features/sign_out/presentation/provider/sign_out_provider.dart';
import 'package:password/features/theme_mode/theme_widget.dart';
import 'package:password/injection_container.dart';

class CustomDrawer extends StatefulWidget {
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
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> with TickerProviderStateMixin {
  late String name;
  late String email;

  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    name = widget.name;
    email = widget.email;
    return Drawer(
      backgroundColor: const Color.fromRGBO(22, 105, 122, 1.0),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(22, 105, 122, 1.0),
            ),
            onDetailsPressed: () {
              _controller.isCompleted ? _controller.reverse() : _controller.forward();
            },
            otherAccountsPictures: const [ThemeWidget()],
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
            accountName: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            accountEmail: Text(email, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          SizeTransition(
            sizeFactor: _animation,
            axis: Axis.vertical,
            child: const Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Add account",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ],
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
