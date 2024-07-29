import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class ExportToExcelState extends Equatable {
  const ExportToExcelState();

  @override
  List<Object> get props => [];
}

class ExportToExcelInitial extends ExportToExcelState {}
class ExportToExcelLoading extends ExportToExcelState {}
class ExportToExcelFailure extends ExportToExcelState {
  final String errorMessage;

  const ExportToExcelFailure(this.errorMessage);
}
class ExportToExcelSuccess extends ExportToExcelState {
  final dynamic exportResult;

  const ExportToExcelSuccess(this.exportResult);
}

class ExcelFileSaveSuccess extends ExportToExcelState {
  final FilePickerResult file;

  const ExcelFileSaveSuccess(this.file);
}
