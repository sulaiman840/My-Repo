import 'package:equatable/equatable.dart';

import '../../../data/models/details_report_model.dart';

abstract class DetailsReportState  extends Equatable {
  const DetailsReportState();

  @override
  List<Object> get props => [];
}

class DetailsReportInitial extends DetailsReportState {}
class DetailsReportLoading extends DetailsReportState {}
class DetailsReportFailure extends DetailsReportState {
  final String errorMessage;

  const DetailsReportFailure(this.errorMessage);
}
class DetailsReportSuccess extends DetailsReportState {
  final DetailsReportModel report;

  const DetailsReportSuccess(this.report);
}