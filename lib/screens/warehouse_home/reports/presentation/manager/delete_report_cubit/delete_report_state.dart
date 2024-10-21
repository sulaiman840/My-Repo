import 'package:equatable/equatable.dart';

abstract class DeleteReportState  extends Equatable {
  const DeleteReportState();

  @override
  List<Object> get props => [];
}

class DeleteReportInitial extends DeleteReportState {}
class DeleteReportLoading extends DeleteReportState {}
class DeleteReportFailure extends DeleteReportState {
  final String errorMessage;

  const DeleteReportFailure(this.errorMessage);
}
class DeleteReportSuccess extends DeleteReportState {
  final dynamic deleteResult;

  const DeleteReportSuccess(this.deleteResult);
}