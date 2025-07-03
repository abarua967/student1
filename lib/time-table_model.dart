class PeriodModel {
  final String subject;
  final String time;
  final String teacher;

  PeriodModel({
    required this.subject,
    required this.time,
    required this.teacher,
  });

  factory PeriodModel.fromJson(Map<String, dynamic> json) {
    return PeriodModel(
      subject: json['subject'] ?? '',
      time: json['time'] ?? '',
      teacher: json['teacher'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'subject': subject,
      'time': time,
      'teacher': teacher,
    };
  }
}
