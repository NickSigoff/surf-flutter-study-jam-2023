import 'package:dartz/dartz.dart';

import 'package:surf_flutter_study_jam_2023/core/error/failure.dart';

import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/models/ticket_model.dart';

import '../../../../core/exceptions/hive_exception.dart';
import '../../domain/repositories/ticket_repository.dart';
import '../data_sources/local_data_source/ticket_local_data_source.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketLocalDataSource _ticketLocalDataSource;

  TicketRepositoryImpl({required TicketLocalDataSource ticketLocalDataSource})
      : _ticketLocalDataSource = ticketLocalDataSource;

  @override
  Future<Either<Failure, List<TicketModel>>> getAllTickets() async {
    try {
      final ticketList = await _ticketLocalDataSource.getAllTickets();
      return Right(ticketList);
    } on HiveException catch (e) {
      return Left(HiveFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, TicketModel>> getTicket() async {
    try {
      final ticket = await _ticketLocalDataSource.getTicket();
      return Right(ticket);
    } on HiveException catch (e) {
      return Left(HiveFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> putTicket(TicketModel ticket) async {
    try {
      await _ticketLocalDataSource.putTicket(ticket);
      return const Right(true);
    } on HiveException catch (e) {
      return Left(HiveFailure(e.message));
    }
  }
}
