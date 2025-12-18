import 'dart:io';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart' as p;
import 'auth_service.dart';
import 'google_http_client.dart';

class DriveService {
  final AuthService _auth = AuthService();

  /// Uploads a file to Drive. Optionally pass [parentFolderId] to place in a folder.
  Future<drive.File> uploadFile(File file, {String? parentFolderId}) async {
    final headers = await _auth.getAuthHeaders();
    final client = GoogleHttpClient(headers);
    final driveApi = drive.DriveApi(client);

    final fileName = p.basename(file.path);
    final media = drive.Media(file.openRead(), file.lengthSync());

    final driveFile = drive.File()
      ..name = fileName
      ..parents = parentFolderId != null ? [parentFolderId] : null;

    final created = await driveApi.files.create(
      driveFile,
      uploadMedia: media,
    );

    client.close();
    return created;
  }

  /// Optional: create folder
  Future<drive.File> createFolder(String folderName) async {
    final headers = await _auth.getAuthHeaders();
    final client = GoogleHttpClient(headers);
    final driveApi = drive.DriveApi(client);

    final folder = drive.File()
      ..name = folderName
      ..mimeType = "application/vnd.google-apps.folder";

    final created = await driveApi.files.create(folder);
    client.close();
    return created;
  }
}
