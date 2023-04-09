import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/presentation/manager/bloc/bottom_sheet_bloc/bottom_sheet_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/presentation/manager/bloc/ticket_storage_page_bloc/ticket_storage_page_bloc.dart';

import '../../../../../core/app_locale.dart';

class BottomSheetWidget extends StatelessWidget {
  final TextEditingController _urlController = TextEditingController();

  BottomSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: BlocConsumer<BottomSheetBloc, BottomSheetState>(
        listener: (context, state) {
          if (state is BottomSheetSuccess) {
            context
                .read<TicketStoragePageBloc>()
                .add(AddTicketToListEvent(state.url));
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _urlController,
                style: TextStyle(color: Colors.black.withOpacity(.8)),
                decoration: _buildInputDecoration(
                    AppLocale.of(context).inputUrl, context, state),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                  onPressed: () => _onPressed(state, context),
                  child: state is BottomSheetLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Text(AppLocale.of(context).add))
            ],
          );
        },
      ),
    );
  }

  void _onPressed(BottomSheetState state, BuildContext context) {
    if (state is! BottomSheetError) {
      context
          .read<BottomSheetBloc>()
          .add(PressAddButtonEvent(_urlController.text));
    }
    Navigator.pop;
  }

  InputDecoration _buildInputDecoration(
      String labelText, BuildContext context, BottomSheetState state) {
    return InputDecoration(
      errorBorder: state is BottomSheetError
          ? OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 2,
              ),
            )
          : null,
      errorText: state is BottomSheetError
          ? AppLocale.of(context).inputCorrectUrl
          : null,
      fillColor: Theme.of(context).colorScheme.surface,
      helperStyle: TextStyle(color: Theme.of(context).colorScheme.error),
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
    );
  }
}
