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
      final tickets = boxTickets.get('tickets');
      List<TicketModel> result = [];
      if (tickets != null) {
        for (int i = 0; i < tickets.length; i++) {
          result.add(TicketModel(
              url: tickets[i]['url'],
              status: _getStatus(tickets[i]['status'])));
        }
      }
      return result;
    } catch (e) {
      throw HiveException(e.toString());
    }
  }

  @override
  Future<TicketModel> getTicket() {
    // TODO: implement getTicket
    throw UnimplementedError();
  }

  @override
  Future<void> putTicket(TicketModel ticket) async {
    try {
      final boxTickets = await Hive.openBox('Tickets');
      final tickets = boxTickets.get('tickets');
      if (tickets == null) {
        await boxTickets.put('tickets', [ticket.toJson()]);
      } else {
        tickets.add(ticket.toJson());
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
