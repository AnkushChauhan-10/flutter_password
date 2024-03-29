import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:password/core/utiles/NetworkConnectivityController.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/core/utiles/style.dart';
import 'package:password/features/password_generator/presentation/bloc/generate_password_bloc.dart';
import 'package:password/features/password_generator/presentation/page/password_generator_page.dart';
import 'package:password/features/theme_mode/theme_controller.dart';
import 'package:password/injection_container.dart';
import 'package:password/screen/account/presentation/bloc/edit_bloc.dart';
import 'package:password/screen/account/presentation/page/edit_page.dart';
import 'package:password/screen/home/presentation/bloc/home_bloc.dart';
import 'package:password/screen/home/presentation/page/home_page.dart';
import 'package:password/screen/save_data/presentation/bloc/save_bloc.dart';
import 'package:password/screen/save_data/presentation/page/save_page.dart';
import 'package:password/screen/security/presentation/bloc/security_bloc.dart';
import 'package:password/screen/security/presentation/security_page.dart';
import 'package:password/screen/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:password/screen/sign_in/presentation/page/sign_in_page.dart';
import 'package:password/screen/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:password/screen/sign_up/presentation/page/sign_up_page.dart';
import 'package:password/screen/splash/presentation/bloc/splash_bloc.dart';
import 'package:password/screen/splash/presentation/page/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  Get.put(NetworkConnectivityController());
  Get.lazyPut(() => ThemeModeController());
  Connectivity().onConnectivityChanged.listen((event) {
    Get.find<NetworkConnectivityController>().connection = event.name != 'none';
  });
  bool? theme = await ThemeModePreference().getTheme();
  Get.find<ThemeModeController>().darkTheme = theme;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SplashBloc>(), child: const SplashPage()),
        BlocProvider(create: (_) => sl<SaveBloc>(), child: const SavePage()),
        BlocProvider(create: (_) => sl<EditBloc>(), child: const EditPage()),
        BlocProvider(create: (_) => sl<HomeBloc>(), child: const HomePage()),
        BlocProvider(create: (_) => sl<SignUpBloc>(), child: const SignUpPage()),
        BlocProvider(create: (_) => sl<SignInBloc>(), child: const SignInPage()),
        BlocProvider(create: (_) => sl<GeneratePasswordBloc>(), child: const PasswordGeneratorPage()),
        BlocProvider(create: (_) => sl<SecurityBloc>(), child: const SecurityPage()),
      ],
      child: GetBuilder<ThemeModeController>(builder: (ctrl) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(ctrl.darkTheme, context),
          initialRoute: splashPageRoute,
          routes: {
            splashPageRoute: (context) => const SplashPage(),
            signInPageRoute: (context) => const SignInPage(),
            signUpPageRoute: (context) => const SignUpPage(),
            // lockScreenPageRoute: (context) => const LockPage(),
            homePageRoute: (context) => const HomePage(),
            savePageRoute: (context) => const SavePage(),
            editPageRoute: (context) => const EditPage(),
          },
        );
      }),
    );
  }
}
