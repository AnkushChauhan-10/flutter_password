import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_bloc.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_event.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_state.dart';
import 'package:password/features/show_accounts_list/presentation/widgets/schow_account_list.dart';

class ShowAccountsListPage extends StatelessWidget {
  const ShowAccountsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ShowAccountsListBloc>().add(const OnGetShowAccountsListEvent());
    return Scaffold(
      body: Center(
        child: BlocBuilder<ShowAccountsListBloc, ShowAccountsListState>(
          builder: (context, state) {
            if(state.state == false){
              context.read<ShowAccountsListBloc>().add(const OnGetShowAccountsListEvent());
            }
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ShowAccountList(
                list: state.list,
                onTap: () {},
              );
            }
          },
        ),
      ),
    );
  }
}
