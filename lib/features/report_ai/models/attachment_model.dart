import 'dart:io';
enum AttachmentType {
  image,
  pdf,
  camera,
}



class AttachmentModel {

  final String id;

  final String fileName;

  final String localPath;

  final String? remoteUrl;

  final AttachmentType type;

  final int fileSize;

  final DateTime uploadedAt;

  const AttachmentModel({
    required this.id,
    required this.fileName,
    required this.localPath,
    required this.type,
    required this.fileSize,
    required this.uploadedAt,
    this.remoteUrl,
  });
  factory AttachmentModel.fromFile(File file) {
  final extension = file.path.split('.').last.toLowerCase();

  AttachmentType type;

  if (extension == 'pdf') {
    type = AttachmentType.pdf;
  } else {
    type = AttachmentType.image;
  }

  return AttachmentModel(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    fileName: file.path.split('/').last,
    localPath: file.path,
    type: type,
    fileSize: file.lengthSync(),
    uploadedAt: DateTime.now(),
  );
}

  bool get isImage =>
      type == AttachmentType.image ||
      type == AttachmentType.camera;

  bool get isPdf => type == AttachmentType.pdf;

  AttachmentModel copyWith({
    String? id,
    String? fileName,
    String? localPath,
    String? remoteUrl,
    AttachmentType? type,
    int? fileSize,
    DateTime? uploadedAt,
  }) {
    return AttachmentModel(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      localPath: localPath ?? this.localPath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      type: type ?? this.type,
      fileSize: fileSize ?? this.fileSize,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
