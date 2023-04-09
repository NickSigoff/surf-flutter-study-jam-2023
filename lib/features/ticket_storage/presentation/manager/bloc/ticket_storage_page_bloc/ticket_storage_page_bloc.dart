import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ticket_storage_page_event.dart';

part 'ticket_storage_page_state.dart';

class TicketStoragePageBloc
    extends Bloc<TicketStoragePageEvent, TicketStoragePageState> {
  TicketStoragePageBloc()
      : super(TicketStoragePageSuccess(isBottomSheetExtended: false)) {
    on<AddTicketToListEvent>((event, emit) {
      _onSwitchBottomSheet(event, emit);
    });
  }

  void _onSwitchBottomSheet(
      AddTicketToListEvent event, Emitter<TicketStoragePageState> emit) {
    print(1);
  }
}
