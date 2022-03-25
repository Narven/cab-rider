import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'cubics/directions/direction_cubit.dart';
import 'cubics/predictions/prediction_cubit.dart';
import 'cubics/search/search_cubit.dart';
import 'data/repositories/search_repository.dart';
import 'firebase_options.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final _searchHelper = SearchRepositoryImpl();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SearchCubit(searchRepository: _searchHelper),
        ),
        BlocProvider(create: (_) => PredictionCubit(_searchHelper)),
        BlocProvider(create: (_) => DirectionCubit(_searchHelper)),
      ],
      child: const MyApp(),
    ),
  );
}
