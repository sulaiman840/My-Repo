import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

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
      title: Text('Upload Documents'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Pick Image'),
          ),
          if (_selectedImageBytes != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Image selected', style: TextStyle(color: Colors.green)),
            ),
          ElevatedButton(
            onPressed: _pickPdf,
            child: Text('Pick PDF'),
          ),
          if (_selectedPdfBytes != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('PDF selected', style: TextStyle(color: Colors.green)),
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
          child: Text('Upload'),
        ),
      ],
    );
  }
}
