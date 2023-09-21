import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/features/home/presentation/page/home_page.dart';
import 'package:password/injection_container.dart';

import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/save_data/presentation/bloc/save_bloc.dart';
import '../../features/save_data/presentation/page/save_page.dart';

List<BlocProvider> getBloc(){
  return [
    BlocProvider(
      create: (_) => sl<SaveBloc>(),
      child: SavePage(),
    ),
    BlocProvider(
      create: (_) => sl<HomeBloc>(),
      child: const HomePage(),
    )
  ];
}