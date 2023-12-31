import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/features/password_generator/presentation/bloc/generate_password_bloc.dart';
import 'package:password/features/password_generator/presentation/page/password_generator_page.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_bloc.dart';
import 'package:password/features/show_accounts_list/presentation/page/show_accounts_list_page.dart';
import 'package:password/injection_container.dart';
import 'package:password/screen/home/presentation/bloc/home_bloc.dart';
import 'package:password/screen/home/presentation/page/home_page.dart';
import 'package:password/screen/home/presentation/page/home_page_1.dart';
import 'package:password/screen/lock_screen/presentation/page/lock_page.dart';
import 'package:password/screen/save_data/presentation/bloc/save_bloc.dart';
import 'package:password/screen/save_data/presentation/page/save_page.dart';
import 'package:password/screen/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:password/screen/sign_in/presentation/page/sign_in_page.dart';
import 'package:password/screen/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:password/screen/sign_up/presentation/page/sign_up_page.dart';
import 'package:password/screen/splash/presentation/bloc/splash_bloc.dart';
import 'package:password/screen/splash/presentation/page/splash_page.dart';
import 'package:password/service/background_update/domain/use_case/update.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  Connectivity().onConnectivityChanged.listen((result) {
    if (result.name != "none") {
      print(sl<Update>().call());
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<SplashBloc>(),
          child: const SplashPage(),
        ),
        BlocProvider(
          create: (_) => sl<SaveBloc>(),
          child: const SavePage(),
        ),
        BlocProvider(
          create: (_) => sl<HomeBloc>(),
          child: HomePage1(),
        ),
        BlocProvider(
          create: (_) => sl<SignUpBloc>(),
          child: const SignUpPage(),
        ),
        BlocProvider(
          create: (_) => sl<SignInBloc>(),
          child: const SignInPage(),
        ),
        BlocProvider(
          create: (_) => sl<ShowAccountsListBloc>(),
          child: const ShowAccountsListPage(),
        ),
        BlocProvider(
          create: (_) => sl<GeneratePasswordBloc>(),
          child: const PasswordGeneratorPage(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: splashPageRoute,
        routes: {
          splashPageRoute: (context) => const SplashPage(),
          signInPageRoute: (context) => const SignInPage(),
          signUpPageRoute: (context) => const SignUpPage(),
          lockScreenPageRoute: (context) => const LockPage(),
          homePageRoute: (context) => HomePage1(),
          savePageRoute: (context) => const SavePage(),
        },
      ),
    );
  }
}
