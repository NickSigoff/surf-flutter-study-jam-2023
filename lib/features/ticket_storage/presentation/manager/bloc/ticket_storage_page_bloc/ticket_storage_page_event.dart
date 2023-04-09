part of 'ticket_storage_page_bloc.dart';

@immutable
abstract class TicketStoragePageEvent {}

class AddTicketToListEvent extends TicketStoragePageEvent {
  final String url;

  AddTicketToListEvent(this.url);
}
