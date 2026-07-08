class ReportModel {
  final String id;
  final String reportName;
  final String hospitalName;
  final String reportType;
  final DateTime reportDate;
  final String fileUrl;
  final DateTime? uploadedAt;

  ReportModel({
    required this.id,
    required this.reportName,
    required this.hospitalName,
    required this.reportType,
    required this.reportDate,
    required this.fileUrl,
    this.uploadedAt,
  });

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      id: map['id'].toString(),
      reportName: map['report_name'] ?? '',
      hospitalName: map['hospital_name'] ?? '',
      reportType: map['report_type'] ?? '',
      reportDate: DateTime.parse(map['report_date']),
      fileUrl: map['file_url'] ?? '',
      uploadedAt: map['uploaded_at'] != null
          ? DateTime.parse(map['uploaded_at'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'report_name': reportName,
      'hospital_name': hospitalName,
      'report_type': reportType,
      'report_date': reportDate.toIso8601String(),
      'file_url': fileUrl,
      'uploaded_at': uploadedAt?.toIso8601String(),
    };
  }
}