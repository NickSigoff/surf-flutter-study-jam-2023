import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/presentation/manager/bloc/ticket_storage_page_bloc/ticket_storage_page_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/presentation/widgets/ticket_storage_page_widgets/bottom_sheet_widget.dart';

import '../../../../core/app_locale.dart';
import '../widgets/ticket_storage_page_widgets/ticket_widget.dart';

/// Экран “Хранения билетов”.
class TicketStoragePage extends StatefulWidget {
  const TicketStoragePage({Key? key}) : super(key: key);

  @override
  State<TicketStoragePage> createState() => _TicketStoragePageState();
}

class _TicketStoragePageState extends State<TicketStoragePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        final maxOffset = _scrollController.position.maxScrollExtent;
        final scrollOffset = _scrollController.offset;
        if (scrollOffset >= maxOffset) {
          context.read<TicketStoragePageBloc>().add(HideFloatingButtonEvent());
        }
      });
    context.read<TicketStoragePageBloc>().add(CreateTicketPageEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicketStoragePageBloc, TicketStoragePageState>(
      listener: (context, state) {
        if (state is TicketStoragePageError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 5),
              backgroundColor: Theme.of(context).colorScheme.error,
              content: Text(state.errorMessage),
            ),
          );
        }
      },
      buildWhen: (oldState, newState) => newState is! TicketStoragePageError,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocale.of(context).ticketStoring),
          ),
          resizeToAvoidBottomInset: true,
          body: _buildBody(state),
          floatingActionButton: state is TicketStoragePageSuccess
              ? state.isFloatingButtonVisible
                  ? _buildFloatingActionButton(context)
                  : const SizedBox()
              : _buildFloatingActionButton(context),
        );
      },
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return SizedBox(
      width: 100,
      child: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            builder: (context) => const BottomSheetWidget(),
          );
        },
        isExtended: true,
        child: Text(AppLocale.of(context).add),
      ),
    );
  }

  Widget _buildTicketsList(TicketStoragePageSuccess state) {
    if (state.tickets.isEmpty) {
      return Center(
        child: Text(AppLocale.of(context).isNothingHere),
      );
    }
    return NotificationListener(
      onNotification: (t) {
        final maxOffset = _scrollController.position.maxScrollExtent;
        final scrollOffset = _scrollController.offset;
        if (scrollOffset < maxOffset) {
          context.read<TicketStoragePageBloc>().add(ShowFloatingButtonEvent());
        }
        return true;
      },
      child: ListView.builder(
          controller: _scrollController,
          itemCount: state.tickets.length,
          itemBuilder: (context, index) =>
              TicketWidget(ticket: state.tickets[index], index: index)),
    );
  }

  Widget _buildBody(TicketStoragePageState state) {
    if (state is TicketStoragePageLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is TicketStoragePageSuccess) {
      return _buildTicketsList(state);
    }
    return const SizedBox();
  }
}
