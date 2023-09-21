import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/core/utiles/validation.dart';
import 'package:password/core/widgets/common_field.dart';
import 'package:password/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:password/features/sign_up/presentation/bloc/sign_up_event.dart';
import 'package:password/features/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:password/features/sign_up/presentation/widgets/error_msg.dart';
import 'package:password/features/sign_up/presentation/widgets/have_account_text.dart';
import 'package:password/features/sign_up/presentation/widgets/sign_up_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  late TextEditingController email, name, password, phone, confirmPassword;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    email = TextEditingController();
    name = TextEditingController();
    password = TextEditingController();
    phone = TextEditingController();
    confirmPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Password Saver",
          style: TextStyle(),
        ),
      ),
      body: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, size) {
              return SizedBox(
                height: size.maxHeight,
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: ErrorMsg(isError: state.error),
                        ),
                        Flexible(
                          child: CommonField(
                            controller: name,
                            label: "Name",
                            validation: validateName,
                          ),
                        ),
                        Flexible(
                          child: CommonField(
                            controller: email,
                            label: "Email",
                            validation: validateEmail,
                          ),
                        ),
                        Flexible(
                            child: CommonField(
                          controller: phone,
                          label: "Phone no.",
                          validation: validatePhone,
                        )),
                        Flexible(
                          child: CommonField(
                            controller: password,
                            label: 'Password',
                            validation: validatePassword,
                          ),
                        ),
                        Flexible(
                          child: CommonField(
                            controller: confirmPassword,
                            label: "Confirm Password",
                            arg: password.text,
                            validation: validateConfirmPassword,
                          ),
                        ),
                        Flexible(
                          child: HaveAccountText(
                            tap: () {
                              Navigator.pushReplacementNamed(context, signInPageRoute);
                            },
                          ),
                        ),
                        Flexible(
                          child: SignUpButton(
                            onPressed: () {
                              setState(() {
                                formKey.currentState!.validate();
                              });
                              context.read<SignUpBloc>().add(
                                    OnSignUpEvent(
                                        email: email.text,
                                        password: password.text,
                                        phone: phone.text,
                                        name: name.text,
                                        confirmPassword: confirmPassword.text,
                                        onDone: () {
                                          Navigator.pushReplacementNamed(context, homePageRoute);
                                        }),
                                  );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
