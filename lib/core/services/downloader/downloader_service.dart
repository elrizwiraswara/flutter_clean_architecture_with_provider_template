import 'dart:io';

import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';

import '../notification/local_notif_service.dart';

class DownloaderService {
  // This class is not meant to be instatiated or extended; this constructor
  // prevents instantiation and extension.
  DownloaderService._();

  static Client client = Client();
  static Permission permission = Permission.storage;

  static void download({
    required String url,
    required String saveDir,
  }) async {
    final status = await permission.request();

    if (status.isGranted) {
      var id = url.hashCode;
      var fileName = url.split('/').last;
      List<int> bytes = [];
      int total = 0, received = 0;

      StreamedResponse response = await Client().send(
        Request('GET', Uri.parse(url)),
      );

      total = response.contentLength ?? 0;

      response.stream.listen((value) async {
        bytes.addAll(value);
        received += value.length;

        LocalNotifService.showDownloadProgressNotification(
          id: id,
          title: fileName,
          body: '${received ~/ 1024}/${total ~/ 1024} KB',
          payload: '',
          count: total,
          i: received,
        );
      }).onDone(() async {
        File file = File('$saveDir/$fileName');
        await file.writeAsBytes(bytes);

        await LocalNotifService.localNotifPlugin.cancel(id);
        LocalNotifService.showNotification(
          title: 'Download Complete',
          body: fileName,
          payload: file.path,
        );
      });
    }
  }
}
