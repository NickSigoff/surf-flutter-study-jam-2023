import 'dart:io';

import 'package:dio/dio.dart';
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
  double? progress = null;

  String status = "Not Downloaded";

  final url = 'https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_1000MG.mp3';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.airplane_ticket),
      trailing: IconButton(
        icon: const Icon(Icons.cloud_download_outlined),
        onPressed: () {
          _downloadButtonPressed();
        },
      ),
      title: Column(
        children: [
          Text('Ticket ${widget._index}'),
          LinearProgressIndicator(
            value: progress,
          ),
          Text(AppLocale.of(context).waitingForDownload),
        ],
      ),
    );
  }

  Widget _getFileStatusWidget(FileStatus status) {
    switch (status) {
      case FileStatus.uploaded:
        return Container(
          height: 5,
          color: Colors.blueAccent,
        );
      case FileStatus.inProgress:
        return LinearProgressIndicator();
      case FileStatus.notUploaded:
        return Container(
          height: 5,
          color: Colors.grey,
        );
    }
  }

  void _downloadButtonPressed() async {
    setState(() {
      progress = null;
    });

    final request = Request('GET', Uri.parse(url));
    final StreamedResponse response = await Client().send(request);

    final contentLength = response.contentLength;
    setState(() {
      progress = 0.000001;
      status = "Download Started";
    });

    List<int> bytes = [];

    // final file = await _getFile('video.mp4');
    //
    // response.stream.listen(
    //   (List<int> newBytes) {
    //     // update progress
    //     bytes.addAll(newBytes);
    //     final downloadedLength = bytes.length;
    //     setState(() {
    //       progress = downloadedLength.toDouble() / (contentLength ?? 1);
    //       status = "Progress: ${((progress ?? 0) * 100).toStringAsFixed(2)} %";
    //     });
    //     print("progress: $progress");
    //   },
    //   onDone: () async {
    //     // save file
    //     setState(() {
    //       progress = 1;
    //       status = "Download Finished";
    //     });
    //     await file.writeAsBytes(bytes);
    //
    //     /// file has been downloaded
    //     /// show success to user
    //     debugPrint("Download finished");
    //   },
    //   onError: (e) {
    //     /// if user loses internet connection while downloading the file, causes an error.
    //     /// You can decide what to do about that in onError.
    //     /// Setting cancelOnError to true will cause the StreamSubscription to get canceled.
    //     debugPrint(e);
    //   },
    //   cancelOnError: true,
    // );

    final dir = await getTemporaryDirectory();
   // File file =  File("${dir.path}/video.mp4");

    Dio dio = Dio();
    dio.download(
      url,
      '$dir/video.mp4',
      onReceiveProgress: (received, total) {
        setState(() {
          progress = ((received / total) * 100);
        });
      },
    );
  }
}
