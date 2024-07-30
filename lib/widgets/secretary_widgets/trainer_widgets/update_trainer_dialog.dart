import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Bloc/secertary/trainer/trainer_cubit.dart';
import '../../../../models/Secertary Model/trainer_model.dart';

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
      title: Text("Update Trainer"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the trainer name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the trainer email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the trainer phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value!;
                },
              ),
              TextFormField(
                initialValue: _address,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the trainer address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              TextFormField(
                initialValue: _specialty,
                decoration: InputDecoration(labelText: 'Specialty'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the trainer specialty';
                  }
                  return null;
                },
                onSaved: (value) {
                  _specialty = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the trainer description';
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
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Update"),
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
