import 'package:get_it/get_it.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/domain/repositories/ticket_repository.dart';
import '../features/ticket_storage/data/repositories/tickets_repository_impl.dart';

final _getIt = GetIt.instance;

void setupRepositories() {
  _getIt.registerLazySingleton<TicketRepository>(() => TicketRepositoryImpl(
        ticketLocalDataSource: _getIt(),
      ));
}
