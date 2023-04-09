import 'package:get_it/get_it.dart';
import 'di_bloc.dart' as bloc;
import 'di_data_sources.dart' as data_sources;
import 'di_repositories.dart' as repositories;
import 'di_use_cases.dart' as use_cases;

final getIt = GetIt.instance;

init() {
  bloc.setupBloc();
  data_sources.setupDataSources();
  repositories.setupRepositories();
  use_cases.setupUseCases();
}
