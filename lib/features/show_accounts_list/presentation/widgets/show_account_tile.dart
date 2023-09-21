import 'package:flutter/material.dart';
import 'package:password/features/show_accounts_list/domain/entities/show_account.dart';

class ShowAccountTile extends StatelessWidget{
  const ShowAccountTile({super.key, required this.accountData, required this.onTap});
  final ShowAccount accountData;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap.call(),
      child: Card(
       color: accountData.isUpdate ? Colors.grey : Colors.lightGreen,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(accountData.siteName),
              Text(accountData.id),
              Text(accountData.userName),
              Text(accountData.password),
              Text(accountData.lastUpdate),
            ],
          ),
        ),
      ),
    );
  }

}