
class PendingBeneficiaryRequest {
  String? message;
  List<DataRequest>? dataRequest;

  PendingBeneficiaryRequest({this.message, this.dataRequest});

  factory PendingBeneficiaryRequest.fromJson(Map<String, dynamic> json) {
    return PendingBeneficiaryRequest(
      message: json['message'],
      dataRequest: json['dataRequest'] != null
          ? (json['dataRequest'] as List)
          .map((v) => DataRequest.fromJson(v))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'dataRequest': dataRequest?.map((v) => v.toJson()).toList(),
    };
  }
}

class DataRequest {
  int? id;
  RequsetPending? requsetPending;
  String? status;
  String? type;
  String? createdAt;
  String? updatedAt;

  DataRequest({
    this.id,
    this.requsetPending,
    this.status,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  // Factory method to create a DataRequest from JSON
  factory DataRequest.fromJson(Map<String, dynamic> json) {
    return DataRequest(
      id: json['id'],
      requsetPending: json['requsetPending'] != null ? RequsetPending.fromJson(json['requsetPending']) : null,
      status: json['status'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Method to convert DataRequest to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requsetPending': requsetPending?.toJson(),
      'status': status,
      'type': type,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Implementing the copyWith method
  DataRequest copyWith({
    int? id,
    RequsetPending? requsetPending,
    String? status,
    String? type,
    String? createdAt,
    String? updatedAt,
  }) {
    return DataRequest(
      id: id ?? this.id,
      requsetPending: requsetPending ?? this.requsetPending,
      status: status ?? this.status,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}


class RequsetPending {
  int? serialNumber;
  String? date;
  String? province;
  String? name;
  String? fatherName;
  String? motherName;
  String? gender;
  String? dateOfBirth;
  String? nots;
  String? maritalStatus;
  List<Disabilities>? thereIsDisbility;
  List<Disabilities>? thereIsDisbilityFamilyMember;
  String? needAttendant;
  int? numberFamilyMember;
  String? losingBreadwinner;
  String? governorate;
  String? address;
  String? email;
  String? numberline;
  String? numberPhone;
  String? numberId;
  List<EducationalAttainments>? educationalAttainments;
  List<PreviousTrainingCourses>? previousTrainingCourses;
  List<ForeignLanguages>? foreignLanguages;
  String? computerDriving;
  String? computerSkills;
  List<ProfessionalSkills>? professionalSkills;
  String? sectorPreferences;
  String? employment;
  String? supportRequiredTrainingLearning;
  String? supportRequiredEntrepreneurship;
  String? careerGuidanceCounselling;
  String? generalNotes;

  RequsetPending({
    this.serialNumber,
    this.date,
    this.province,
    this.name,
    this.fatherName,
    this.motherName,
    this.gender,
    this.dateOfBirth,
    this.nots,
    this.maritalStatus,
    this.thereIsDisbility,
    this.needAttendant,
    this.numberFamilyMember,
    this.thereIsDisbilityFamilyMember,
    this.losingBreadwinner,
    this.governorate,
    this.address,
    this.email,
    this.numberline,
    this.numberPhone,
    this.numberId,
    this.educationalAttainments,
    this.previousTrainingCourses,
    this.foreignLanguages,
    this.computerDriving,
    this.computerSkills,
    this.professionalSkills,
    this.sectorPreferences,
    this.employment,
    this.supportRequiredTrainingLearning,
    this.supportRequiredEntrepreneurship,
    this.careerGuidanceCounselling,
    this.generalNotes,
  });

  factory RequsetPending.fromJson(Map<String, dynamic> json) {
    return RequsetPending(
      serialNumber: json['serialNumber'],
      date: json['date'],
      province: json['province'],
      name: json['name'],
      fatherName: json['fatherName'],
      motherName: json['motherName'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      nots: json['nots'],
      maritalStatus: json['maritalStatus'],
      needAttendant: json['needAttendant'],
      numberFamilyMember: json['NumberFamilyMember'],
      losingBreadwinner: json['losingBreadwinner'],
      governorate: json['governorate'],
      address: json['address'],
      email: json['email'],
      numberline: json['numberline'],
      numberPhone: json['numberPhone'],
      numberId: json['numberId'],
      thereIsDisbility: (json['thereIsDisbility'] as List?)?.map((e) => Disabilities.fromJson(e)).toList(),
      thereIsDisbilityFamilyMember: (json['thereIsDisbilityFamilyMember'] as List?)?.map((e) => Disabilities.fromJson(e)).toList(),
      educationalAttainments: json['educational'] != null
          ? (json['educational'] as List)
          .map((item) => EducationalAttainments.fromJson(item))
          .toList()
          : [],      previousTrainingCourses: (json['previousTrainingCourses'] as List?)?.map((e) => PreviousTrainingCourses.fromJson(e)).toList(),
      foreignLanguages: (json['foreignLanguages'] as List?)?.map((e) => ForeignLanguages.fromJson(e)).toList(),
      professionalSkills: (json['professionalSkills'] as List?)?.map((e) => ProfessionalSkills.fromJson(e)).toList(),
      computerDriving: json['computerDriving'],
      computerSkills: json['computerSkills'],
      sectorPreferences: json['sectorPreferences'],
      employment: json['employment'],
      supportRequiredTrainingLearning: json['supportRequiredTrainingLearning'],
      supportRequiredEntrepreneurship: json['supportRequiredEntrepreneurship'],
      careerGuidanceCounselling: json['careerGuidanceCounselling'],
      generalNotes: json['generalNotes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serialNumber': serialNumber,
      'date': date,
      'province': province,
      'name': name,
      'fatherName': fatherName,
      'motherName': motherName,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'nots': nots,
      'maritalStatus': maritalStatus,
      'needAttendant': needAttendant,
      'NumberFamilyMember': numberFamilyMember,
      'losingBreadwinner': losingBreadwinner,
      'governorate': governorate,
      'address': address,
      'email': email,
      'numberline': numberline,
      'numberPhone': numberPhone,
      'numberId': numberId,
      'thereIsDisbility': thereIsDisbility?.map((e) => e.toJson()).toList(),
      'thereIsDisbilityFamilyMember': thereIsDisbilityFamilyMember?.map((e) => e.toJson()).toList(),
      'educational': educationalAttainments?.map((e) => e.toJson()).toList(),
      'previousTrainingCourses': previousTrainingCourses?.map((e) => e.toJson()).toList(),
      'foreignLanguages': foreignLanguages?.map((e) => e.toJson()).toList(),
      'professionalSkills': professionalSkills?.map((e) => e.toJson()).toList(),
      'computerDriving': computerDriving,
      'computerSkills': computerSkills,
      'sectorPreferences': sectorPreferences,
      'employment': employment,
      'supportRequiredTrainingLearning': supportRequiredTrainingLearning,
      'supportRequiredEntrepreneurship': supportRequiredEntrepreneurship,
      'careerGuidanceCounselling': careerGuidanceCounselling,
      'generalNotes': generalNotes,
    };

  }
}


class Disabilities {
  String? nameDisability;
  String? rateDisability;

  Disabilities({
    this.nameDisability,
    this.rateDisability,
  });

  factory Disabilities.fromJson(Map<String, dynamic> json) {
    return Disabilities(
      nameDisability: json['nameDisbility'] ?? '',
      rateDisability: json['rateDisbility'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameDisbility': nameDisability,
      'rateDisbility': rateDisability,
    };
  }
}



class EducationalAttainments {
  String? educationalAttainmentLevel;
  String? specialization;
  String? certificate;
  String? graduationRate;
  String? academicYear;

  EducationalAttainments({
    this.educationalAttainmentLevel,
    this.specialization,
    this.certificate,
    this.graduationRate,
    this.academicYear,
  });

  factory EducationalAttainments.fromJson(Map<String, dynamic> json) {
    return EducationalAttainments(
      educationalAttainmentLevel: json['educationalAttainmentLevel'] ?? '',
      specialization: json['specialization'] ?? '',
      certificate: json['certificate'] ?? '',
      graduationRate: json['graduationRate'] ?? '',
      academicYear: json['academicYear'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'educationalAttainmentLevel': educationalAttainmentLevel,
      'specialization': specialization,
      'certificate': certificate,
      'graduationRate': graduationRate,
      'academicYear': academicYear,
    };
  }

  EducationalAttainments copyWith({
    String? educationalAttainmentLevel,
    String? specialization,
    String? certificate,
    String? graduationRate,
    String? academicYear,
  }) {
    return EducationalAttainments(
      educationalAttainmentLevel: educationalAttainmentLevel ?? this.educationalAttainmentLevel,
      specialization: specialization ?? this.specialization,
      certificate: certificate ?? this.certificate,
      graduationRate: graduationRate ?? this.graduationRate,
      academicYear: academicYear ?? this.academicYear,
    );
  }
}

class PreviousTrainingCourses {
  String? certificateAndType;
  String? executingAgency;
  String? dateExecute;

  PreviousTrainingCourses({
    this.certificateAndType,
    this.executingAgency,
    this.dateExecute,
  });

  factory PreviousTrainingCourses.fromJson(Map<String, dynamic> json) {
    return PreviousTrainingCourses(
      certificateAndType: json['certificateAndType'] ?? '',
      executingAgency: json['executingAgency'] ?? '',
      dateExecute: json['dateExecute'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'certificateAndType': certificateAndType,
      'executingAgency': executingAgency,
      'dateExecute': dateExecute,
    };
  }
}

class ForeignLanguages {
  String? nameLanguage;
  String? level;

  ForeignLanguages({
    this.nameLanguage,
    this.level,
  });

  factory ForeignLanguages.fromJson(Map<String, dynamic> json) {
    return ForeignLanguages(
      nameLanguage: json['namelanguage'] ?? '',
      level: json['level'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'namelanguage': nameLanguage,
      'level': level,
    };
  }
}

class ProfessionalSkills {
  String? jobTitle;
  String? start;
  String? end;
  String? jobTasks;

  ProfessionalSkills({this.jobTitle, this.start, this.end, this.jobTasks});

  factory ProfessionalSkills.fromJson(Map<String, dynamic> json) {
    return ProfessionalSkills(
      jobTitle: json['jobTitle'] ?? '',
      start: json['start'] ?? '',
      end: json['end'] ?? '',
      jobTasks: json['jobTasks'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
      'start': start,
      'end': end,
      'jobTasks': jobTasks,
    };
  }
}


