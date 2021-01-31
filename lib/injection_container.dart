import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:numbers_trivia_app/core/network/network_info.dart';
import 'package:numbers_trivia_app/core/presentation/util/input_converter.dart';
import 'package:numbers_trivia_app/features/number_trivia/data/datasources/number_triva_local_data_source.dart';
import 'package:numbers_trivia_app/features/number_trivia/data/datasources/number_triva_remote_data_source.dart';
import 'package:numbers_trivia_app/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:numbers_trivia_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:numbers_trivia_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:numbers_trivia_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:numbers_trivia_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  // Features - Number Trivia
  // Bloc
  getIt.registerFactory(() => NumberTriviaBloc(
        concrete: getIt(),
        random: getIt(),
        inputConverter: getIt(),
      ));
  //Use cases
  getIt.registerLazySingleton(
    () => GetConcreteNumberTrivia(repository: getIt()),
  );
  getIt.registerLazySingleton(
    () => GetRandomNumberTrivia(repository: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
        remoteDataSource: getIt(),
        localDataSource: getIt(),
        networkInfo: getIt()),
  );

  // Data Source
  getIt.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: getIt()),
  );

  getIt.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: getIt()),
  );

  // Core
  getIt.registerLazySingleton(
    () => InputConverter(),
  );

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(dataConnectionChecker: getIt()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  getIt.registerLazySingleton(() => http.Client());

  getIt.registerLazySingleton(() => DataConnectionChecker());
}
