

class ScanDetail {
  final String studentIndex;
  final String studentName;
  final String studentClass;
  final String rawContent;


  ScanDetail({
    required this.studentIndex,
    required this.studentName,
    required this.studentClass,
    required this.rawContent,
  });


  factory ScanDetail.fromJson(Map<String, dynamic> json) {
    return ScanDetail(
      studentIndex: json['student_index'],
      studentName: json['student_name'],
      studentClass: json['student_class'],
      rawContent: json['barcode_text'],
    );
  }
}