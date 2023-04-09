import '../../models/ticket_model.dart';

abstract class TicketLocalDataSource {
  Future<List<TicketModel>> getAllTickets();

  Future<void> putTicket(TicketModel ticket);

  Future<void> putAllTickets(List<TicketModel> ticket);
}
