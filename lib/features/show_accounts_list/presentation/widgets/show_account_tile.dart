import 'package:flutter/material.dart';
import 'package:password/features/show_accounts_list/domain/entities/show_account.dart';

class ShowAccountTile extends StatelessWidget {
  const ShowAccountTile({super.key, required this.accountData, required this.onTap});

  final ShowAccount accountData;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: accountData.isUpdate ? Colors.grey : Colors.lightGreen,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    accountData.title,
                    style: const TextStyle(fontSize: 26, color: Colors.black),
                  ),
                  Text(
                    "Last update :- ${accountData.lastUpdate}",
                    style: const TextStyle(fontSize: 11, color: Colors.black45),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(Icons.person),
                            ),
                            TextSpan(
                              text: " ${accountData.email}",
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(Icons.lock),
                            ),
                            TextSpan(
                              text: " ${accountData.password}",
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
