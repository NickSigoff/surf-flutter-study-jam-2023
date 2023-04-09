import '../../models/ticket_model.dart';

abstract class TicketDataSource {
  Future<List<TicketModel>> getAllTickets();

  Future<void> putTicket(TicketModel ticket);

  Future<TicketModel> getTicket();
}
