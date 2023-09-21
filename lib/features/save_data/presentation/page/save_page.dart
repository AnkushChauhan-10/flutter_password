import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/utiles/validation.dart';
import 'package:password/core/widgets/common_field.dart';
import 'package:password/features/save_data/presentation/bloc/save_bloc.dart';
import 'package:password/features/save_data/presentation/bloc/save_event.dart';
import 'package:password/features/save_data/presentation/bloc/save_state.dart';
import 'package:password/features/save_data/presentation/widgets/save_button.dart';

class SavePage extends StatelessWidget {
  SavePage({super.key});

  final TextEditingController _siteName = TextEditingController(),
      _userId = TextEditingController(),
      _userName = TextEditingController(),
      _password = TextEditingController(),
      _confirmPassword = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Account"),
      ),
      body: BlocBuilder<SaveBloc, SaveState>(
        builder: (context, state) {
          return Form(
            key: _key,
            child: Column(
              children: [
                Flexible(
                  child: CommonField(
                    controller: _siteName,
                    label: "Site Name",
                    validation: validateName,
                  ),
                ),
                Flexible(
                  child: CommonField(
                    controller: _userId,
                    label: 'User Id',
                    validation: validateEmail,
                  ),
                ),
                Flexible(
                  child: CommonField(
                    controller: _userName,
                    label: "User Name",
                    validation: validateName,
                  ),
                ),
                Flexible(
                  child: CommonField(
                    controller: _password,
                    label: "Password",
                    validation: validatePassword,
                  ),
                ),
                Flexible(
                  child: CommonField(
                    controller: _confirmPassword,
                    label: "Confirm Password",
                    validation: validateConfirmPassword,
                    arg: _password.text,
                  ),
                ),
                Flexible(
                  child: SaveButton(
                    onPressed: () {
                      _key.currentState?.validate();
                      context.read<SaveBloc>().add(
                            OnSave(
                              siteName: _siteName.text,
                              password: _password.text,
                              userName: _userName.text,
                              id: _userId.text,
                              confirmPassword: _confirmPassword.text,
                              onDone: () {
                                Navigator.pop(context);
                              },
                            ),
                          );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
