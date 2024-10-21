abstract class BeneficiaryExcelState {}

class BeneficiaryExcelInitial extends BeneficiaryExcelState {}

class BeneficiaryExcelLoading extends BeneficiaryExcelState {}

class BeneficiaryExcelExportSuccess extends BeneficiaryExcelState {}

class BeneficiaryExcelImportSuccess extends BeneficiaryExcelState {}

class BeneficiaryExcelError extends BeneficiaryExcelState {
  final String message;

  BeneficiaryExcelError(this.message);
}




class BeneficiaryExcelExportSuccesss extends BeneficiaryExcelState {
  final dynamic exportResult;

   BeneficiaryExcelExportSuccesss(this.exportResult);

  @override
  List<Object?> get props => [exportResult];
}


