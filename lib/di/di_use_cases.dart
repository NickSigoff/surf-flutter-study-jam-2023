import 'package:get_it/get_it.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/domain/use_cases/ticket_use_cases/get_all_tickets_use_case.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/domain/use_cases/ticket_use_cases/get_ticket_use_case.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/domain/use_cases/ticket_use_cases/put_ticket_use_case.dart';

final _getIt = GetIt.instance;

void setupUseCases() {
  _getIt.registerLazySingleton<GetAllTickets>(() => GetAllTickets(
        ticketRepository: _getIt(),
      ));

  _getIt.registerLazySingleton<PutTicket>(() => PutTicket(
        ticketRepository: _getIt(),
      ));

  _getIt.registerLazySingleton<GetTicket>(() => GetTicket(
        ticketRepository: _getIt(),
      ));
}
