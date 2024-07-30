class Beneficiary {
  List<DataBeneficiary>? dataBeneficiary;

  Beneficiary({this.dataBeneficiary});

  factory Beneficiary.fromJson(Map<String, dynamic> json) {
    return Beneficiary(
      dataBeneficiary: json['dataBeneficiary'] != null
          ? (json['dataBeneficiary'] as List)
          .map((item) => DataBeneficiary.fromJson(item))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dataBeneficiary': dataBeneficiary?.map((item) => item.toJson()).toList(),
    };
  }
}

class DataBeneficiary {
  int? id;
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
  String? needAttendant;
  int? numberFamilyMember;
  String? losingBreadwinner;
  String? governorate;
  String? address;
  String? email;
  String? numberLine;
  String? numberPhone;
  String? numberId;
  String? educationalAttainment;
  String? computerDriving;
  String? computerSkills;
  String? sectorPreferences;
  String? employment;
  String? supportRequiredTrainingLearning;
  String? supportRequiredEntrepreneurship;
  String? careerGuidanceCounselling;
  String? generalNotes;
  String? createdAt;
  String? updatedAt;
  List<Disability>? thereIsDisbility;
  List<Disability>? thereIsDisbilityFamilyMember;

  List<EducationalAttainment>? educationalAttainments;
  List<PreviousTrainingCourse>? previousTrainingCourses;
  List<ForeignLanguage>? foreignLanguages;
  List<ProfessionalSkill>? professionalSkills;


  DataBeneficiary({
    this.id,
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
    this.needAttendant,
    this.numberFamilyMember,
    this.losingBreadwinner,
    this.governorate,
    this.address,
    this.email,
    this.numberLine,
    this.numberPhone,
    this.numberId,
    this.educationalAttainment,
    this.computerDriving,
    this.computerSkills,
    this.sectorPreferences,
    this.employment,
    this.supportRequiredTrainingLearning,
    this.supportRequiredEntrepreneurship,
    this.careerGuidanceCounselling,
    this.generalNotes,
    this.createdAt,
    this.updatedAt,
    this.thereIsDisbility,
    this.thereIsDisbilityFamilyMember,
    this.educationalAttainments,
    this.previousTrainingCourses,
    this.foreignLanguages,
    this.professionalSkills,

  });

  factory DataBeneficiary.fromJson(Map<String, dynamic> json) {
    var disabilities = json['disbility'] != null
        ? (json['disbility'] as List)
        .map((item) => Disability.fromJson(item))
        .toList()
        : <Disability>[];


    var personalDisabilities = disabilities
        .where((d) => d.nameDisability != null && d.rateDisability != null)
        .toList();
    var familyDisabilities = disabilities
        .where((d) => d.nameDisability != null && d.rateDisability == null)
        .toList();

    return DataBeneficiary(
      id: json['id'],
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
      numberLine: json['numberline'],
      numberPhone: json['numberPhone'],
      numberId: json['numberId'],
      educationalAttainment: json['educationalAttainment'],
      computerDriving: json['computerDriving'],
      computerSkills: json['computerSkills'],
      sectorPreferences: json['sectorPreferences'],
      employment: json['employment'],
      supportRequiredTrainingLearning: json['supportRequiredTrainingLearning'],
      supportRequiredEntrepreneurship: json['supportRequiredEntrepreneurship'],
      careerGuidanceCounselling: json['careerGuidanceCounselling'],
      generalNotes: json['generalNotes'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      thereIsDisbility: personalDisabilities,
      thereIsDisbilityFamilyMember: familyDisabilities,
      educationalAttainments: json['educational_attainment'] != null
          ? (json['educational_attainment'] as List)
          .map((item) => EducationalAttainment.fromJson(item))
          .toList()
          : [],
      previousTrainingCourses: json['previoustrainingcourses'] != null
          ? (json['previoustrainingcourses'] as List)
          .map((item) => PreviousTrainingCourse.fromJson(item))
          .toList()
          : [],
      foreignLanguages: json['foreignlanguages'] != null
          ? (json['foreignlanguages'] as List)
          .map((item) => ForeignLanguage.fromJson(item))
          .toList()
          : [],
      professionalSkills: json['professional_skills'] != null
          ? (json['professional_skills'] as List)
          .map((item) => ProfessionalSkill.fromJson(item))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
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
      'numberline': numberLine,
      'numberPhone': numberPhone,
      'numberId': numberId,
      'educationalAttainment': educationalAttainment,
      'computerDriving': computerDriving,
      'computerSkills': computerSkills,
      'sectorPreferences': sectorPreferences,
      'employment': employment,
      'supportRequiredTrainingLearning': supportRequiredTrainingLearning,
      'supportRequiredEntrepreneurship': supportRequiredEntrepreneurship,
      'careerGuidanceCounselling': careerGuidanceCounselling,
      'generalNotes': generalNotes,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'thereIsDisbility': thereIsDisbility?.map((item) => item.toJson()).toList(),
      'thereIsDisbilityFamilyMember': thereIsDisbilityFamilyMember?.map((item) => item.toJson()).toList(),
      'educational_attainment': educationalAttainments?.map((item) => item.toJson()).toList(),
      'previoustrainingcourses': previousTrainingCourses?.map((item) => item.toJson()).toList(),
      'foreignlanguages': foreignLanguages?.map((item) => item.toJson()).toList(),
      'professional_skills': professionalSkills?.map((item) => item.toJson()).toList(),
    };

    // Remove keys with null values
    data.removeWhere((key, value) => value == null);

    return data;
  }
}

class Disability {
  String? nameDisability;
  String? rateDisability;

