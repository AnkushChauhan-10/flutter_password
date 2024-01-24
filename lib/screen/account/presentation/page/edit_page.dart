import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:password/core/utiles/NetworkConnectivityController.dart';
import 'package:password/core/utiles/utility.dart';
import 'package:password/core/utiles/validation.dart';
import 'package:password/core/widgets/common_field.dart';
import 'package:password/features/password_generator/presentation/page/password_generator_page.dart';
import 'package:password/features/show_accounts_list/domain/entities/show_account.dart';
import 'package:password/screen/account/presentation/bloc/edit_bloc.dart';
import 'package:password/screen/account/presentation/bloc/edit_event.dart';
import 'package:password/screen/account/presentation/bloc/edit_state.dart';
import 'package:password/screen/save_data/presentation/widgets/save_button.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<StatefulWidget> createState() => _EditPage();
}

class _EditPage extends State<EditPage> {
  final TextEditingController _userName = TextEditingController(), _password = TextEditingController();

  final _key = GlobalKey<FormState>();

  late ShowAccount account;
  bool enablePass = false, enableName = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ShowAccount;
    account = args;
    _userName.text = _userName.text.isEmpty ? account.userName : _userName.text;
    _password.text = _password.text.isEmpty ? account.password : _password.text;
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: Text(account.title),
      ),
      body: BlocBuilder<EditBloc, EditState>(
        builder: (context, state) {
          return Form(
            key: _key,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: CommonField(
                            controller: _userName,
                            label: "User Id",
                            validation: validateName,
                            enable: enableName,
                          ),
                        ),
                        IconButton(onPressed: () => context.read<EditBloc>().copy(_userName.text), icon: const Icon(Icons.copy)),
                        IconButton(
                          onPressed: () {
                            enableName = enableName ? false : true;
                            setState(() {});
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: CommonField(
                            controller: _password,
                            label: "Password",
                            validation: validatePassword,
                            enable: enablePass,
                          ),
                        ),
                        IconButton(onPressed: () => context.read<EditBloc>().copy(_password.text), icon: const Icon(Icons.copy)),
                        IconButton(
                          onPressed: () {
                            enablePass = enablePass ? false : true;
                            setState(() {});
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    PasswordGeneratorPage(
                      generatePassword: (password) {
                        setState(() {
                          enablePass ? _password.text = password : null;
                        });
                        print("=========================>>>> $password");
                      },
                    ),
                    GetBuilder<NetworkConnectivityController>(builder: (ctrl) {
                      return Opacity(
                        opacity: ctrl.connection ? 1 : 0.4,
                        child: SaveButton(
                          onPressed: ctrl.connection
                              ? () {
                                  _key.currentState?.validate();
                                  if (_userName.text != account.userName || _password.text != account.password) {
                                    context.read<EditBloc>().add(
                                          OnEdit(
                                            title: account.title,
                                            password: _password.text,
                                            userName: _userName.text,
                                            onDone: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        );
                                  }
                                }
                              : () => Utility.toastMessage(title: "Network Error", message: "Please Check your network connection and try again!"),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
