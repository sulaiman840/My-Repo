// class CreatBeneficiaryModel {
//   String? message;
//   Data? data;
//
//   CreatBeneficiaryModel({this.message, this.data});
//
//   CreatBeneficiaryModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? serialNumber;
//   String? date;
//   String? province;
//   String? name;
//   String? fatherName;
//   String? motherName;
//   String? gender;
//   String? dateOfBirth;
//   String? nots;
//   String? maritalStatus;
//   List<ThereIsDisability>? thereIsDisability;
//   String? needAttendant;
//   int? numberFamilyMember;
//   List<ThereIsDisabilityFamilyMember>? thereIsDisabilityFamilyMember;
//   String? losingBreadwinner;
//   String? governorate;
//   String? address;
//   String? email;
//   String? numberline;
//   String? numberPhone;
//   String? numberId;
//   List<EducationalAttainment>? educationalAttainment;
//   List<PreviousTrainingCourses>? previousTrainingCourses;
//   List<ForeignLanguages>? foreignLanguages;
//   String? computerDriving;
//   String? computerSkills;
//   List<ProfessionalSkills>? professionalSkills;
//   String? sectorPreferences;
//   String? employment;
//   String? supportRequiredTrainingLearning;
//   String? supportRequiredEntrepreneurship;
//   String? careerGuidanceCounselling;
//   String? generalNotes;
//
//   Data(
//       {this.serialNumber,
//         this.date,
//         this.province,
//         this.name,
//         this.fatherName,
//         this.motherName,
//         this.gender,
//         this.dateOfBirth,
//         this.nots,
//         this.maritalStatus,
//         this.thereIsDisability,
//         this.needAttendant,
//         this.numberFamilyMember,
//         this.thereIsDisabilityFamilyMember,
//         this.losingBreadwinner,
//         this.governorate,
//         this.address,
//         this.email,
//         this.numberline,
//         this.numberPhone,
//         this.numberId,
//         this.educationalAttainment,
//         this.previousTrainingCourses,
//         this.foreignLanguages,
//         this.computerDriving,
//         this.computerSkills,
//         this.professionalSkills,
//         this.sectorPreferences,
//         this.employment,
//         this.supportRequiredTrainingLearning,
//         this.supportRequiredEntrepreneurship,
//         this.careerGuidanceCounselling,
//         this.generalNotes});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     serialNumber = json['serialNumber'];
//     date = json['date'];
//     province = json['province'];
//     name = json['name'];
//     fatherName = json['fatherName'];
//     motherName = json['motherName'];
//     gender = json['gender'];
//     dateOfBirth = json['dateOfBirth'];
//     nots = json['nots'];
//     maritalStatus = json['maritalStatus'];
//     if (json['thereIsDisability'] != null) {
//       thereIsDisability = <ThereIsDisability>[];
//       json['thereIsDisability'].forEach((v) {
//         thereIsDisability!.add(ThereIsDisability.fromJson(v));
//       });
//     }
//     needAttendant = json['needAttendant'];
//     numberFamilyMember = json['NumberFamilyMember'];
//     if (json['thereIsDisabilityFamilyMember'] != null) {
//       thereIsDisabilityFamilyMember = <ThereIsDisabilityFamilyMember>[];
//       json['thereIsDisabilityFamilyMember'].forEach((v) {
//         thereIsDisabilityFamilyMember!
//             .add(ThereIsDisabilityFamilyMember.fromJson(v));
//       });
//     }
//     losingBreadwinner = json['losingBreadwinner'];
//     governorate = json['governorate'];
//     address = json['address'];
//     email = json['email'];
//     numberline = json['numberline'];
//     numberPhone = json['numberPhone'];
//     numberId = json['numberId'];
//     if (json['educationalAttainment'] != null) {
//       educationalAttainment = <EducationalAttainment>[];
//       json['educationalAttainment'].forEach((v) {
//         educationalAttainment!.add(EducationalAttainment.fromJson(v));
//       });
//     }
//     if (json['previousTrainingCourses'] != null) {
//       previousTrainingCourses = <PreviousTrainingCourses>[];
//       json['previousTrainingCourses'].forEach((v) {
//         previousTrainingCourses!.add(PreviousTrainingCourses.fromJson(v));
//       });
//     }
//     if (json['foreignLanguages'] != null) {
//       foreignLanguages = <ForeignLanguages>[];
//       json['foreignLanguages'].forEach((v) {
//         foreignLanguages!.add(ForeignLanguages.fromJson(v));
//       });
//     }
//     computerDriving = json['computerDriving'];
//     computerSkills = json['computerSkills'];
//     if (json['professionalSkills'] != null) {
//       professionalSkills = <ProfessionalSkills>[];
//       json['professionalSkills'].forEach((v) {
//         professionalSkills!.add(ProfessionalSkills.fromJson(v));
//       });
//     }
//     sectorPreferences = json['sectorPreferences'];
//     employment = json['employment'];
//     supportRequiredTrainingLearning = json['supportRequiredTrainingLearning'];
//     supportRequiredEntrepreneurship = json['supportRequiredEntrepreneurship'];
//     careerGuidanceCounselling = json['careerGuidanceCounselling'];
//     generalNotes = json['generalNotes'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['serialNumber'] = this.serialNumber;
//     data['date'] = this.date;
//     data['province'] = this.province;
//     data['name'] = this.name;
//     data['fatherName'] = this.fatherName;
//     data['motherName'] = this.motherName;
//     data['gender'] = this.gender;
//     data['dateOfBirth'] = this.dateOfBirth;
//     data['nots'] = this.nots;
//     data['maritalStatus'] = this.maritalStatus;
//     if (this.thereIsDisability != null) {
//       data['thereIsDisability'] =
//           this.thereIsDisability!.map((v) => v.toJson()).toList();
//     }
//     data['needAttendant'] = this.needAttendant;
//     data['NumberFamilyMember'] = this.numberFamilyMember;
//     if (this.thereIsDisabilityFamilyMember != null) {
//       data['thereIsDisabilityFamilyMember'] =
//           this.thereIsDisabilityFamilyMember!.map((v) => v.toJson()).toList();
//     }
//     data['losingBreadwinner'] = this.losingBreadwinner;
//     data['governorate'] = this.governorate;
//     data['address'] = this.address;
//     data['email'] = this.email;
//     data['numberline'] = this.numberline;
//     data['numberPhone'] = this.numberPhone;
//     data['numberId'] = this.numberId;
//     if (this.educationalAttainment != null) {
//       data['educationalAttainment'] =
//           this.educationalAttainment!.map((v) => v.toJson()).toList();
//     }
//     if (this.previousTrainingCourses != null) {
//       data['previousTrainingCourses'] =
//           this.previousTrainingCourses!.map((v) => v.toJson()).toList();
//     }
//     if (this.foreignLanguages != null) {
//       data['foreignLanguages'] =
//           this.foreignLanguages!.map((v) => v.toJson()).toList();
//     }
//     data['computerDriving'] = this.computerDriving;
//     data['computerSkills'] = this.computerSkills;
//     if (this.professionalSkills != null) {
//       data['professionalSkills'] =
//           this.professionalSkills!.map((v) => v.toJson()).toList();
//     }
//     data['sectorPreferences'] = this.sectorPreferences;
//     data['employment'] = this.employment;
//     data['supportRequiredTrainingLearning'] =
//         this.supportRequiredTrainingLearning;
//     data['supportRequiredEntrepreneurship'] =
//         this.supportRequiredEntrepreneurship;
//     data['careerGuidanceCounselling'] = this.careerGuidanceCounselling;
//     data['generalNotes'] = this.generalNotes;
//     return data;
//   }
// }
//
// class ThereIsDisability {
//   String? nameDisability;
//   String? rateDisability;
//
//   ThereIsDisability({this.nameDisability, this.rateDisability});
//
//   ThereIsDisability.fromJson(Map<String, dynamic> json) {
//     nameDisability = json['nameDisability'];
//     rateDisability = json['rateDisability'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['nameDisability'] = this.nameDisability;
//     data['rateDisability'] = this.rateDisability;
//     return data;
//   }
// }
//
// class ThereIsDisabilityFamilyMember {
//   String? nameDisability;
//   String? rateDisability;
//
//   ThereIsDisabilityFamilyMember({this.nameDisability, this.rateDisability});
//
//   ThereIsDisabilityFamilyMember.fromJson(Map<String, dynamic> json) {
//     nameDisability = json['nameDisability'];
//     rateDisability = json['rateDisability'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['nameDisability'] = this.nameDisability;
//     data['rateDisability'] = this.rateDisability;
//     return data;
//   }
// }
//
// class EducationalAttainment {
//   String? educationalAttainmentLevel;
//   String? specialization;
//   String? certificate;
//   String? graduationRate;
//   String? academicYear;
//
//   EducationalAttainment(
//       {this.educationalAttainmentLevel,
//         this.specialization,
//         this.certificate,
//         this.graduationRate,
//         this.academicYear});
//
//   EducationalAttainment.fromJson(Map<String, dynamic> json) {
//     educationalAttainmentLevel = json['educationalAttainmentLevel'];
//     specialization = json['specialization'];
//     certificate = json['certificate'];
//     graduationRate = json['graduationRate'];
//     academicYear = json['academicYear'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['educationalAttainmentLevel'] = this.educationalAttainmentLevel;
//     data['specialization'] = this.specialization;
//     data['certificate'] = this.certificate;
//     data['graduationRate'] = this.graduationRate;
//     data['academicYear'] = this.academicYear;
//     return data;
//   }
// }
//
// class PreviousTrainingCourses {
//   String? certificateAndType;
//   String? executingAgency;
//   String? dateExecute;
//
//   PreviousTrainingCourses(
//       {this.certificateAndType, this.executingAgency, this.dateExecute});
//
//   PreviousTrainingCourses.fromJson(Map<String, dynamic> json) {
//     certificateAndType = json['certificateAndType'];
//     executingAgency = json['executingAgency'];
//     dateExecute = json['dateExecute'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['certificateAndType'] = this.certificateAndType;
//     data['executingAgency'] = this.executingAgency;
//     data['dateExecute'] = this.dateExecute;
//     return data;
//   }
// }
//
// class ForeignLanguages {
//   String? nameLanguage;
//   String? level;
//
//   ForeignLanguages({this.nameLanguage, this.level});
//
//   ForeignLanguages.fromJson(Map<String, dynamic> json) {
//     nameLanguage = json['nameLanguage'];
//     level = json['level'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['nameLanguage'] = this.nameLanguage;
//     data['level'] = this.level;
//     return data;
//   }
// }
//
// class ProfessionalSkills {
//   String? jobTitle;
//   String? start;
//   String? end;
//   String? jobTasks;
//
//   ProfessionalSkills({this.jobTitle, this.start, this.end, this.jobTasks});
//
//   ProfessionalSkills.fromJson(Map<String, dynamic> json) {
//     jobTitle = json['jobTitle'];
//     start = json['start'];
//     end = json['end'];
//     jobTasks = json['jobTasks'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['jobTitle'] = this.jobTitle;
//     data['start'] = this.start;
//     data['end'] = this.end;
//     data['jobTasks'] = this.jobTasks;
//     return data;
//   }
// }
