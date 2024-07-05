import 'package:equatable/equatable.dart';

import '../../../data/models/get_type_id_model.dart';

abstract class TypeDetailsState  extends Equatable {
  const TypeDetailsState();

  @override
  List<Object> get props => [];
}

class TypeDetailsInitial extends TypeDetailsState {}
class TypeDetailsLoading extends TypeDetailsState {}
class TypeDetailsFailure extends TypeDetailsState {
  final String errorMessage;

  const TypeDetailsFailure(this.errorMessage);
}
class TypeDetailsSuccess extends TypeDetailsState {
  final GetTypeIdModel type;

  const TypeDetailsSuccess(this.type);
}