import 'dart:convert';
import 'dart:developer';

import 'package:emr_005/data/http/http_repository.dart';
import 'package:image_picker/image_picker.dart';

class PinataService {
  Future<
      ({
        String? error,
        List<String>? ipfsHashImages,
        List<String>? ipfsHashVideos
      })> uploadMedia({
    List<XFile>? images,
    List<XFile>? videos,
    void Function(double)? progress,
  }) async {
    List<String>? ipfsHashImages;
    List<String>? ipfsHashVideos;
    List<String> errorList = [];

    try {
      if (images != null &&
          images.isNotEmpty &&
          videos != null &&
          videos.isNotEmpty) {
        final response = await Future.wait(
            [_uploadFiles(images, progress), _uploadFiles(videos, progress)]);
        ipfsHashImages = response[0]['ipfsHash'];
        ipfsHashVideos = response[1]['ipfsHash'];
      } else {
        if (images != null && images.isNotEmpty) {
          final imageResult = await _uploadFiles(images, progress);
          ipfsHashImages = imageResult['ipfsHash'];
          errorList.addAll(imageResult['errors']);
        }

        if (videos != null && videos.isNotEmpty) {
          final videoResult = await _uploadFiles(videos, progress);
          ipfsHashVideos = videoResult['ipfsHash'];
          errorList.addAll(videoResult['errors']);
        }
      }
    } catch (e) {
      log("Upload media error: $e", name: "PinataService");
      errorList.add(e.toString());
    }

    if (ipfsHashImages != null) {
      log("IPFS Hash $ipfsHashImages", name: "IPFS Service [Images]");
    }

    if (ipfsHashVideos != null) {
      log("IPFS Hash $ipfsHashVideos", name: "IPFS Service [Videos]");
    }
    return (
      error: errorList.isEmpty ? null : errorList.first,
      ipfsHashImages: ipfsHashImages,
      ipfsHashVideos: ipfsHashVideos
    );
  }

  Future<
      ({
        String? error,
        List<(String, String)>? ipfsHashImages,
        List<(String, String)>? ipfsHashVideos
      })> uploadMediaWithTitle({
    List<(String, XFile)>? images,
    List<(String, XFile)>? videos,
    void Function(double)? progress,
  }) async {
    List<(String, String)>? ipfsHashImages;
    List<(String, String)>? ipfsHashVideos;
    List<String> errorList = [];

    try {
      if (images != null &&
          images.isNotEmpty &&
          videos != null &&
          videos.isNotEmpty) {
        final response = await Future.wait([
          _uploadFilesWithTitle(images, progress),
          _uploadFilesWithTitle(videos, progress)
        ]);
        ipfsHashImages = response[0]['ipfsHash'];
        ipfsHashVideos = response[1]['ipfsHash'];
      } else {
        if (images != null && images.isNotEmpty) {
          final imageResult = await _uploadFilesWithTitle(images, progress);
          ipfsHashImages = imageResult['ipfsHash'];
          errorList.addAll(imageResult['errors']);
        }

        if (videos != null && videos.isNotEmpty) {
          final videoResult = await _uploadFilesWithTitle(videos, progress);
          ipfsHashVideos = videoResult['ipfsHash'];
          errorList.addAll(videoResult['errors']);
        }
      }
    } catch (e) {
      log("Upload media error: $e", name: "PinataService");
      errorList.add(e.toString());
    }

    if (ipfsHashImages != null) {
      log("IPFS Hash $ipfsHashImages", name: "IPFS Service [Images]");
    }

    if (ipfsHashVideos != null) {
      log("IPFS Hash $ipfsHashVideos", name: "IPFS Service [Videos]");
    }
    return (
      error: errorList.isEmpty ? null : errorList.first,
      ipfsHashImages: ipfsHashImages,
      ipfsHashVideos: ipfsHashVideos
    );
  }

