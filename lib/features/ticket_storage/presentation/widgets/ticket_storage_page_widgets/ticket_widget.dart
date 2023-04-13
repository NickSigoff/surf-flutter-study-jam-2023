import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/core/app_locale.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/models/ticket_model.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/presentation/manager/bloc/ticket_bloc/ticket_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/presentation/manager/bloc/ticket_storage_page_bloc/ticket_storage_page_bloc.dart';

import '../../pages/pdf_page.dart';

class TicketWidget extends StatefulWidget {
  final TicketModel _ticket;
  final int _index;

  const TicketWidget(
      {super.key, required TicketModel ticket, required int index})
      : _ticket = ticket,
        _index = index;

  @override
  State<TicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  @override
  void initState() {
    context.read<TicketBloc>().add(SetInitialValueEvent(widget._ticket));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketBloc, TicketState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (state is TicketLoaded) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return PdfPage(path: state.filePath);
                }),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 5),
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: Text('Файл не загружен'),
                ),
              );
            }
          },
          child: Dismissible(
            key: ValueKey(widget._ticket.id),
            onDismissed: (direction) {
              context
                  .read<TicketStoragePageBloc>()
                  .add(RemoveTicketEvent(widget._index));
            },
            child: ListTile(
              leading: const Icon(Icons.airplane_ticket),
              trailing: IconButton(
                icon: _getIcon(state),
                onPressed: () {
                  if (state is! TicketLoading) {
                    context.read<TicketBloc>().add(LoadEvent(
                          widget._ticket,
                        ));
                  }
                },
              ),
              title: _getFileStatusWidget(state, context),
            ),
          ),
        );
      },
    );
  }

  Widget _getFileStatusWidget(TicketState state, BuildContext context) {
    switch (state.runtimeType) {
      case TicketLoaded:
        return Column(
          children: [
            Text(widget._ticket.ticketName),
            Container(
              height: 4,
              color: Colors.blueAccent,
            ),
            Text(AppLocale.of(context).downloaded),
          ],
        );
      case TicketLoading:
        return Column(
          children: [
            Text(widget._ticket.ticketName),
            LinearProgressIndicator(
              value: (state as TicketLoading).progress,
            ),
            Text(
                '${(state.contentLength / 1000000).round()} Mb /${(state.downloadedLength / 1000000).round()} Mb'),
          ],
        );
      case TicketInitial:
        return Column(
          children: [
            Text(widget._ticket.ticketName),
            Container(
              height: 5,
              color: Colors.grey,
            ),
            Text(AppLocale.of(context).waitingForDownload),
          ],
        );
      default:
        return Column(
          children: [
            Text(widget._ticket.ticketName),
            Container(
              height: 5,
              color: Colors.red,
            ),
            Text('Ошибка при загрузке'),
          ],
        );
    }
  }

  Widget _getIcon(TicketState state) {
    switch (state.runtimeType) {
      case TicketLoaded:
        return const Icon(Icons.cloud_download_outlined,
            color: Colors.blueAccent);
      case TicketLoading:
        return const Icon(
          Icons.downloading,
          color: Colors.blueAccent,
        );
      case TicketInitial:
        return const Icon(Icons.cloud_download_outlined);
      default:
        return const Icon(Icons.error);
    }
  }
}
