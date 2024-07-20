import 'package:dio/dio.dart';
import 'dart:typed_data';

import '../../models/Secertary Model/document_model.dart';

class DocumentService {
  final Dio _dio = Dio();

  Future<void> addDocuments(int id, Uint8List imageBytes, Uint8List pdfBytes) async {
    try {
      final formData = FormData.fromMap({
        'image': MultipartFile.fromBytes(imageBytes, filename: 'upload.jpg'),
        'file_pdf': MultipartFile.fromBytes(pdfBytes, filename: 'upload.pdf'),
      });

      final response = await _dio.post(
        'http://127.0.0.1:8000/api/adddocuments/$id',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to upload documents');
      }
    } on DioError catch (e) {
      throw Exception('Failed to upload documents: ${e.message}');
    }
  }

  Future<List<Document>> fetchDocuments(int beneficiaryId) async {
    try {
      final response = await _dio.get('http://127.0.0.1:8000/api/showdocuments/$beneficiaryId');
      if (response.statusCode == 200) {
        final documents = (response.data['message'] as List)
            .map((doc) => Document.fromJson(doc))
            .toList();
        return documents;
      } else {
        throw Exception('Failed to load documents');
      }
    } on DioError catch (e) {
      throw Exception('Failed to load documents: ${e.message}');
    }
  }

  Future<String> getImageUrl(String imageName) async {
    return 'http://127.0.0.1:8000/upload/$imageName';
  }

  Future<String> getPdfUrl(String pdfName) async {
    return 'http://127.0.0.1:8000/files/$pdfName';
  }

  Future<void> updateDocument(int id, Uint8List? imageBytes, Uint8List? pdfBytes) async {
    try {
      final formData = FormData.fromMap({
        if (imageBytes != null) 'image': MultipartFile.fromBytes(imageBytes, filename: 'upload.jpg'),
        if (pdfBytes != null) 'file_pdf': MultipartFile.fromBytes(pdfBytes, filename: 'upload.pdf'),
      });

      final response = await _dio.post(
        'http://127.0.0.1:8000/api/updatedocuments/$id',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update document');
      }
    } on DioError catch (e) {
      throw Exception('Failed to update document: ${e.message}');
    }
  }

  Future<void> deleteDocument(int id) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/destroydocuments/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete document');
      }
    } on DioError catch (e) {
      throw Exception('Failed to delete document: ${e.message}');
    }
  }
}
