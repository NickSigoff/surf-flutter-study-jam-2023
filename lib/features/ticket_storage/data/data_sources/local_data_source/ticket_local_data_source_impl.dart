import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/data_sources/local_data_source/ticket_local_data_source.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/models/ticket_model.dart';
import 'package:hive/hive.dart';

import '../../../../../core/exceptions/hive_exception.dart';

class TicketLocalDataSourceImpl implements TicketLocalDataSource {
  static const ticketBoxName = 'Tickets';

  @override
  Future<List<TicketModel>> getAllTickets() async {
    try {
      final boxTickets = await _getTicketBox();
      return boxTickets.values.toList();
    } catch (e) {
      throw HiveException(e.toString());
    }
  }

  @override
  Future<void> putAllTickets(List<TicketModel> ticket) async {
    try {
      final boxTickets = await _getTicketBox();
      boxTickets.clear();
      for (final ticketModel in ticket) {
        boxTickets.put(ticketModel.id, ticketModel);
      }
    } catch (e) {
      throw HiveException(e.toString());
    }
  }

  @override
  Future<void> putTicket(TicketModel ticket) async {
    try {
      final boxTickets = await _getTicketBox();
      boxTickets.add(ticket);
    } catch (e) {
      throw HiveException(e.toString());
    }
  }

  @override
  Future<void> updateTicket(TicketModel ticket) async {
    try {
      final boxTickets = await _getTicketBox();
      boxTickets.put(ticket.id, ticket);
    } catch (e) {
      throw HiveException(e.toString());
    }
  }

  Future<Box<TicketModel>> _getTicketBox() async =>
      await Hive.openBox<TicketModel>(ticketBoxName);
}
