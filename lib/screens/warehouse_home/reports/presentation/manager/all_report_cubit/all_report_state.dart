import 'package:equatable/equatable.dart';

import '../../../data/models/all_report_model.dart';

abstract class AllReportState  extends Equatable {
  const AllReportState();

  @override
  List<Object> get props => [];
}

class AllReportInitial extends AllReportState {}
class AllReportLoading extends AllReportState {}
class AllReportFailure extends AllReportState {
  final String errorMessage;

  const AllReportFailure(this.errorMessage);
}
class AllReportSuccess extends AllReportState {
  final AllReportModel allReport;

  const AllReportSuccess(this.allReport);
}
class IncreasePaginateSuccess extends AllReportState {}