  Future<Map<String, dynamic>> _uploadFiles(
    List<XFile> files,
    void Function(double)? progress,
  ) async {
    List<String> ipfsHashList = [];
    List<String> errorList = [];

    await Future.wait(
      files.map((filePath) async {
        try {
          final response =
              await HttpRepository.pinFileToPinata(filePath.path, progress);
          if (response.statusCode == 200) {
            final jsonData = json.decode(response.body);
            ipfsHashList.add("${jsonData['IpfsHash']}");
          }
        } catch (e) {
          log("Upload error: $e", name: "PinataService");
          errorList.add(e.toString());
        }
      }).toList(),
    );

    return {
      'ipfsHash': ipfsHashList,
      'errors': errorList,
    };
  }

  Future<Map<String, dynamic>> _uploadFilesWithTitle(
    List<(String, XFile)> files,
    void Function(double)? progress,
  ) async {
    List<(String, String)> ipfsHashList = [];
    List<String> errorList = [];

    await Future.wait(
      files.map((filePath) async {
        try {
          final response =
              await HttpRepository.pinFileToPinata(filePath.$2.path, progress);
          if (response.statusCode == 200) {
            final jsonData = json.decode(response.body);
            ipfsHashList.add((filePath.$1, "${jsonData['IpfsHash']}"));
          }
        } catch (e) {
          log("Upload error: $e", name: "PinataService");
          errorList.add(e.toString());
        }
      }).toList(),
    );

    return {
      'ipfsHash': ipfsHashList,
      'errors': errorList,
    };
  }

  Future<
      ({
        String? error,
      })> deleteMedia({
    required List<String> cIDs,
  }) async {
    List<String> errorList = [];

    if (cIDs.isNotEmpty) {
      await Future.wait(
        cIDs.map((cid) async {
          try {
            await HttpRepository.unpinFilePinata(cid);
          } catch (e) {
            log("Unpin error: $e", name: "PinataService");
            errorList.add(e.toString());
          }
        }).toList(),
      );
    }

    return (error: errorList.isEmpty ? null : errorList.join('\n'));
  }
}


  // Future<Map<String, dynamic>> _uploadFiles(
  //   List<XFile> files,
  //   void Function(double)? progress,
  // ) async {
  //   List<String> ipfsHashList = [];
  //   List<String> errorList = [];

  //   for (var file in files) {
  //     try {
  //       final response = await HttpRepository.pinFileToPinata(
  //         file.path,
  //         progress,
  //       );
  //       if (response.statusCode == 200) {
  //         final jsonData = json.decode(response.body);
  //         ipfsHashList.add("${jsonData['IpfsHash']}");
  //       }
  //     } catch (e) {
  //       log("Upload error: $e", name: "PinataService");
  //       errorList.add(e.toString());
  //     }
  //   }

  //   return {
  //     'ipfsHash': ipfsHashList,
  //     'errors': errorList,
  //   };
  // }

    // Future<({String? error, List<String>? ipfsHash})> uploadImages([
  //   List<XFile> images = const [],
  //   void Function(double)? progress,
  // ]) async {
  //   List<String> ipfsHash = [];
  //   List<String> errorList = [];

  //   if (images.isEmpty) {
  //     return (error: null, ipfsHash: null);
  //   }
  //   for (var imageFile in images) {
  //     try {
  //       final response = await HttpRepository.uploadMediaToPinata(
  //         imageFile.path,
  //         progress,
  //       );
  //       if (response.statusCode == 200) {
  //         final jsonData = json.decode(response.body);
  //         ipfsHash.add("${jsonData['IpfsHash']}");
  //       }
  //     } catch (e) {
  //       log("Upload image error: $e", name: "IPFS Service");
  //       errorList.add(e.toString());
  //     }
  //   }

  //   if (ipfsHash.isNotEmpty) {
  //     log("IPFS Hash $ipfsHash", name: "IPFS Service");
  //   }

  //   return (
  //     error: errorList.firstOrNull,
  //     ipfsHash: ipfsHash.isEmpty ? null : ipfsHash,
  //   );
  // }
