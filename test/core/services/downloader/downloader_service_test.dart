// import 'package:flutter_clean_architecture_with_provider_template/core/services/downloader/downloader_service.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart';
// import 'package:mockito/mockito.dart';
// import 'package:permission_handler/permission_handler.dart';

// class MockClient extends Mock implements Client {}

// class MockPermission extends Mock implements Permission {}

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   late MockClient mockClient;
//   late MockPermission mockPermission;

//   group('DownloaderService', () {
//     setUpAll(() {
//       mockClient = MockClient();
//       mockPermission = MockPermission();

//       DownloaderService.client = mockClient;
//       DownloaderService.permission = mockPermission;
//     });

//     test('download method should be called with correct parameters', () async {
//       // Setup
//       String url = 'https://example.com/file.txt';
//       String saveDir = '/path/to/save';

//       var response = StreamedResponse(
//           Stream.fromIterable([
//             [0]
//           ]),
//           200);

//       when(mockPermission.request()).thenAnswer((_) => Future.value(PermissionStatus.granted));
//       when(mockClient.send(Request('GET', Uri.parse(url)))).thenAnswer((_) => Future.value(response));
//       when(response.stream).thenAnswer((_) => ByteStream.fromBytes([0]));

//       // Action
//       DownloaderService.download(url: url, saveDir: saveDir);
//     });
//   });
// }
