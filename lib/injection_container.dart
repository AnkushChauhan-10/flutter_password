import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:password/core/utiles/data_base_helper.dart';
import 'package:password/core/utiles/network_connectivity.dart';
import 'package:password/features/delete/data/data_source/local_delete_data_source.dart';
import 'package:password/features/delete/data/data_source/remote_delete_data_source.dart';
import 'package:password/features/delete/data/repository/delete_repository_impelementation.dart';
import 'package:password/features/delete/domain/repository/delete_repository.dart';
import 'package:password/features/delete/domain/use_case/delete.dart';
import 'package:password/features/delete/presentation/provider/delete_provider.dart';
import 'package:password/features/save_data/data/data_source/save_data_offline_repo.dart';
import 'package:password/features/save_data/data/data_source/save_data_source_repo.dart';
import 'package:password/features/save_data/data/repository/save_repository_implementation.dart';
import 'package:password/features/save_data/domain/repository/save_repo.dart';
import 'package:password/features/save_data/domain/use_case/save_data.dart';
import 'package:password/features/save_data/presentation/bloc/save_bloc.dart';
import 'package:password/features/show_accounts_list/data/data_source/show_account_list_local_data_source.dart';
import 'package:password/features/show_accounts_list/data/data_source/show_account_list_remote_data_source.dart';
import 'package:password/features/show_accounts_list/data/repository/show_accounts_list_repository_impelentation.dart';
import 'package:password/features/show_accounts_list/domain/repository/show_accounts_list_repository.dart';
import 'package:password/features/show_accounts_list/domain/use_case/get_account_list.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_bloc.dart';
import 'package:password/features/sign_in/data/data_source/sign_in_data_source.dart';
import 'package:password/features/sign_in/data/data_source/sign_in_local_source.dart';
import 'package:password/features/sign_in/data/repository/sign_in_repository_implementation.dart';
import 'package:password/features/sign_in/domain/repository/sign_in_repository.dart';
import 'package:password/features/sign_in/domain/use_case/sign_in.dart';
import 'package:password/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:password/features/sign_up/data/data_source/sign_up_data_source.dart';
import 'package:password/features/sign_up/data/data_source/sign_up_local_source.dart';
import 'package:password/features/sign_up/data/repository/sing_up_repository_implementation.dart';
import 'package:password/features/sign_up/domain/repository/sign_up_repo.dart';
import 'package:password/features/sign_up/domain/use_case/sign_up.dart';
import 'package:password/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:password/features/splash/data/data_source/splash_local_data_source.dart';
import 'package:password/features/splash/data/repository/splash_repository_implementation.dart';
import 'package:password/features/splash/domain/repository/splash_repository.dart';
import 'package:password/features/splash/domain/use_case/is_user_logged_in.dart';
import 'package:password/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:password/screen/home/data/data_source/home_data_source.dart';
import 'package:password/screen/home/data/data_source/home_remote_data_source.dart';
import 'package:password/screen/home/data/repository/home_repo_impelentation.dart';
import 'package:password/screen/home/domain/repository/home_repo.dart';
import 'package:password/screen/home/domain/use_case/get_account_list.dart';
import 'package:password/screen/home/presentation/bloc/home_bloc.dart';
import 'package:password/service/background_update/data/data_source/local_update_data_source.dart';
import 'package:password/service/background_update/data/data_source/remote_update_data_source.dart';
import 'package:password/service/background_update/data/repository/update_repository_implementation.dart';
import 'package:password/service/background_update/domain/repository/update_repository.dart';
import 'package:password/service/background_update/domain/use_case/update.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final db = await getDB();
  final sharedPreferences = await SharedPreferences.getInstance();

  ///====================================== Splash Page Dependency ==========================================
  sl.registerFactory(() => SplashBloc(isUserLoggedIn: sl()));
  sl.registerLazySingleton(() => IsUserLoggedIn(splashRepository: sl()));
  sl.registerLazySingleton<SplashRepository>(() => SplashRepositoryImplementation(splashLocalDataSource: sl()));
  sl.registerLazySingleton<SplashLocalDataSource>(() => SplashLocalDataSourceImplementation(sharedPreferences: sharedPreferences));

  ///====================================== Save Data Dependency =============================================
  //-----------bloc ( SaveBloc() )
  sl.registerFactory(() => SaveBloc(saveData: sl()));
  sl.registerLazySingleton(() => SaveData(saveRepo: sl()));
  sl.registerLazySingleton<SaveRepository>(
      () => SaveRepoImplementation(saveDataSourceRepo: sl(), saveDataOfflineRepo: sl(), networkConnectivity: const NetworkConnectivity()));
  sl.registerLazySingleton<SaveDataOfflineRepo>(() => SaveDataOfflineRepoImplementation(dataBase: db, sharedPreferences: sharedPreferences));
  sl.registerLazySingleton<SaveDataSourceRepo>(() => SaveDataSourceRepoImplementation(fireStore: sl()));

  ///===================================== Home Dependency ========================================================
  //----------------bloc ( HomeBloc() )
  sl.registerFactory<HomeBloc>(() => HomeBloc(getUserData: sl(), signOut: sl()));
  sl.registerLazySingleton(() => SignOut(homeRepository: sl()));
  sl.registerLazySingleton(() => GetUserData(homeRepository: sl()));
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepoImplementation(homeRemoteDataSource: sl(), homeDataSource: sl(), networkConnectivity: const NetworkConnectivity()));
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImplementation(fireStore: sl()));
  sl.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImplementation(sharedPreferences: sharedPreferences, dataBase: db));

  ///======================================= Sign Up Dependency ====================================================
  //------------------bloc
  sl.registerFactory(() => SignUpBloc(signUp: sl()));
  sl.registerLazySingleton(() => SignUp(singUpRepository: sl()));
  sl.registerLazySingleton<SignUpRepository>(() => SignUpRepositoryImplementation(signUpDataSource: sl(), signUpLocalSource: sl()));
  sl.registerLazySingleton<SignUpDataSource>(
      () => SignUpDataSourceImplementation(firebaseAuth: FirebaseAuth.instance, firebaseFirestore: FirebaseFirestore.instance));
  sl.registerLazySingleton<SignUpLocalSource>(() => SignUpLocalSourceImplementation(sharedPreferences: sharedPreferences));

  ///======================================= Sign In Dependency ====================================================
  //------------------bloc
  sl.registerFactory(() => SignInBloc(signIn: sl()));
  sl.registerLazySingleton(() => SignIn(signInRepository: sl()));
  sl.registerLazySingleton<SignInRepository>(() => SignInRepositoryImplementation(signInDataSource: sl(), signInLocalSource: sl()));
  sl.registerLazySingleton<SignInDataSource>(
      () => SignInDataSourceImplementation(firebaseAuth: FirebaseAuth.instance, firebaseFirestore: FirebaseFirestore.instance));
  sl.registerLazySingleton<SignInLocalSource>(() => SignInLocalSourceImplementation(sharedPreferences: sharedPreferences));

  ///======================================= Update Data Dependency ================================================
  sl.registerFactory(() => Update(repository: sl()));
  sl.registerLazySingleton<UpdateRepository>(() => UpdateRepositoryImplementation(remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<RemoteUpdateDataSource>(() => RemoteUpdateDataSourceImplementation(fireStore: FirebaseFirestore.instance));
  sl.registerLazySingleton<LocalUpdateDataSource>(() => LocalUpdateDataSourceImplementation(sharedPreferences: sharedPreferences, dataBase: db));

  ///======================================= Delete Dialog Dependency ==============================================
  sl.registerFactory(() => DeleteProvider(delete: sl()));
  sl.registerLazySingleton(() => Delete(deleteRepository: sl()));
  sl.registerLazySingleton<DeleteRepository>(() => DeleteRepositoryImplementation(
        remoteDeleteDataSource: sl(),
        localDeleteDataSource: sl(),
        networkConnectivity: const NetworkConnectivity(),
      ));
  sl.registerLazySingleton<RemoteDeleteDataSource>(() => RemoteDeleteDataSourceImplementation(firebaseFirestore: FirebaseFirestore.instance));
  sl.registerLazySingleton<LocalDeleteDataSource>(() => LocalDeleteDataSourceImplementation(sharedPreferences: sharedPreferences, database: db));

  ///======================================= Show Accounts List Dependency =========================================
  sl.registerFactory(() => ShowAccountsListBloc(getShowAccountsList: sl()));
  sl.registerLazySingleton(() => GetShowAccountsList(showAccountsListRepository: sl()));
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
      dataBase: db,
    ),
  );
  sl.registerLazySingleton<ShowAccountsListRemoteDataSource>(
    () => ShowAccountsListRemoteDataSourceImplementation(fireStore: FirebaseFirestore.instance),
  );

  ///======================================= External Dependency ===================================================
  //-------------Fire Store -------------------------------
  await Firebase.initializeApp();
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
