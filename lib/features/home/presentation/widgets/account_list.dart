import 'package:flutter/material.dart';
import 'package:password/features/home/domain/entities/account_data.dart';
import 'package:password/features/home/presentation/widgets/account_tile.dart';

class AccountList extends StatelessWidget {
  const AccountList({super.key, required this.list, required this.onTap, required this.delete});

  final List<AccountData> list;
  final Function onTap;
  final Function delete;

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
                return AlertDialog(
                  title: const Text("Remove Account"),
                  content: const Text("Are you sure you want to remove this Account?"),
                  actions: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          delete.call(index);
                          Navigator.of(context).pop(true);
                        },
                        child: const Text("Yes")),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("No"),
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            width: double.infinity,
            child: AccountTile(
              accountData: list[index],
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }
}
