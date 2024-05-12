import 'dart:io';

import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';

import '../notification/local_notif_service.dart';

class PermissionHandler {
  Future<PermissionStatus> requestStoragePermission() => Permission.storage.request();
}

class FileHandler {
  Future<File> writeAsBytes(String path, List<int> bytes, {FileMode mode = FileMode.write, bool flush = false}) async {
    return await File(path).writeAsBytes(bytes);
  }
}

class DownloaderService {
  static Client client = Client();
  static PermissionHandler permission = PermissionHandler();
  static FileHandler fileHandler = FileHandler();
  static LocalNotifService localNotifService = LocalNotifService.instance;

  static Future<void> download({
    required String url,
    required String saveDir,
  }) async {
    final status = await permission.requestStoragePermission();

    if (status.isGranted) {
      var id = url.hashCode;
      var fileName = url.split('/').last;
      List<int> bytes = [];
      int total = 0, received = 0;

      StreamedResponse response = await client.send(
        Request('GET', Uri.parse(url)),
      );

      total = response.contentLength ?? 0;

      response.stream.listen((value) async {
        bytes.addAll(value);
        received += value.length;

        localNotifService.showDownloadProgressNotification(
          id: id,
          title: fileName,
          body: '${received ~/ 1024}/${total ~/ 1024} KB',
          payload: '',
          count: total,
          i: received,
        );
      }).onDone(() async {
        // File file = File('$saveDir/$fileName');
        String path = '$saveDir/$fileName';
        await fileHandler.writeAsBytes(path, bytes);

        await localNotifService.cancelNotification(id);
        localNotifService.showNotification(
          title: 'Download Complete',
          body: fileName,
          payload: path,
        );
      });
    }
  }
}
