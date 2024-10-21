import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Bloc/secertary/student/document_cubit.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/color_manager.dart';
import '../../../widgets/secretary_widgets/document_upload_dialog.dart';

class DocumentSection extends StatelessWidget {
  final int beneficiaryId;
  final VoidCallback onDocumentsUpdated;

  DocumentSection({required this.beneficiaryId, required this.onDocumentsUpdated});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                AppLocalizations.of(context).translate('documents'),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorManager.bc5),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => DocumentUploadDialog(
                    onUpload: (imageBytes, pdfBytes) {
                      context.read<DocumentCubit>().addDocuments(beneficiaryId, imageBytes, pdfBytes).then((_) {
                        onDocumentsUpdated();
                      });
                    },
                  ),
                );
              },
              child: Text(AppLocalizations.of(context).translate('add_document') ,style: TextStyle(color: ColorManager.blue)),
            ),
            BlocBuilder<DocumentCubit, DocumentState>(
              builder: (context, state) {
                if (state is DocumentLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is DocumentSuccess) {
                  return Text(AppLocalizations.of(context).translate('documents_uploaded_successfully'));
                } else if (state is DocumentsLoaded) {
                  if (state.documents.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Center(
                        child: Text(AppLocalizations.of(context).translate('no_documents_available'), style: TextStyle(fontSize: 16, color: Colors.grey)),
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.documents.map((document) {
                        return ListTile(
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => DocumentUploadDialog(
                                      onUpload: (imageBytes, pdfBytes) {
                                        context.read<DocumentCubit>().updateDocument(document.id, imageBytes, pdfBytes).then((_) {
                                          onDocumentsUpdated();
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  context.read<DocumentCubit>().deleteDocument(document.id, beneficiaryId).then((_) {
                                    onDocumentsUpdated();
                                  });
                                },
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              if (document.image.isNotEmpty)
                                TextButton(
                                  onPressed: () async {
                                    final imageUrl = Uri.parse(await context.read<DocumentCubit>().getImageUrl(document.image));
                                    if (await canLaunchUrl(imageUrl)) {
                                      await launchUrl(imageUrl);
                                    } else {
                                      throw '${AppLocalizations.of(context).translate('could_not_launch')} $imageUrl';
                                    }
                                  },
                                  child: Text(AppLocalizations.of(context).translate('view_ID_mage'),style: TextStyle(color: ColorManager.blue)),
                                ),
                              if (document.filePdf.isNotEmpty)
                                TextButton(
                                  onPressed: () async {
                                    final pdfUrl = Uri.parse(await context.read<DocumentCubit>().getPdfUrl(document.filePdf));
                                    if (await canLaunchUrl(pdfUrl)) {
                                      await launchUrl(pdfUrl);
                                    } else {
                                      throw '${AppLocalizations.of(context).translate('could_not_launch')} $pdfUrl';
                                    }
                                  },
                                  child: Text(AppLocalizations.of(context).translate('view_CV'),style: TextStyle(color: ColorManager.blue)),
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }
                } else if (state is DocumentFailure) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text('${AppLocalizations.of(context).translate('error')}: ${state.message}', style: TextStyle(color: Colors.red)),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
