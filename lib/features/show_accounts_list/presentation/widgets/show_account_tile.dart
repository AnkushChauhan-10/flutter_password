import 'package:flutter/material.dart';
import 'package:password/features/show_accounts_list/domain/entities/show_account.dart';

class ShowAccountTile extends StatelessWidget {
  const ShowAccountTile({super.key, required this.accountData, required this.onTap});

  final ShowAccount accountData;
  final Function(ShowAccount) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call(accountData);
      },
      child: Card(
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    accountData.title,
                    style: const TextStyle(fontSize: 26, color: Colors.black),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    "Last update :- ${accountData.lastUpdate}",
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(
                                Icons.person,
                                color: Colors.black54,
                              ),
                            ),
                            TextSpan(
                              text: " ${accountData.userName}",
                              style: const TextStyle(fontSize: 15, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(
                                Icons.lock,
                                color: Colors.black54,
                              ),
                            ),
                            TextSpan(
                              text: " ${accountData.password}",
                              style: const TextStyle(fontSize: 15, color: Colors.black87),
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
