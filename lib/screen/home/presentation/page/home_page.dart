import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:password/core/utiles/NetworkConnectivityController.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/core/utiles/utility.dart';
import 'package:password/features/show_accounts_list/presentation/page/show_accounts_list_page.dart';
import 'package:password/features/show_accounts_list/presentation/page/sliver_account_list.dart';
import 'package:password/screen/home/presentation/bloc/home_bloc.dart';
import 'package:password/screen/home/presentation/bloc/home_event.dart';
import 'package:password/screen/home/presentation/bloc/home_state.dart';
import 'package:password/screen/home/presentation/widgets/drawer.dart';
import 'package:password/screen/home/presentation/widgets/home_tool_bar.dart';
import 'package:password/screen/home/presentation/widgets/sliver_app_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(const GetUserDataHomeEvent());
    return LayoutBuilder(
      builder: (context, size) {
        return BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) => Scaffold(
            key: _key,
            drawer: CustomDrawer(
              onLogOut: () {},
              name: state.name,
              email: state.email,
            ),
            body: CustomScrollView(
              slivers: [
                SliversAppBar(profileUrl: "", name: state.name),
                const SliverAccountList(),
              ],
            ),
            floatingActionButton: GetBuilder<NetworkConnectivityController>(
              builder: (controller) => Opacity(
                opacity: controller.connection ? 1 : 0.5,
                child: FloatingActionButton(
                  onPressed: () async {
                    controller.connection
                        ? await Navigator.pushNamed(context, savePageRoute)
                        : Utility.toastMessage(
                            title: "Network Error",
                            message: "Please Check your network connection and try again!",
                          );
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
