import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/features/show_accounts_list/presentation/page/show_accounts_list_page.dart';
import 'package:password/screen/home/presentation/bloc/home_bloc.dart';
import 'package:password/screen/home/presentation/bloc/home_event.dart';
import 'package:password/screen/home/presentation/bloc/home_state.dart';
import 'package:password/screen/home/presentation/widgets/curve_layout/curve_layout.dart';
import 'package:password/screen/home/presentation/widgets/curve_layout/layout_animation.dart';
import 'package:password/screen/home/presentation/widgets/drawer.dart';
import 'package:password/screen/home/presentation/widgets/home_tool_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> with TickerProviderStateMixin {
  @override
  late AnimationController controller;
  late Animation<double> animation;
  var maxPer = 0.9, minPer = 0.6, currentPer = 0.6;
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _setAnimation(currentPer, minPer);
    context.read<HomeBloc>().add(const GetUserDataHomeEvent());
  }

  _setAnimation(double start, double end) {
    controller.reset();
    animation = Tween<double>(begin: currentPer, end: end).animate(controller)
      ..addStatusListener((status) {
        setState(() {});
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        return Scaffold(
          key: _key,
          drawer: CustomDrawer(
            onLogOut: () {
            },
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.lightBlueAccent,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      height: size.maxHeight * 0.4,
                      width: size.maxWidth,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: HomeToolBar(
                          profileUrl: '',
                          name: state.name,
                          onChange: (String text) {},
                          onTab: () {
                            _key.currentState?.openDrawer();
                          },
                        ),
                      ),
                    ),
                    LayoutAnimation(
                      animation: animation,
                      width: size.maxWidth,
                      height: size.maxHeight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: CurveLayout(
                          dragUp: () {
                            setState(() {
                              _setAnimation(currentPer, maxPer);
                              currentPer = maxPer;
                            });
                          },
                          dragDown: () {
                            setState(() {
                              _setAnimation(currentPer, minPer);
                              currentPer = minPer;
                            });
                          },
                          child: const ShowAccountsListPage(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.pushNamed(context, savePageRoute);
              setState(() {});
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
