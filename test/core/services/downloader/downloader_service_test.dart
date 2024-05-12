import 'dart:io';

import 'package:flutter_clean_architecture_with_provider_template/core/services/downloader/downloader_service.dart';
import 'package:flutter_clean_architecture_with_provider_template/core/services/notification/local_notif_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';

import 'downloader_service_test.mocks.dart';

// Define the classes that you want to mock
@GenerateMocks([
  Client,
  PermissionHandler,
  FileHandler,
  Request,
  StreamedResponse,
  File,
  LocalNotifService,
])
void main() {
  // Ensure that the widget testing environment is initialized
  TestWidgetsFlutterBinding.ensureInitialized();

  // Declare your mock variables
  late MockClient mockClient;
  late MockPermissionHandler mockPermission;
  late MockFileHandler mockFileHandler;
  late MockFile mockFile;
  late MockStreamedResponse mockResponse;
  late MockLocalNotifService mockLocalNotifService;

  // Define the URL and save directory for testing
  String url = 'https://example.com/file.txt';
  String saveDir = '/path/to/save';

  // Define a group of tests for the DownloaderService
  group('DownloaderService', () {
    // Set up the mock responses before all tests
    setUpAll(() async {
      // Initialize the mock variables
      mockClient = MockClient();
      mockPermission = MockPermissionHandler();
      mockFileHandler = MockFileHandler();
      mockFile = MockFile();
      mockResponse = MockStreamedResponse();
      mockLocalNotifService = MockLocalNotifService();

      // Set the static variables in DownloaderService to the mock variables
      DownloaderService.client = mockClient;
      DownloaderService.permission = mockPermission;
      DownloaderService.fileHandler = mockFileHandler;
      DownloaderService.localNotifService = mockLocalNotifService;

      // Define the behavior of the mock variables
      when(mockPermission.requestStoragePermission()).thenAnswer((_) => Future.value(PermissionStatus.granted));
      when(mockResponse.stream).thenAnswer((_) => ByteStream.fromBytes(List<int>.generate(1024, (index) => index)));
      when(mockResponse.contentLength).thenReturn(1024);
      when(mockClient.send(any)).thenAnswer((_) async => mockResponse);
      when(mockFile.writeAsBytes(any)).thenAnswer((_) async => mockFile);
      when(mockFileHandler.writeAsBytes(any, any)).thenAnswer((_) async => mockFile);
      when(mockLocalNotifService.showDownloadProgressNotification(
        id: null,
        title: null,
        body: null,
        payload: null,
        count: null,
        i: null,
      )).thenAnswer((_) async => Future.value(null));
      when(mockLocalNotifService.cancelNotification(any)).thenAnswer((_) async => Future.value(null));
      when(mockLocalNotifService.showNotification(
        title: null,
        body: null,
        payload: null,
      )).thenAnswer((_) async => Future.value(null));
    });

    // Define a test for the download method
    test('download method should be called with correct parameters', () async {
      // Call the download method and expect it to complete without errors
      await expectLater(DownloaderService.download(url: url, saveDir: saveDir), completes);
    });
  });
}
