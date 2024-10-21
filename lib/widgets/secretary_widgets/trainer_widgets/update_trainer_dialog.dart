import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Bloc/secertary/trainer/trainer_cubit.dart';
import '../../../../models/Secertary Model/trainer_model.dart';
import '../../../core/localization/app_localizations.dart';

class UpdateTrainerDialog extends StatelessWidget {
  final Trainer trainer;

  UpdateTrainerDialog({required this.trainer});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    late String _name = trainer.name ?? '';
    late String _email = trainer.email ?? '';
    late String _phone = trainer.phone ?? '';
    late String _address = trainer.address ?? '';
    late String _specialty = trainer.specialty ?? '';
    late String _description = trainer.description ?? '';

    return AlertDialog(
      title: Text(AppLocalizations.of(context).translate('update_trainer')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('name')),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context).translate('please_enter_trainer_name');
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('email')),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context).translate('please_enter_trainer_email');
                  } else if (!value.contains('@') || !value.endsWith('.com')) {
                    return AppLocalizations.of(context).translate('please_enter_valid_email_address');
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('phone')),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context).translate('please_enter_trainer_phone_number');
                  } else if (value.length != 10) {
                    return AppLocalizations.of(context).translate('phone_number_exactly_digits');
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value!;
                },
              ),
              TextFormField(
                initialValue: _address,
                decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('address')),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context).translate('please_enter_trainer_address');
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              TextFormField(
                initialValue: _specialty,
                decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('specialty')),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context).translate('please_enter_the_trainer_specialty');
                  }
                  return null;
                },
                onSaved: (value) {
                  _specialty = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('description')),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context).translate('please_enter_the_trainer_description');
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context).translate('cancel')),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(AppLocalizations.of(context).translate('update')),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final updatedTrainer = Trainer(
                id: trainer.id,
                name: _name,
                email: _email,
                phone: _phone,
                address: _address,
                specialty: _specialty,
                description: _description,
                // createdAt: trainer.createdAt,
                // updatedAt: DateTime.now(),
              );

              context.read<TrainerCubit>().updateTrainer(trainer.id!, updatedTrainer);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
