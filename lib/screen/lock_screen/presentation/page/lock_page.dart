import 'package:flutter/material.dart';
import 'package:password/screen/lock_screen/presentation/widgets/num_pad.dart';

class LockPage extends StatelessWidget {
  const LockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.black54,
          child:  Column(
            children: [
              Text("Enter the Password"),
              NumPad(),
            ],
          ),
        ),
      ),
    );
  }
}
