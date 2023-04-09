import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:surf_flutter_study_jam_2023/core/app_locale.dart';
import 'package:path_provider/path_provider.dart';
import 'package:surf_flutter_study_jam_2023/core/file_status.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/models/ticket_model.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/presentation/manager/bloc/ticket_storage_page_bloc/ticket_storage_page_bloc.dart';

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
  double? progress;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.airplane_ticket),
      trailing: IconButton(
        icon: const Icon(Icons.cloud_download_outlined),
        onPressed: () {
          widget._ticket.status = FileStatus.inProgress;
          _downloadButtonPressed();
        },
      ),
      title: _getFileStatusWidget(widget._ticket.status, progress),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocale.of(context).deleteTicket),
            IconButton(
                onPressed: () {
                  context
                      .read<TicketStoragePageBloc>()
                      .add(RemoveTicketEvent(widget._index));
                },
                icon: const Icon(Icons.delete)),
          ],
        )
      ],
    );
  }

  Widget _getFileStatusWidget(FileStatus status, double? progress) {
    switch (status) {
      case FileStatus.uploaded:
        return Column(
          children: [
            Text('${widget._ticket.ticketName} ${widget._index}'),
            Container(
              height: 5,
              color: Colors.blueAccent,
            ),
            Text(AppLocale.of(context).downloaded),
          ],
        );
      case FileStatus.inProgress:
        return Column(
          children: [
            Text('${widget._ticket.ticketName} ${widget._index}'),
            LinearProgressIndicator(
              value: progress,
            ),
            Text(AppLocale.of(context).downloading),
          ],
        );
      case FileStatus.notUploaded:
        return Column(
          children: [
            Text('${widget._ticket.ticketName} ${widget._index}'),
            Container(
              height: 5,
              color: Colors.grey,
            ),
            Text(AppLocale.of(context).waitingForDownload),
          ],
        );
    }
  }

  void _downloadButtonPressed() async {
    setState(() {
      progress = null;
    });
    final request = Request('GET', Uri.parse(widget._ticket.url));
    final StreamedResponse response = await Client().send(request);

    final contentLength = response.contentLength;

    setState(() {
      progress = 0.000001;
    });

    List<int> bytes = [];

    final file = await _getFile('${widget._ticket.ticketName}.pdf');

    response.stream.listen(
      (List<int> newBytes) {
        bytes.addAll(newBytes);
        final downloadedLength = bytes.length;
        setState(() {
          progress = downloadedLength.toDouble() / (contentLength ?? 1);
        });
      },
      onDone: () async {
        setState(() {
          progress = 1;
          widget._ticket.status = FileStatus.uploaded;
          context
              .read<TicketStoragePageBloc>()
              .add(SetTicketStatus(widget._ticket));
        });
        await file.writeAsBytes(bytes);
      },
      onError: (e) {
        debugPrint(e);
      },
      cancelOnError: true,
    );
  }

  Future<File> _getFile(String filename) async {
    final dir = await getTemporaryDirectory();
    return File("${dir.path}/$filename");
  }
}
