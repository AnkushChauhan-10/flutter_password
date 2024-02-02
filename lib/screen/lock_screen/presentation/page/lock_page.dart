import 'package:flutter/material.dart';
import 'package:password/injection_container.dart';
import 'package:password/screen/lock_screen/data/lock_repository.dart';
import 'package:password/core/widgets/num_pad.dart';

class LockPage extends StatefulWidget {
  const LockPage({super.key, required this.onDone});

  final Function onDone;

  @override
  State<LockPage> createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  late TextEditingController _controller;
  late String pin;

  @override
  void initState() {
    pin = sl<LockRepository>().lock();
    _controller = TextEditingController();
    _controller.addListener(() {
      if (_controller.text.length == 4) {
        check();
      }
      setState(() {});
    });
    super.initState();
  }

  void check() {
    if (_controller.text == pin) {
      widget.onDone.call();
    } else {
      reset();
    }
  }

  void reset() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Enter the Password",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _controller.text,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            NumPad(
              delete: () {
                _controller.text.isNotEmpty ? _controller.text = _controller.text.substring(0, _controller.text.length - 1) : null;
              },
              onSubmit: () {},
              controller: _controller,
            ),
          ],
        ),
      ),
    );
  }
}
