import 'package:equatable/equatable.dart';

abstract class GetFileState  extends Equatable {
  const GetFileState();

  @override
  List<Object> get props => [];
}

class GetFileInitial extends GetFileState {}
class GetFileLoading extends GetFileState {}
class GetFileFailure extends GetFileState {
  final String errorMessage;

  const GetFileFailure(this.errorMessage);
}
class GetFileSuccess extends GetFileState {
  final dynamic file;

  const GetFileSuccess(this.file);
}