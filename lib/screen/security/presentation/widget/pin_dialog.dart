import 'package:flutter/material.dart';
import 'package:password/core/widgets/num_pad.dart';

class PinDialog extends StatefulWidget {
  const PinDialog({super.key, required this.onDone});

  final Function(String) onDone;

  @override
  State<PinDialog> createState() => _PinDialogState();
}

class _PinDialogState extends State<PinDialog> {
  late TextEditingController _controller;
  late String pin;
  bool error = false;
  String label = "Enter New Pin (4-digits)";

  @override
  void initState() {
    pin = "";
    _controller = TextEditingController()
      ..addListener(() {
        setState(() {
          error = false;
        });
      });
    super.initState();
  }

  void check() async {
    if (_controller.text == pin) {
      widget.onDone.call(pin);
    } else {
      error = true;
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 200));
      reset();
    }
  }

  void reset() async {
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _controller.text,
                style: TextStyle(fontSize: 20, color: error ? Colors.red : null),
              ),
            ),
            NumPad(
              delete: () {
                _controller.text.isNotEmpty ? _controller.text = _controller.text.substring(0, _controller.text.length - 1) : null;
              },
              onSubmit: () {
                if (pin.isEmpty) {
                  pin = _controller.text;
                  label = "Confirm (re-enter pin)";
                  reset();
                } else {
                  check();
                }
              },
              controller: _controller,
            ),
          ],
        ),
      ),
    );
  }
}
