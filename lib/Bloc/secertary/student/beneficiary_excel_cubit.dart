import 'dart:developer';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import '../../../services/Secertary Services/beneficiary_service.dart';
import 'beneficiary_excel_state.dart';

class BeneficiaryExcelCubit extends Cubit<BeneficiaryExcelState> {
  final BeneficiaryService _beneficiaryService;

  BeneficiaryExcelCubit(this._beneficiaryService) : super(BeneficiaryExcelInitial());

  Future<void> exportToExcel({required Map<String, dynamic> filters}) async {
    emit(BeneficiaryExcelLoading());
    var result = await _beneficiaryService.exportBeneficiariesToExcel(filters);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(BeneficiaryExcelError(failure.errorMessage));
    }, (successMessage) {
      emit(BeneficiaryExcelExportSuccesss(successMessage));
    });
  }


  Future<void> importFromExcel() async {
    emit(BeneficiaryExcelLoading());

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xls', 'xlsx'],
        withData: true,
      );

      if (result != null && result.files.single.bytes != null) {
        List<int> excelFile = result.files.single.bytes!.toList();
        await _beneficiaryService.importBeneficiariesFromExcel(excelFile);
        emit(BeneficiaryExcelImportSuccess());
      } else {
        emit(BeneficiaryExcelError('No file selected or file is empty.'));
      }
    } catch (error) {
      emit(BeneficiaryExcelError(error.toString()));
    }
  }
}
