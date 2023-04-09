import 'package:dartz/dartz.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/models/ticket_model.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/domain/repositories/ticket_repository.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/use_case/use_case.dart';

class PutAllTickets extends UseCaseWithParam<bool,PutAllTicketsParams> {
  final TicketRepository _ticketRepository;

  PutAllTickets({required TicketRepository ticketRepository})
      : _ticketRepository = ticketRepository;

  @override
  Future<Either<Failure, bool>> call(params) async {
    return await _ticketRepository.putAllTickets(params.ticket);
  }
}

class PutAllTicketsParams {
  final List<TicketModel> ticket;

  PutAllTicketsParams({required this.ticket});
}