import 'package:dartz/dartz.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/models/ticket_model.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../repositories/ticket_repository.dart';

class UpdateTicket extends UseCaseWithParam<bool, UpdateTicketParams> {
  final TicketRepository _ticketRepository;

  UpdateTicket({required TicketRepository ticketRepository})
      : _ticketRepository = ticketRepository;

  @override
  Future<Either<Failure, bool>> call(params) async {
    return await _ticketRepository.updateTicket(params.ticket);
  }
}

class UpdateTicketParams {
  final TicketModel ticket;

  UpdateTicketParams({required this.ticket});
}
