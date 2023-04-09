import 'package:surf_flutter_study_jam_2023/core/file_status.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/data_sources/local_data_source/ticket_local_data_source.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/models/ticket_model.dart';
import 'package:hive/hive.dart';

import '../../../../../core/exceptions/hive_exception.dart';

class TicketLocalDataSourceImpl implements TicketLocalDataSource {
  @override
  Future<List<TicketModel>> getAllTickets() async {
    try {
      final boxTickets = await Hive.openBox('Tickets');
      final Map? tickets = boxTickets.get('tickets');
      List<TicketModel> result = [];
      if (tickets != null) {
        for (final value in tickets.values) {
          result.add(TicketModel(
              url: value['url'],
              status: _getStatus(value['status']),
              ticketName: value['ticketName']));
        }
      }
      return result;
    } catch (e) {
      throw HiveException(e.toString());
    }
  }

  @override
  Future<void> putAllTickets(List<TicketModel> ticket) async {
    try {
      final boxTickets = await Hive.openBox('Tickets');

      Map<String, dynamic> ticketsMap = {};
      for (final ticketModel in ticket) {
        ticketsMap[ticketModel.url] = ticketModel.toJson();
      }
      boxTickets.put('tickets', ticketsMap);
    } catch (e) {
      throw HiveException(e.toString());
    }
  }

  @override
  Future<void> putTicket(TicketModel ticket) async {
    try {
      final boxTickets = await Hive.openBox('Tickets');
      final tickets = boxTickets.get('tickets');
      if (tickets == null) {
        Map<String, dynamic> map = {ticket.url: ticket.toJson()};
        await boxTickets.put('tickets', map);
      } else {
        tickets[ticket.url] = ticket.toJson();
        boxTickets.put('tickets', tickets);
      }
    } catch (e) {
      throw HiveException(e.toString());
    }
  }

  FileStatus _getStatus(ticket) {
    switch (ticket) {
      case 'uploaded':
        return FileStatus.uploaded;
      case 'inProgress':
        return FileStatus.inProgress;
      default:
        return FileStatus.notUploaded;
    }
  }
}
