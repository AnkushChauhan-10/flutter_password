import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:password/core/utiles/data_base_helper.dart';
import 'package:password/core/utiles/network_connectivity.dart';
import 'package:password/features/delete/data/data_source/local_delete_data_source.dart';
import 'package:password/features/delete/data/data_source/remote_delete_data_source.dart';
import 'package:password/features/delete/data/repository/delete_repository_impelementation.dart';
import 'package:password/features/delete/domain/repository/delete_repository.dart';
import 'package:password/features/delete/domain/use_case/delete.dart';
import 'package:password/features/delete/presentation/provider/delete_provider.dart';
import 'package:password/features/fetch/fetch_controller.dart';
import 'package:password/features/password_generator/presentation/bloc/generate_password_bloc.dart';
import 'package:password/features/show_accounts_list/data/data_source/show_account_list_local_data_source.dart';
import 'package:password/features/show_accounts_list/data/data_source/show_account_list_remote_data_source.dart';
import 'package:password/features/show_accounts_list/data/repository/show_accounts_list_repository_impelentation.dart';
import 'package:password/features/show_accounts_list/domain/repository/show_accounts_list_repository.dart';
import 'package:password/features/show_accounts_list/domain/use_case/get_account_list.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_bloc.dart';
import 'package:password/features/sign_out/data/data_source/local_sign_out_data_source.dart';
import 'package:password/features/sign_out/data/repository/sign_out_repository_implementation.dart';
import 'package:password/features/sign_out/domain/repository/sign_out_repository.dart';
import 'package:password/features/sign_out/domain/use_case/sign_out.dart';
import 'package:password/features/sign_out/presentation/provider/sign_out_provider.dart';
import 'package:password/screen/account/data/data_source/save_data_offline_repo.dart';
import 'package:password/screen/account/data/data_source/save_data_source_repo.dart';
import 'package:password/screen/account/data/repository/save_repository_implementation.dart';
import 'package:password/screen/account/domain/repository/save_repo.dart';
import 'package:password/screen/account/domain/use_case/save_data.dart';
import 'package:password/screen/account/presentation/bloc/edit_bloc.dart';
import 'package:password/screen/home/data/data_source/home_data_source.dart';
import 'package:password/screen/home/data/data_source/home_remote_data_source.dart';
import 'package:password/screen/home/data/repository/home_repo_impelentation.dart';
import 'package:password/screen/home/domain/repository/home_repo.dart';
import 'package:password/screen/home/domain/use_case/users_list.dart';
import 'package:password/screen/home/presentation/bloc/home_bloc.dart';
import 'package:password/screen/lock_screen/data/lock_repository.dart';
import 'package:password/screen/save_data/data/data_source/save_data_offline_repo.dart';
import 'package:password/screen/save_data/data/data_source/save_data_source_repo.dart';
import 'package:password/screen/save_data/data/repository/save_repository_implementation.dart';
import 'package:password/screen/save_data/domain/repository/save_repo.dart';
import 'package:password/screen/save_data/domain/use_case/save_data.dart';
import 'package:password/screen/save_data/presentation/bloc/save_bloc.dart';
import 'package:password/screen/security/data/pin_data_source.dart';
import 'package:password/screen/security/data/pin_repo_implementation.dart';
import 'package:password/screen/security/domain/repository.dart';
import 'package:password/screen/security/domain/use_case.dart';
import 'package:password/screen/security/presentation/bloc/security_bloc.dart';
import 'package:password/screen/sign_in/data/data_source/sign_in_data_source.dart';
import 'package:password/screen/sign_in/data/data_source/sign_in_local_source.dart';
import 'package:password/screen/sign_in/data/repository/sign_in_repository_implementation.dart';
import 'package:password/screen/sign_in/domain/repository/sign_in_repository.dart';
import 'package:password/screen/sign_in/domain/use_case/sign_in.dart';
import 'package:password/screen/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:password/screen/sign_up/data/data_source/sign_up_data_source.dart';
import 'package:password/screen/sign_up/data/data_source/sign_up_local_source.dart';
import 'package:password/screen/sign_up/data/repository/sing_up_repository_implementation.dart';
import 'package:password/screen/sign_up/domain/repository/sign_up_repo.dart';
import 'package:password/screen/sign_up/domain/use_case/sign_up.dart';
import 'package:password/screen/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:password/screen/splash/data/data_source/splash_local_data_source.dart';
import 'package:password/screen/splash/data/repository/splash_repository_implementation.dart';
import 'package:password/screen/splash/domain/repository/splash_repository.dart';
import 'package:password/screen/splash/domain/use_case/is_user_logged_in.dart';
import 'package:password/screen/splash/presentation/bloc/splash_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final db = await getDB();
  final DataBaseHelper dataBaseHelper = DataBaseHelper(database: db);
  final sharedPreferences = await SharedPreferences.getInstance();

  ///====================================== Splash Page Dependency ==========================================
  sl.registerFactory(
    () => SplashBloc(
      isUserLoggedIn: sl(),
      isLockSet: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => IsLockSet(
      splashRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => IsUserLoggedIn(
      splashRepository: sl(),
    ),
  );
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImplementation(
      splashLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<SplashLocalDataSource>(
    () => SplashLocalDataSourceImplementation(sharedPreferences: sharedPreferences),
  );

  ///====================================== Save Data Dependency =============================================
  //-----------bloc ( SaveBloc() )
  sl.registerFactory(
    () => SaveBloc(
      saveData: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SaveData(
      saveRepo: sl(),
    ),
  );
  sl.registerLazySingleton<SaveRepository>(
    () => SaveRepoImplementation(
      saveDataSourceRepo: sl(),
      saveDataOfflineRepo: sl(),
      networkConnectivity: const NetworkConnectivity(),
    ),
  );
  sl.registerLazySingleton<SaveDataOfflineRepo>(
    () => SaveDataOfflineRepoImplementation(
      dataBase: dataBaseHelper,
      sharedPreferences: sharedPreferences,
    ),
  );
  sl.registerLazySingleton<SaveDataSourceRepo>(
    () => SaveDataSourceRepoImplementation(
      fireStore: sl(),
    ),
  );

  ///===================================== Home Dependency ========================================================
  //----------------bloc ( HomeBloc() )
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(getUsers: sl(), getLoggedUser: sl(), changeAccount: sl()),
  );
  sl.registerLazySingleton(
    () => GetLoggedUser(
      homeRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetUsers(
      homeRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => ChangeAccount(
      homeRepository: sl(),
    ),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepoImplementation(
      homeRemoteDataSource: sl(),
      homeDataSource: sl(),
      networkConnectivity: const NetworkConnectivity(),
    ),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImplementation(
      fireStore: sl(),
    ),
  );
  sl.registerLazySingleton<HomeDataSource>(
    () => HomeDataSourceImplementation(
      sharedPreferences: sharedPreferences,
      dataBase: dataBaseHelper,
    ),
  );

  ///======================================= Sign Up Dependency ====================================================
  //------------------bloc
  sl.registerFactory(
    () => SignUpBloc(
      signUp: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SignUp(
      singUpRepository: sl(),
    ),
  );
  sl.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImplementation(
      signUpDataSource: sl(),
      signUpLocalSource: sl(),
      networkConnectivity: const NetworkConnectivity(),
    ),
  );
  sl.registerLazySingleton<SignUpDataSource>(
    () => SignUpDataSourceImplementation(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance,
    ),
  );
  sl.registerLazySingleton<SignUpLocalSource>(
    () => SignUpLocalSourceImplementation(
      sharedPreferences: sharedPreferences,
      db: dataBaseHelper,
    ),
  );

  ///======================================= Sign In Dependency ====================================================
  //------------------bloc
  sl.registerFactory(
    () => SignInBloc(
      signIn: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SignIn(
      signInRepository: sl(),
    ),
  );
  sl.registerLazySingleton<SignInRepository>(
    () => SignInRepositoryImplementation(
      signInDataSource: sl(),
      signInLocalSource: sl(),
      networkConnectivity: const NetworkConnectivity(),
    ),
  );
  sl.registerLazySingleton<SignInDataSource>(
    () => SignInDataSourceImplementation(
      firebaseAuth: sl(),
      firebaseFirestore: FirebaseFirestore.instance,
    ),
  );
  sl.registerLazySingleton<SignInLocalSource>(
    () => SignInLocalSourceImplementation(
      sharedPreferences: sharedPreferences,
      db: dataBaseHelper,
    ),
  );

  ///======================================= Delete Dialog Dependency ==============================================
  sl.registerFactory(
    () => DeleteProvider(
      delete: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => Delete(
      deleteRepository: sl(),
    ),
  );
  sl.registerLazySingleton<DeleteRepository>(
    () => DeleteRepositoryImplementation(
      remoteDeleteDataSource: sl(),
      localDeleteDataSource: sl(),
      networkConnectivity: const NetworkConnectivity(),
    ),
  );
  sl.registerLazySingleton<RemoteDeleteDataSource>(
    () => RemoteDeleteDataSourceImplementation(
      firebaseFirestore: FirebaseFirestore.instance,
    ),
  );
  sl.registerLazySingleton<LocalDeleteDataSource>(
    () => LocalDeleteDataSourceImplementation(
      sharedPreferences: sharedPreferences,
      database: dataBaseHelper,
    ),
  );

  ///======================================= Show Accounts List Dependency =========================================
  sl.registerFactory(
    () => ShowAccountsListBloc(
      getShowAccountsList: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetShowAccountsList(
      showAccountsListRepository: sl(),
    ),
  );
  sl.registerLazySingleton<ShowAccountsListRepository>(
    () => ShowAccountsListRepositoryImplementation(
      showAccountsListRemoteDataSource: sl(),
      showAccountsListLocalDataSource: sl(),
      networkConnectivity: const NetworkConnectivity(),
    ),
  );
  sl.registerLazySingleton<ShowAccountsListLocalDataSource>(
    () => ShowAccountsListLocalDataSourceImplementation(
      sharedPreferences: sharedPreferences,
      dataBase: dataBaseHelper,
    ),
  );
  sl.registerLazySingleton<ShowAccountsListRemoteDataSource>(
    () => ShowAccountsListRemoteDataSourceImplementation(fireStore: FirebaseFirestore.instance),
  );

  ///======================================= Sign Out Dependency ==================================================
  sl.registerFactory(
    () => SignOutProvider(
      signOut: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SignOut(
      signOutRepository: sl(),
    ),
  );
  sl.registerLazySingleton<SignOutRepository>(
    () => SignOutRepositoryImplementation(
      localSignOutDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<LocalSignOutDataSource>(
    () => LocalSignOutDataSourceImplementation(
      sharedPreferences: sharedPreferences,
      dataBaseHelper: dataBaseHelper,
    ),
  );

  ///====================================== Edit Data Dependency =============================================
  //-----------bloc ( SaveBloc() )
  sl.registerFactory(
    () => EditBloc(
      editData: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => EditData(
      editRepo: sl(),
    ),
  );
  sl.registerLazySingleton<EditRepository>(
    () => EditRepoImplementation(
      editDataSourceRepo: sl(),
      editDataOfflineRepo: sl(),
      networkConnectivity: const NetworkConnectivity(),
    ),
  );
  sl.registerLazySingleton<EditDataOfflineRepo>(
    () => EditDataOfflineRepoImplementation(
      dataBase: dataBaseHelper,
      sharedPreferences: sharedPreferences,
    ),
  );
  sl.registerLazySingleton<EditDataSourceRepo>(
    () => EditDataSourceRepoImplementation(
      fireStore: sl(),
    ),
  );

  ///======================================= Security Bloc ======================================================
  sl.registerFactory(() => SecurityBloc(pin: sl(), setPin: sl(), deletePin: sl()));
  sl.registerLazySingleton(() => Pin(pinRepository: sl()));
  sl.registerLazySingleton(() => SetPin(pinRepository: sl()));
  sl.registerLazySingleton(() => DeletePin(pinRepository: sl()));
  sl.registerLazySingleton<PinRepository>(() => PinRepoImplementation(pinDataSource: sl()));
  sl.registerLazySingleton<PinDataSource>(() => PinDataSourceImplementation(sharedPreferences: sharedPreferences));

  ///======================================= Generate Password Bloc ==============================================

  sl.registerFactory(() => GeneratePasswordBloc());

  ///======================================= External Dependency ==================================================
  //-------------Fire Store -------------------------------
  await Firebase.initializeApp();
  FirebaseAuth.instance;
  await FirebaseAuth.instance.setSettings(
    forceRecaptchaFlow: false,
  );
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => LockRepository(sharedPreferences: sharedPreferences));
  Get.put(
    FetchController(
      dataBaseHelper: dataBaseHelper,
      firestore: sl(),
      networkConnectivity: const NetworkConnectivity(),
      sharedPreferences: sharedPreferences,
    ),
  );
}
