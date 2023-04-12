part of 'ticket_bloc.dart';

@immutable
abstract class TicketEvent {}

class LoadEvent extends TicketEvent {
  final TicketModel ticket;

  LoadEvent(this.ticket);
}

class StopLoadEvent extends TicketEvent {}

class SetInitialValueEvent extends TicketEvent {
  final TicketModel ticket;

  SetInitialValueEvent(this.ticket);
}
