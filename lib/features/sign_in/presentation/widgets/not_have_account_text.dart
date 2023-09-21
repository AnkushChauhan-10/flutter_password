import 'package:flutter/material.dart';

class NotHaveAccountText extends StatelessWidget {
  const NotHaveAccountText({super.key, required this.tap});

  final VoidCallback tap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          text: "do no have any ",
          children: [
            WidgetSpan(
              child: InkWell(
                onTap: tap,
                child: const Text(
                  "account ? ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
      ),
    );
  }
}
