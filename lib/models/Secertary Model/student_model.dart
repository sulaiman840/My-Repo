// class Disability {
//   final String nameDisability;
//   final String? rateDisability;
//
//   Disability({
//     required this.nameDisability,
//     this.rateDisability,
//   });
//
//   factory Disability.fromJson(Map<String, dynamic> json) {
//     return Disability(
//       nameDisability: json['nameDisbility'] ?? '',
//       rateDisability: json['rateDisbility'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'nameDisbility': nameDisability,
//       'rateDisbility': rateDisability,
//     };
//   }
// }
//
// class EducationalAttainment {
//   final String educationalAttainmentLevel;
//   final String specialization;
//   final String certificate;
//   final String graduationRate;
//   final String academicYear;
//
//   EducationalAttainment({
//     required this.educationalAttainmentLevel,
//     required this.specialization,
//     required this.certificate,
//     required this.graduationRate,
//     required this.academicYear,
//   });
//
//   factory EducationalAttainment.fromJson(Map<String, dynamic> json) {
//     return EducationalAttainment(
//       educationalAttainmentLevel: json['educationalAttainmentLevel'] ?? '',
//       specialization: json['specialization'] ?? '',
//       certificate: json['certificate'] ?? '',
//       graduationRate: json['graduationRate'] ?? '',
//       academicYear: json['academicYear'] ?? '',
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'educationalAttainmentLevel': educationalAttainmentLevel,
//       'specialization': specialization,
//       'certificate': certificate,
//       'graduationRate': graduationRate,
//       'academicYear': academicYear,
//     };
//   }
// }
//
// class PreviousTrainingCourse {
//   final String certificateAndType;
//   final String executingAgency;
//   final String dateExecute;
//
//   PreviousTrainingCourse({
//     required this.certificateAndType,
//     required this.executingAgency,
//     required this.dateExecute,
//   });
//
//   factory PreviousTrainingCourse.fromJson(Map<String, dynamic> json) {
//     return PreviousTrainingCourse(
//       certificateAndType: json['certificateAndType'] ?? '',
//       executingAgency: json['executingAgency'] ?? '',
//       dateExecute: json['dateExecute'] ?? '',
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'certificateAndType': certificateAndType,
//       'executingAgency': executingAgency,
//       'dateExecute': dateExecute,
//     };
//   }
// }
//
// class ForeignLanguage {
//   final String nameLanguage;
//   final String level;
//
//   ForeignLanguage({
//     required this.nameLanguage,
//     required this.level,
//   });
//
//   factory ForeignLanguage.fromJson(Map<String, dynamic> json) {
//     return ForeignLanguage(
//       nameLanguage: json['namelanguage'] ?? '',
//       level: json['level'] ?? '',
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'namelanguage': nameLanguage,
//       'level': level,
//     };
//   }
// }
//
// class ProfessionalSkill {
//   final String jobTitle;
//   final String start;
//   final String end;
//   final String jobTasks;
//
//   ProfessionalSkill({
//     required this.jobTitle,
//     required this.start,
//     required this.end,
//     required this.jobTasks,
//   });
//
//   factory ProfessionalSkill.fromJson(Map<String, dynamic> json) {
//     return ProfessionalSkill(
//       jobTitle: json['jobTitle'] ?? '',
//       start: json['start'] ?? '',
//       end: json['end'] ?? '',
//       jobTasks: json['jobTasks'] ?? '',
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'jobTitle': jobTitle,
//       'start': start,
//       'end': end,
//       'jobTasks': jobTasks,
//     };
//   }
// }
//
// class Beneficiary {
//   final int id;
//   final int serialNumber;
//   final String date;
//   final String province;
//   final String name;
//   final String fatherName;
//   final String motherName;
//   final String gender;
//   final String dateOfBirth;
//   final String? notes;
//   final String maritalStatus;
//   final String needAttendant;
//   final int numberFamilyMember;
//   final String losingBreadwinner;
//   final String governorate;
//   final String address;
//   final String email;
//   final String numberLine;
//   final String numberPhone;
//   final String numberId;
//   final String educationalAttainment;
//   final String computerDriving;
//   final String computerSkills;
//   final String sectorPreferences;
//   final String employment;
//   final String supportRequiredTrainingLearning;
//   final String supportRequiredEntrepreneurship;
//   final String careerGuidanceCounselling;
//   final String generalNotes;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final List<Disability> disabilities;
//   final List<EducationalAttainment> educationalAttainments;
//   final List<PreviousTrainingCourse> previousTrainingCourses;
//   final List<ForeignLanguage> foreignLanguages;
//   final List<ProfessionalSkill> professionalSkills;
//
//   Beneficiary({
//     required this.id,
//     required this.serialNumber,
//     required this.date,
//     required this.province,
//     required this.name,
//     required this.fatherName,
//     required this.motherName,
//     required this.gender,
//     required this.dateOfBirth,
//     this.notes,
//     required this.maritalStatus,
//     required this.needAttendant,
//     required this.numberFamilyMember,
//     required this.losingBreadwinner,
//     required this.governorate,
//     required this.address,
//     required this.email,
//     required this.numberLine,
//     required this.numberPhone,
//     required this.numberId,
//     required this.educationalAttainment,
//     required this.computerDriving,
//     required this.computerSkills,
//     required this.sectorPreferences,
//     required this.employment,
//     required this.supportRequiredTrainingLearning,
//     required this.supportRequiredEntrepreneurship,
//     required this.careerGuidanceCounselling,
//     required this.generalNotes,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.disabilities,
//     required this.educationalAttainments,
//     required this.previousTrainingCourses,
//     required this.foreignLanguages,
//     required this.professionalSkills,
//   });
//
//   factory Beneficiary.fromJson(Map<String, dynamic> json) {
//     return Beneficiary(
//       id: json['id'],
//       serialNumber: json['serialNumber'],
//       date: json['date'] ?? '',
//       province: json['province'] ?? '',
//       name: json['name'] ?? '',
//       fatherName: json['fatherName'] ?? '',
//       motherName: json['motherName'] ?? '',
//       gender: json['gender'] ?? '',
//       dateOfBirth: json['dateOfBirth'] ?? '',
//       notes: json['nots'],
//       maritalStatus: json['maritalStatus'] ?? '',
//       needAttendant: json['needAttendant'] ?? '',
//       numberFamilyMember: json['NumberFamilyMember'],
//       losingBreadwinner: json['losingBreadwinner'] ?? '',
//       governorate: json['governorate'] ?? '',
//       address: json['address'] ?? '',
//       email: json['email'] ?? '',
//       numberLine: json['numberline'] ?? '',
//       numberPhone: json['numberPhone'] ?? '',
//       numberId: json['numberId'] ?? '',
//       educationalAttainment: json['educationalAttainment'] ?? '',
//       computerDriving: json['computerDriving'] ?? '',
//       computerSkills: json['computerSkills'] ?? '',
//       sectorPreferences: json['sectorPreferences'] ?? '',
//       employment: json['employment'] ?? '',
//       supportRequiredTrainingLearning: json['supportRequiredTrainingLearning'] ?? '',
//       supportRequiredEntrepreneurship: json['supportRequiredEntrepreneurship'] ?? '',
//       careerGuidanceCounselling: json['careerGuidanceCounselling'] ?? '',
//       generalNotes: json['generalNotes'] ?? '',
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       disabilities: (json['disbility'] as List)
//           .map((disabilityJson) => Disability.fromJson(disabilityJson))
//           .toList(),
//       educationalAttainments: (json['educational_attainment'] as List)
//           .map((attainmentJson) => EducationalAttainment.fromJson(attainmentJson))
//           .toList(),
//       previousTrainingCourses: (json['previoustrainingcourses'] as List)
//           .map((courseJson) => PreviousTrainingCourse.fromJson(courseJson))
//           .toList(),
//       foreignLanguages: (json['foreignlanguages'] as List)
//           .map((languageJson) => ForeignLanguage.fromJson(languageJson))
//           .toList(),
//       professionalSkills: (json['professional_skills'] as List)
//           .map((skillJson) => ProfessionalSkill.fromJson(skillJson))
//           .toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'serialNumber': serialNumber,
//       'date': date,
//       'province': province,
//       'name': name,
//       'fatherName': fatherName,
//       'motherName': motherName,
//       'gender': gender,
//       'dateOfBirth': dateOfBirth,
//       'nots': notes,
//       'maritalStatus': maritalStatus,
//       'needAttendant': needAttendant,
//       'NumberFamilyMember': numberFamilyMember,
//       'losingBreadwinner': losingBreadwinner,
//       'governorate': governorate,
//       'address': address,
//       'email': email,
//       'numberline': numberLine,
//       'numberPhone': numberPhone,
//       'numberId': numberId,
//       'educationalAttainment': educationalAttainment,
//       'computerDriving': computerDriving,
//       'computerSkills': computerSkills,
//       'sectorPreferences': sectorPreferences,
//       'employment': employment,
//       'supportRequiredTrainingLearning': supportRequiredTrainingLearning,
//       'supportRequiredEntrepreneurship': supportRequiredEntrepreneurship,
//       'careerGuidanceCounselling': careerGuidanceCounselling,
//       'generalNotes': generalNotes,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//       'disbility': disabilities.map((e) => e.toJson()).toList(),
//       'educational_attainment': educationalAttainments.map((e) => e.toJson()).toList(),
//       'previoustrainingcourses': previousTrainingCourses.map((e) => e.toJson()).toList(),
//       'foreignlanguages': foreignLanguages.map((e) => e.toJson()).toList(),
//       'professional_skills': professionalSkills.map((e) => e.toJson()).toList(),
//     };
//   }
// }
