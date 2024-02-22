import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<({String? error, String? filePath})> saveFile(String content,
    {required String fileNameWithExtention}) async {
  try {
    Directory tempDir = await getTemporaryDirectory();
    File file = File('${tempDir.path}/$fileNameWithExtention');

    await file.writeAsString(content);
    return (error: null, filePath: file.path);
  } catch (e) {
    return (error: e.toString(), filePath: null);
  }
}
