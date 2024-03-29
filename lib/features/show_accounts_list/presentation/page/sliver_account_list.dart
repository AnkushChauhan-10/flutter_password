import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/core/utiles/nav.dart';
import 'package:password/features/delete/presentation/page/delete_page.dart';
import 'package:password/features/delete/presentation/provider/delete_provider.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_bloc.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_event.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_state.dart';
import 'package:password/features/show_accounts_list/presentation/widgets/show_account_tile.dart';
import 'package:password/injection_container.dart';
import 'package:password/screen/home/presentation/bloc/home_bloc.dart';
import 'package:password/screen/home/presentation/bloc/home_state.dart';

class SliverAccountList extends StatelessWidget {
  const SliverAccountList({super.key});

  @override
  Widget build(BuildContext context) {
    var focusNode = FocusNode();
    return BlocProvider(
      create: (context) => sl<ShowAccountsListBloc>(),
      child: BlocListener<HomeBloc, HomeState>(
        listenWhen: (p, c) => p.loggedUser.token != c.loggedUser.token,
        listener: (context, state) {
          context.read<ShowAccountsListBloc>().add(const SetStreamListEvent());
        },
        child: BlocBuilder<ShowAccountsListBloc, ShowAccountsListState>(
          builder: (context, state) {
            if (state.state == false) {}
            if (state.isLoading) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              var list = state.isSearch ? state.searchList : state.list;
              return SliverStickyHeader(
                header: Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: TextFormField(
                    focusNode: focusNode,
                    onChanged: (value) => context.read<ShowAccountsListBloc>().add(OnSearchListEvent(value)),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                sliver: list.isEmpty
                    ? SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            const Center(
                              child: Text("No Data"),
                            ),
                          ],
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(250, 250, 250, 0.3),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    return Dismissible(
                                      direction: DismissDirection.endToStart,
                                      background: Container(
                                        padding: const EdgeInsets.all(20),
                                        color: Theme.of(context).disabledColor,
                                        child: const Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        ),
                                      ),
                                      key: UniqueKey(),
                                      onDismissed: (direction) {},
                                      confirmDismiss: (d) async {
                                        return await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return DeleteDialog(
                                              deleteProvider: sl<DeleteProvider>(),
                                              dataMap: list[index].toMap(),
                                            );
                                          },
                                        );
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ShowAccountTile(
                                          accountData: list[index],
                                          onTap: (account) {
                                            Nav.of(context).pushNameHorizontalSlideAnimation(editPageRoute, arg: account);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
              );
            }
          },
        ),
      ),
    );
  }
}
