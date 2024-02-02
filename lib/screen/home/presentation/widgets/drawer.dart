import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/model/users.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/core/utiles/nav.dart';
import 'package:password/features/sign_out/presentation/page/sign_out_page.dart';
import 'package:password/features/sign_out/presentation/provider/sign_out_provider.dart';
import 'package:password/features/theme_mode/theme_widget.dart';
import 'package:password/injection_container.dart';
import 'package:password/screen/home/presentation/bloc/home_bloc.dart';
import 'package:password/screen/home/presentation/bloc/home_event.dart';
import 'package:password/screen/home/presentation/widgets/account_tile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
    required this.onLogOut,
    required this.loggedUser,
    required this.users,
  });

  final UsersModel loggedUser;
  final List<UsersModel> users;
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
    name = widget.loggedUser.name;
    email = widget.loggedUser.email;
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            onDetailsPressed: () {
              _controller.isCompleted ? _controller.reverse() : _controller.forward();
            },
            arrowColor: Theme.of(context).textSelectionTheme.selectionColor ?? Colors.black54,
            otherAccountsPictures: const [ThemeWidget()],
            currentAccountPicture: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              child: Center(
                child: Text(
                  name[0],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            ),
            accountName: Text(name, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
            accountEmail: Text(email, style: const TextStyle(fontSize: 16)),
          ),
          SizeTransition(
            sizeFactor: _animation,
            axis: Axis.vertical,
            child: Column(
              children: List.generate(
                widget.users.length + 1,
                (index) => index < widget.users.length
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: AccountTile(
                          onTap: () => context.read<HomeBloc>().add(
                                OnChangeLoggedUserHomeEvent(
                                  widget.users[index].token,
                                  () {
                                    Nav.of(context).pop();
                                    context.read<HomeBloc>().add(const GetUsersHomeEvent());
                                  },
                                ),
                              ),
                          name: widget.users[index].name,
                        ),
                      )
                    : Column(
                        children: [
                          InkWell(
                            onTap: () => Navigator.pushNamed(context, signInPageRoute),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.add),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Add account",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                            thickness: 0.1,
                            color: Theme.of(context).textSelectionTheme.selectionColor,
                          ),
                        ],
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Nav.of(context).pop();
                Nav.of(context).pushNameHorizontalSlideAnimation(securityPageRoute);
              },
              child: const Text(
                "Security",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
              child: const Text(
                "Log out",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
