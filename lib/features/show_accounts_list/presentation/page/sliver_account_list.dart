import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/features/delete/presentation/page/delete_page.dart';
import 'package:password/features/delete/presentation/provider/delete_provider.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_bloc.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_event.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_state.dart';
import 'package:password/features/show_accounts_list/presentation/widgets/show_account_tile.dart';
import 'package:password/injection_container.dart';

class SliverAccountList extends StatelessWidget {
  const SliverAccountList({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ShowAccountsListBloc>().add(const OnGetShowAccountsListEvent());
    return BlocBuilder<ShowAccountsListBloc, ShowAccountsListState>(
      builder: (context, state) {
        if (state.state == false) {
          context.read<ShowAccountsListBloc>().add(const OnGetShowAccountsListEvent());
        }
        if (state.isLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          var list = state.list;
          return list.isEmpty
              ? const SliverToBoxAdapter(
                  child: Center(
                    child: Text("No Data"),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, int index) {
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        background: Container(
                          padding: const EdgeInsets.all(20),
                          color: Colors.red,
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
                                name: list[index].title,
                              );
                            },
                          );
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: ShowAccountTile(
                            accountData: list[index],
                            onTap: (account){
                              Navigator.pushNamed(context, editPageRoute,arguments: account);
                            },
                          ),
                        ),
                      );
                    },
                    childCount: state.list.length,
                  ),
                );
        }
      },
    );
  }
}
