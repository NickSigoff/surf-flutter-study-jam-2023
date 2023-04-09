import 'package:dartz/dartz.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/models/ticket_model.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/domain/repositories/ticket_repository.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/use_case/use_case.dart';

class GetAllTickets extends UseCaseWithoutParam<List<TicketModel>> {
  final TicketRepository _ticketRepository;

  GetAllTickets({required TicketRepository ticketRepository})
      : _ticketRepository = ticketRepository;

  @override
  Future<Either<Failure, List<TicketModel>>> call() async {
    return await _ticketRepository.getAllTickets();
  }
}
