import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:typed_data';
import '../../../models/Secertary Model/document_model.dart';
import '../../../services/Secertary Services/document_service .dart';

part 'document_state.dart';

class DocumentCubit extends Cubit<DocumentState> {
  final DocumentService _documentService;

  DocumentCubit(this._documentService) : super(DocumentInitial());

  Future<void> addDocuments(int beneficiaryId, Uint8List imageBytes, Uint8List pdfBytes) async {
    try {
      emit(DocumentLoading());
      await _documentService.addDocuments(beneficiaryId, imageBytes, pdfBytes);
      await fetchDocuments(beneficiaryId);
    } catch (e) {
      emit(DocumentFailure(e.toString()));
    }
  }

  Future<void> updateDocument(int documentId, Uint8List imageBytes, Uint8List pdfBytes) async {
    try {
      emit(DocumentLoading());
      await _documentService.updateDocument(documentId, imageBytes, pdfBytes);
      await fetchDocuments(documentId);
    } catch (e) {
      emit(DocumentFailure(e.toString()));
    }
  }

  Future<void> deleteDocument(int documentId, int beneficiaryId) async {
    try {
      emit(DocumentLoading());
      await _documentService.deleteDocument(documentId);
      await fetchDocuments(beneficiaryId);
    } catch (e) {
      emit(DocumentFailure(e.toString()));
    }
  }

  Future<void> fetchDocuments(int beneficiaryId) async {
    try {
      emit(DocumentLoading());
      final documents = await _documentService.fetchDocuments(beneficiaryId);
      emit(DocumentsLoaded(documents));
    } catch (e) {
      emit(DocumentFailure(e.toString()));
    }
  }

  Future<String> getImageUrl(String imageName) async {
    return _documentService.getImageUrl(imageName);
  }

  Future<String> getPdfUrl(String pdfName) async {
    return _documentService.getPdfUrl(pdfName);
  }
}
