import 'package:flutter/material.dart';
import 'package:password/features/delete/presentation/page/delete_page.dart';
import 'package:password/features/delete/presentation/provider/delete_provider.dart';
import 'package:password/features/show_accounts_list/domain/entities/show_account.dart';
import 'package:password/features/show_accounts_list/presentation/widgets/show_account_tile.dart';
import 'package:password/injection_container.dart';

class ShowAccountList extends StatelessWidget {
  const ShowAccountList({super.key, required this.list, required this.onTap});

  final List<ShowAccount> list;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => Dismissible(
          direction: DismissDirection.endToStart,
          background: Container(
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
              onTap: () => onTap.call(list[index]),
            ),
          ),
        ),
      ),
    );
  }
}
