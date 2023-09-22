import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/features/show_accounts_list/presentation/page/show_accounts_list_page.dart';
import 'package:password/screen/home/presentation/bloc/home_bloc.dart';
import 'package:password/screen/home/presentation/bloc/home_event.dart';
import 'package:password/screen/home/presentation/bloc/home_state.dart';
import 'package:password/screen/home/presentation/widgets/drawer.dart';
import 'package:password/screen/home/presentation/widgets/home_tool_bar.dart';

class HomePage1 extends StatelessWidget {
  HomePage1({super.key});

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(const GetUserDataHomeEvent());
    return LayoutBuilder(
      builder: (context, size) {
        return Scaffold(
          key: _key,
          drawer: CustomDrawer(
            onLogOut: () {},
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Container(
                color: Colors.lightBlueAccent,
                child: Column(
                  children: [
                    Flexible(
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
                    const Flexible(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: ShowAccountsListPage(),
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
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
