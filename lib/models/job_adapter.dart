import 'job.dart';

class JobAdapter {
  static Job fromMap(Map<String, dynamic> map) {
    return Job(
      id: map['id'] is int ? map['id'] : int.tryParse(map['id']?.toString() ?? '') ?? 0,
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

  static Map<String, dynamic> toMap(Job job) {
    return {
      'id': job.id,
      'title': job.title,
      'location': job.location,
      'salary': job.salary,
      'phone': job.phone,
      'companyName': job.companyName,
      'content': job.content,
      'experience': job.experience,
      'qualification': job.qualification,
      'jobRole': job.jobRole,
      'jobHours': job.jobHours,
      'openingsCount': job.openingsCount,
      'otherDetails': job.otherDetails,
      'buttonText': job.buttonText,
      'customLink': job.customLink,
    };
  }
}
