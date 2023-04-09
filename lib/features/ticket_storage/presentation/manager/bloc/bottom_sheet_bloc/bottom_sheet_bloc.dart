import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:regexed_validator/regexed_validator.dart';

part 'bottom_sheet_event.dart';

part 'bottom_sheet_state.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  final _urlPattern =
      r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";

  BottomSheetBloc() : super(BottomSheetInitial()) {
    on<PressAddButtonEvent>((event, emit) async {
      await _onPressAddButton(event, emit);
    });
  }

  Future<void> _onPressAddButton(
      PressAddButtonEvent event, Emitter<BottomSheetState> emit) async {
    emit(BottomSheetLoading());
    RegExp regExp = RegExp(_urlPattern);
    if (validator.email(event.url)) {
      emit(BottomSheetError());
      await Future.delayed(const Duration(seconds: 2));
      emit(BottomSheetInitial());
    } else {
      emit(BottomSheetSuccess(event.url));
    }
  }
}
