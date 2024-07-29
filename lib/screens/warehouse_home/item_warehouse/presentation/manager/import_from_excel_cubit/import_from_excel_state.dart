import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class ImportFromExcelState extends Equatable {
  const ImportFromExcelState();

  @override
  List<Object> get props => [];
}

class ImportFromExcelInitial extends ImportFromExcelState {}
class ImportFromExcelLoading extends ImportFromExcelState {}
class ImportFromExcelFailure extends ImportFromExcelState {
  final String errorMessage;

  const ImportFromExcelFailure(this.errorMessage);
}
class ImportFromExcelSuccess extends ImportFromExcelState {
  final dynamic importResult;

  const ImportFromExcelSuccess(this.importResult);
}

class ExcelFilePickedSuccess extends ImportFromExcelState {
  final FilePickerResult image;

  const ExcelFilePickedSuccess(this.image);
}
class SelectedFileFailure extends ImportFromExcelState {}
class SelectedFileSuccess extends ImportFromExcelState {}
class SelectedFileEmpty extends ImportFromExcelState {}