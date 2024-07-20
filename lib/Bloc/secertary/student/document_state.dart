part of 'document_cubit.dart';

abstract class DocumentState extends Equatable {
  @override
  List<Object> get props => [];
}

class DocumentInitial extends DocumentState {}

class DocumentLoading extends DocumentState {}

class DocumentSuccess extends DocumentState {}

class DocumentsLoaded extends DocumentState {
  final List<Document> documents;

  DocumentsLoaded(this.documents);

  @override
  List<Object> get props => [documents];
}

class DocumentFailure extends DocumentState {
  final String message;

  DocumentFailure(this.message);

  @override
  List<Object> get props => [message];
}
