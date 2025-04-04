import 'dart:convert';

class Job {
  final int id;
  final String title;
  final String location;
  final String salary;
  final String phone;
  final String companyName;
  final String content;
  final String experience;
  final String qualification;
  final String jobRole;
  final String jobHours;
  final int openingsCount;
  final String otherDetails;
  final String buttonText;
  final String customLink;

  Job({
    required this.id,
    required this.title,
    required this.location,
    required this.salary,
    required this.phone,
    required this.companyName,
    required this.content,
    required this.experience,
    required this.qualification,
    required this.jobRole,
    required this.jobHours,
    required this.openingsCount,
    required this.otherDetails,
    required this.buttonText,
    required this.customLink,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    final primary = json['primary_details'] ?? {};
    return Job(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      title: json['title'] ?? '',
      location: primary['Place'] ?? '',
      salary: primary['Salary'] ?? '',
      phone: json['whatsapp_no'] ?? '',
      companyName: json['company_name'] ?? '',
      content: json['content'] ?? '',
      experience: primary['Experience'] ?? '',
      qualification: primary['Qualification'] ?? '',
      jobRole: json['job_role'] ?? '',
      jobHours: json['job_hours'] ?? '',
      openingsCount: json['openings_count'] is int
          ? json['openings_count']
          : int.tryParse(json['openings_count']?.toString() ?? '') ?? 0,
      otherDetails: json['other_details'] ?? '',
      buttonText: json['button_text'] ?? '',
      customLink: json['custom_link'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'salary': salary,
      'phone': phone,
      'companyName': companyName,
      'content': content,
      'experience': experience,
      'qualification': qualification,
      'jobRole': jobRole,
      'jobHours': jobHours,
      'openingsCount': openingsCount,
      'otherDetails': otherDetails,
      'buttonText': buttonText,
      'customLink': customLink,
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      id: map['id'] is int
          ? map['id']
          : int.tryParse(map['id']?.toString() ?? '') ?? 0,
      title: map['title'] ?? '',
      location: map['location'] ?? '',
      salary: map['salary'] ?? '',
      phone: map['phone'] ?? '',
      companyName: map['companyName'] ?? '',
      content: map['content'] ?? '',
      experience: map['experience'] ?? '',
      qualification: map['qualification'] ?? '',
      jobRole: map['jobRole'] ?? '',
      jobHours: map['jobHours'] ?? '',
      openingsCount: map['openingsCount'] is int
          ? map['openingsCount']
          : int.tryParse(map['openingsCount']?.toString() ?? '') ?? 0,
      otherDetails: map['otherDetails'] ?? '',
      buttonText: map['buttonText'] ?? '',
      customLink: map['customLink'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
}
