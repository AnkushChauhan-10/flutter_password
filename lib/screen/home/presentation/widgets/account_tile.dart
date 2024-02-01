import 'package:flutter/material.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({
    super.key,
    required this.onTap,
    required this.name,
  });

  final Function onTap;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            child: Center(
              child: Text(
                name[0],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
