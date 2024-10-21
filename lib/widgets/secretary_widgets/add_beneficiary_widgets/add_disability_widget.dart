import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class AddDisabilityWidget extends StatefulWidget {
  final String title;
  final ValueNotifier<List<Disability>> disabilitiesNotifier;

  AddDisabilityWidget({
    required this.title,
    required List<Disability> disabilities,
  }) : disabilitiesNotifier = ValueNotifier(disabilities);

  @override
  _AddDisabilityWidgetState createState() => _AddDisabilityWidgetState();
}

class _AddDisabilityWidgetState extends State<AddDisabilityWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Disability>>(
      valueListenable: widget.disabilitiesNotifier,
      builder: (context, disabilities, child) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: disabilities.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(height:20),

                        _buildTextFormField(
                          context,
                          label: AppLocalizations.of(context).translate('disability_name'),
                          initialValue: disabilities[index].nameDisability ?? '',
                          onChanged: (value) {
                            disabilities[index].nameDisability = value;
                          },
                        ),
                        SizedBox(height:20),
                        if (widget.title != AppLocalizations.of(context).translate('family_member_disabilities'))
                          _buildTextFormField(
                            context,
                            label: AppLocalizations.of(context).translate('disability_rate'),
                            initialValue: disabilities[index].rateDisability ?? '',
                            onChanged: (value) {
                              disabilities[index].rateDisability = value;
                            },
                          ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),

                TextButton(
                  onPressed: () {
                    final newDisability = Disability();
                    widget.disabilitiesNotifier.value = [
                      ...disabilities,
                      newDisability,
                    ];
                  },
                  child: Text(AppLocalizations.of(context).translate('add_disability')),
                ),
                if (disabilities.isEmpty)
                  Text(
                    AppLocalizations.of(context).translate('no_disabilities_added'),
                    style: TextStyle(fontSize: 16),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextFormField(BuildContext context,
      {required String label, required String initialValue, required ValueChanged<String> onChanged}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      onChanged: onChanged,
    );
  }
}
