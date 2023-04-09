import 'package:get_it/get_it.dart';
import 'di_bloc.dart' as bloc;

final getIt = GetIt.instance;

init() {
  bloc.setupBloc();
}
