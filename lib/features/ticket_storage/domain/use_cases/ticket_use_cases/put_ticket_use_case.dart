import 'package:dartz/dartz.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/models/ticket_model.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../repositories/ticket_repository.dart';

class PutTicket extends UseCaseWithParam<bool, PutTicketParams> {
  final TicketRepository _ticketRepository;

  PutTicket({required TicketRepository ticketRepository})
      : _ticketRepository = ticketRepository;

  @override
  Future<Either<Failure, bool>> call(params) async {
    return await _ticketRepository.putTicket(params.ticket);
  }
}

class PutTicketParams {
  final TicketModel ticket;

  PutTicketParams({required this.ticket});
}
