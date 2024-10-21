import 'package:equatable/equatable.dart';

abstract class CreateReportState  extends Equatable {
  const CreateReportState();

  @override
  List<Object> get props => [];
}

class CreateReportInitial extends CreateReportState {}
class CreateReportLoading extends CreateReportState {}
class CreateReportFailure extends CreateReportState {
  final String errorMessage;

  const CreateReportFailure(this.errorMessage);
}
class CreateReportSuccess extends CreateReportState {
  final dynamic createResult;

  const CreateReportSuccess(this.createResult);
}

class SelectFileFailure extends CreateReportState {}
class SelectFileSuccess extends CreateReportState {}
class SelectFileEmpty extends CreateReportState {}