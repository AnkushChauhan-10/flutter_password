import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/features/save_data/presentation/bloc/save_bloc.dart';
import 'package:password/features/save_data/presentation/page/save_page.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_bloc.dart';
import 'package:password/features/show_accounts_list/presentation/page/show_accounts_list_page.dart';
import 'package:password/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:password/features/sign_in/presentation/page/sign_in_page.dart';
import 'package:password/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:password/features/sign_up/presentation/page/sign_up_page.dart';
import 'package:password/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:password/features/splash/presentation/page/splash_page.dart';
import 'package:password/injection_container.dart';
import 'package:password/screen/home/presentation/bloc/home_bloc.dart';
import 'package:password/screen/home/presentation/page/home_page.dart';
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
          child: SavePage(),
        ),
        BlocProvider(
          create: (_) => sl<HomeBloc>(),
          child: const HomePage(),
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
          homePageRoute: (context) => const HomePage(),
          signInPageRoute: (context) => const SignInPage(),
          signUpPageRoute: (context) => const SignUpPage(),
          savePageRoute: (context) => SavePage(),
        },
      ),
    );
  }
}
