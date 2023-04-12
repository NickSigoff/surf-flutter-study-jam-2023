part of 'ticket_bloc.dart';

@immutable
abstract class TicketState {}

class TicketInitial extends TicketState {}

class TicketLoading extends TicketState {
  final double progress;
  final int contentLength;
  final int downloadedLength;

  TicketLoading(this.progress, this.contentLength, this.downloadedLength);
}

class TicketLoaded extends TicketState {
  final String filePath;

  TicketLoaded(this.filePath);
}

class TicketError extends TicketState {}
