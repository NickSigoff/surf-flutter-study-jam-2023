import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:regexed_validator/regexed_validator.dart';
import '../../../../domain/use_cases/ticket_use_cases/put_ticket_use_case.dart';

part 'bottom_sheet_event.dart';

part 'bottom_sheet_state.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  final PutTicket _putTicket;

  BottomSheetBloc(this._putTicket) : super(BottomSheetInitial()) {
    on<PressAddButtonEvent>((event, emit) async {
      await _onPressAddButton(event, emit);
    });

    on<CreateBottomSheetEvent>((event, emit) async {
      await _onCreateBottomSheet(event, emit);
    });
  }

  Future<void> _onPressAddButton(
      PressAddButtonEvent event, Emitter<BottomSheetState> emit) async {
    emit(BottomSheetLoading());
    if (validator.url(event.url)) {
      emit(BottomSheetSuccess(event.url));
    } else {
      emit(BottomSheetError());
      await Future.delayed(const Duration(seconds: 2));
      emit(BottomSheetInitial());
    }
  }

  Future<void> _onCreateBottomSheet(
      CreateBottomSheetEvent event, Emitter<BottomSheetState> emit) async {
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    String copiedData = '';
    if (data != null && data.text != null) {
      if (data.text!.contains('.pdf')) {
        copiedData = data.text!;
      }
    }
    emit(BottomSheetInitial(copiedData: copiedData));
  }
}