  Disability({
    this.nameDisability,
    this.rateDisability,
  });

  factory Disability.fromJson(Map<String, dynamic> json) {
    return Disability(
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

class EducationalAttainment {
  String? educationalAttainmentLevel;
  String? specialization;
  String? certificate;
  String? graduationRate;
  String? academicYear;

  EducationalAttainment({
    this.educationalAttainmentLevel,
    this.specialization,
    this.certificate,
    this.graduationRate,
    this.academicYear,
  });

  factory EducationalAttainment.fromJson(Map<String, dynamic> json) {
    return EducationalAttainment(
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

  EducationalAttainment copyWith({
    String? educationalAttainmentLevel,
    String? specialization,
    String? certificate,
    String? graduationRate,
    String? academicYear,
  }) {
    return EducationalAttainment(
      educationalAttainmentLevel: educationalAttainmentLevel ?? this.educationalAttainmentLevel,
      specialization: specialization ?? this.specialization,
      certificate: certificate ?? this.certificate,
      graduationRate: graduationRate ?? this.graduationRate,
      academicYear: academicYear ?? this.academicYear,
    );
  }
}

class PreviousTrainingCourse {
  String? certificateAndType;
  String? executingAgency;
  String? dateExecute;

  PreviousTrainingCourse({
    this.certificateAndType,
    this.executingAgency,
    this.dateExecute,
  });

  factory PreviousTrainingCourse.fromJson(Map<String, dynamic> json) {
    return PreviousTrainingCourse(
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

  PreviousTrainingCourse copyWith({
    String? certificateAndType,
    String? executingAgency,
    String? dateExecute,
  }) {
    return PreviousTrainingCourse(
      certificateAndType: certificateAndType ?? this.certificateAndType,
      executingAgency: executingAgency ?? this.executingAgency,
      dateExecute: dateExecute ?? this.dateExecute,
    );
  }
}

class ForeignLanguage {
  String? nameLanguage;
  String? level;

  ForeignLanguage({
    this.nameLanguage,
    this.level,
  });

  factory ForeignLanguage.fromJson(Map<String, dynamic> json) {
    return ForeignLanguage(
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

  ForeignLanguage copyWith({String? nameLanguage, String? level}) {
    return ForeignLanguage(
      nameLanguage: nameLanguage ?? this.nameLanguage,
      level: level ?? this.level,
    );
  }
}

class ProfessionalSkill {
  String? jobTitle;
  String? start;
  String? end;
  String? jobTasks;

  ProfessionalSkill({
    this.jobTitle,
    this.start,
    this.end,
    this.jobTasks,
  });

  factory ProfessionalSkill.fromJson(Map<String, dynamic> json) {
    return ProfessionalSkill(
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

  ProfessionalSkill copyWith({
    String? jobTitle,
    String? start,
    String? end,
    String? jobTasks,
  }) {
    return ProfessionalSkill(
      jobTitle: jobTitle ?? this.jobTitle,
      start: start ?? this.start,
      end: end ?? this.end,
      jobTasks: jobTasks ?? this.jobTasks,
    );
  }
}