import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/ticket_model.dart';

abstract class TicketRepository {
  Future<Either<Failure, List<TicketModel>>> getAllTickets();

  Future<Either<Failure, bool>> putTicket(TicketModel ticket);

  Future<Either<Failure, bool>> putAllTickets(List<TicketModel> ticket);
}
