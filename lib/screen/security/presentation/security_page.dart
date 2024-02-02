import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/screen/security/presentation/bloc/security_bloc.dart';
import 'package:password/screen/security/presentation/bloc/security_event.dart';
import 'package:password/screen/security/presentation/bloc/security_state.dart';
import 'package:password/screen/security/presentation/widget/pin_dialog.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  void setPin(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PinDialog(
        onDone: (pin) {
          Navigator.pop(context);
          context.read<SecurityBloc>().add(SetPinSecurityEvent(pin));
        },
      ),
    );
  }

  void getPin(BuildContext context) {
    context.read<SecurityBloc>().add(const GetPinSecurityEvent());
  }

  void deletePin(BuildContext context) {
    context.read<SecurityBloc>().add(const DeletePinSecurityEvent());
  }

  @override
  Widget build(BuildContext context) {
    getPin(context);
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      appBar: AppBar(
        title: const Text('Security'),
      ),
      body: BlocBuilder<SecurityBloc, SecurityState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Set Pin Code"),
                    Switch(
                      value: state.isSetPin,
                      onChanged: (value) {
                        if (value) {
                          setPin(context);
                        } else {
                          deletePin(context);
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
