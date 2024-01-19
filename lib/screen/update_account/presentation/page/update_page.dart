import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/features/password_generator/presentation/page/password_generator_page.dart';
import 'package:password/features/show_accounts_list/domain/entities/show_account.dart';
import 'package:password/screen/update_account/presentation/bloc/update_bloc.dart';
import 'package:password/screen/update_account/presentation/bloc/update_event.dart';
import 'package:password/screen/update_account/presentation/widget/save_button.dart';
import 'package:password/screen/update_account/presentation/widget/update_field.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<StatefulWidget> createState() => _UpdatePage();
}

class _UpdatePage extends State<UpdatePage> {
  _UpdatePage();

  late final TextEditingController _email, _userName, _password, _websiteURL;

  late bool _editPassword, _editUserName, _editWebsiteUrl;
  late bool _copyPassword, _copyEmail, _copyUserName, _copyWebsiteUrl;

  final _key = GlobalKey<FormState>();
  late ShowAccount args;

  @override
  void initState() {
    _email = TextEditingController();
    _userName = TextEditingController();
    _password = TextEditingController();
    _websiteURL = TextEditingController();
    _editPassword = _editUserName = _editWebsiteUrl = false;
    _copyUserName = _copyPassword = _copyEmail = _copyWebsiteUrl = false;
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as ShowAccount;
    context.read<UpdateBloc>().add(
      Set(
        email: args.email,
        password: args.password,
        userName: args.userName,
        websiteURL: args.websiteURL,
        title: args.title,
        onDone: () {},
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(args.title),
              UpdateField(
                controller: _email,
                copy: _copyEmail,
                label: 'Email',
                funCopy: () {
                  setState(() {
                    _copyEmail = true;
                    _copyUserName = _copyPassword = _copyWebsiteUrl = false;
                  });
                },
              ),
              UpdateField(
                controller: _userName,
                edit: _editUserName,
                copy: _copyUserName,
                label: 'User Name',
                funCopy: () {
                  setState(() {
                    _copyUserName = true;
                    _copyPassword = _copyEmail = _copyWebsiteUrl = false;
                  });
                },
                funEdit: () {
                  setState(() {
                    _editUserName = _editUserName ? false : true;
                    _editPassword = _editWebsiteUrl = false;
                  });
                },
              ),
              UpdateField(
                controller: _websiteURL,
                edit: _editWebsiteUrl,
                copy: _copyWebsiteUrl,
                label: 'Website URL',
                funCopy: () {
                  setState(() {
                    _copyWebsiteUrl = true;
                    _copyPassword = _copyEmail = _copyUserName = false;
                  });
                },
                funEdit: () {
                  setState(() {
                    _editWebsiteUrl = _editWebsiteUrl ? false : true;
                    _editPassword = _editUserName = false;
                  });
                },
              ),
              UpdateField(
                controller: _password,
                edit: _editPassword,
                copy: _copyPassword,
                label: 'Password',
                funCopy: () {
                  setState(() {
                    _copyPassword = true;
                    _copyUserName = _copyEmail = _copyWebsiteUrl = false;
                  });
                },
                funEdit: () {
                  setState(() {
                    _editPassword = _editPassword ? false : true;
                    _editUserName = _editWebsiteUrl = false;
                  });
                },
              ),
              Visibility(
                visible: _editPassword,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: PasswordGeneratorPage(
                    generatePassword: (password) {
                      setState(() {
                        _password.text = password;
                      });
                    },
                  ),
                ),
              ),
              SaveButton(
                originalStrings: [args.password, args.userName, args.websiteURL],
                newStrings: [_password.text, _userName.text, _websiteURL.text],
                onClick: () => context.read<UpdateBloc>().add(
                      OnUpdate(
                        password: _password.text,
                        userName: _userName.text,
                        email: _email.text,
                        title: args.title,
                        websiteURL: _websiteURL.text,
                        onDone: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
