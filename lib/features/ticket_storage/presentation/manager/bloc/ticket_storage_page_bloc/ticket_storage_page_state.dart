part of 'ticket_storage_page_bloc.dart';

@immutable
abstract class TicketStoragePageState {}

class TicketStoragePageSuccess extends TicketStoragePageState {
  final bool isBottomSheetExtended;

  TicketStoragePageSuccess({required this.isBottomSheetExtended});

  TicketStoragePageSuccess copyWith({bool? isBottomSheetExtended}) {
    return TicketStoragePageSuccess(
      isBottomSheetExtended:
          isBottomSheetExtended ?? this.isBottomSheetExtended,
    );
  }
}

class TicketStoragePageLoading extends TicketStoragePageState {}

class TicketStoragePageError extends TicketStoragePageState {}
