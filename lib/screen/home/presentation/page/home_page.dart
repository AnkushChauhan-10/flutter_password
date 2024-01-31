import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:password/core/utiles/NetworkConnectivityController.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/core/utiles/utility.dart';
import 'package:password/features/fetch/fetch_controller.dart';
import 'package:password/features/show_accounts_list/presentation/page/sliver_account_list.dart';
import 'package:password/screen/home/presentation/bloc/home_bloc.dart';
import 'package:password/screen/home/presentation/bloc/home_event.dart';
import 'package:password/screen/home/presentation/bloc/home_state.dart';
import 'package:password/screen/home/presentation/widgets/drawer.dart';
import 'package:password/screen/home/presentation/widgets/sliver_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(const GetUsersHomeEvent());
    // context.read<HomeBloc>().add(const GetLoggedUserHomeEvent());
    return LayoutBuilder(
      builder: (context, size) {
        return BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(22, 105, 122, 1.0),
              title: const Text("Password"),
            ),
            key: _key,
            drawer: CustomDrawer(
              onLogOut: () {},
              loggedUser: state.loggedUser!,
              users: state.accounts,
            ),
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(22, 105, 122, 1.0),
                    Color.fromRGBO(72, 159, 181, 1.0),
                    Color.fromRGBO(130, 192, 204, 1.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  await Get.find<FetchController>().fetchDataBase();
                },
                child: CustomScrollView(
                  slivers: [
                    SliversAppBar(
                      profileUrl: "",
                      name: state.loggedUser!.name,
                      setState: () {
                        setState(() {});
                      },
                    ),
                    SliverAccountList(),
                  ],
                ),
              ),
            ),
            floatingActionButton: GetBuilder<NetworkConnectivityController>(
              builder: (controller) => Opacity(
                opacity: controller.connection ? 1 : 0.5,
                child: FloatingActionButton(
                  // backgroundColor: const Color.fromRGBO(72, 159, 181, 1.0),
                  onPressed: () async {
                    controller.connection
                        ? await Navigator.pushNamed(context, savePageRoute)
                        : Utility.toastMessage(
                            title: "Network Error",
                            message: "Please Check your network connection and try again!",
                          );
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
