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
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.cyan,
            ),
            child: Center(
              child: Text(
                name[0],
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      ),
    );
  }
}
