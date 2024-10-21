import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

import '../../core/localization/app_localizations.dart';

class DocumentUploadDialog extends StatefulWidget {
  final Function(Uint8List imageBytes, Uint8List pdfBytes) onUpload;

  DocumentUploadDialog({required this.onUpload});

  @override
  _DocumentUploadDialogState createState() => _DocumentUploadDialogState();
}

class _DocumentUploadDialogState extends State<DocumentUploadDialog> {
  Uint8List? _selectedImageBytes;
  Uint8List? _selectedPdfBytes;

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          _selectedImageBytes = result.files.single.bytes;
        });
      } else {
        print('No image selected or image data is unavailable.');
      }
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _pickPdf() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf'], withData: true);
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          _selectedPdfBytes = result.files.single.bytes;
        });
      } else {
        print('No PDF selected or PDF data is unavailable.');
      }
    } catch (e) {
      print('Failed to pick PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).translate('upload_documents')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: _pickImage,
            child: Text(AppLocalizations.of(context).translate('pick_image')),
          ),
          if (_selectedImageBytes != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(AppLocalizations.of(context).translate('image_selected'), style: TextStyle(color: Colors.green)),
            ),
          ElevatedButton(
            onPressed: _pickPdf,
            child: Text(AppLocalizations.of(context).translate('pick_PDF')),
          ),
          if (_selectedPdfBytes != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(AppLocalizations.of(context).translate('PDF_selected'), style: TextStyle(color: Colors.green)),
            ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_selectedImageBytes != null && _selectedPdfBytes != null) {
              widget.onUpload(_selectedImageBytes!, _selectedPdfBytes!);
              Navigator.of(context).pop();
            } else {
              print('Please select both an image and a PDF.');
            }
          },
          child: Text(AppLocalizations.of(context).translate('upload')),
        ),
      ],
    );
  }
}
