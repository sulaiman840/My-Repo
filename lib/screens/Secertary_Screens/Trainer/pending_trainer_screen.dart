import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/manager/pending_trainer_cubit.dart';
import '../../../Bloc/manager/pending_trainer_state.dart';
import '../../../Bloc/secertary/trainer/trainer_cubit.dart';
import '../../../Bloc/secertary/trainer/trainer_state.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/trainer_model.dart';
import '../../../widgets/general_widgets/common_scaffold.dart';

class PendingTrainerScreen extends StatefulWidget {
  const PendingTrainerScreen({super.key});

  @override
  _PendingTrainerScreenState createState() => _PendingTrainerScreenState();
}

class _PendingTrainerScreenState extends State<PendingTrainerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fetchPendingTrainers();
  }

  void _fetchPendingTrainers() {
    context.read<PendingTrainerCubit>().fetchPendingTrainers();
  }

  void _showAddTrainerDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String name = '', email = '', phone = '', address = '', specialty = '', description = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: context.read<TrainerCubit>(),
          child: BlocConsumer<TrainerCubit, TrainerState>(
            listener: (context, state) {
              if (state is TrainerLoaded) {
                Navigator.of(context).pop();
                _fetchPendingTrainers();
              } else if (state is TrainerError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ));
              }
            },
            builder: (context, state) {
              bool isLoading = state is TrainerLoading;
              return AlertDialog(
                title: Text(AppLocalizations.of(context).translate('create_new_trainer')),
                content: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('name')),
                          validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('please_enter_trainer_name') : null,
                          onSaved: (value) => name = value!,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('email')),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context).translate('please_enter_trainer_email');
                            } else if (!value.contains('@') || !value.endsWith('.com')) {
                              return AppLocalizations.of(context).translate('please_enter_valid_email_address');
                            }
                            return null;
                          },
                          onSaved: (value) => email = value!,
                        ),

                        TextFormField(
                          decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('phone')),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context).translate('please_enter_trainer_phone_number');
                            } else if (value.length != 10) {
                              return AppLocalizations.of(context).translate('phone_number_exactly_digits');
                            }
                            return null;
                          },
                          onSaved: (value) => phone = value!,
                        ),

                        TextFormField(
                          decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('address')),
                          validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('please_enter_trainer_address') : null,
                          onSaved: (value) => address = value!,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('specialty')),
                          validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('please_enter_trainer_specialty') : null,
                          onSaved: (value) => specialty = value!,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('description')),
                          validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('please_enter_description') : null,
                          onSaved: (value) => description = value!,
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(AppLocalizations.of(context).translate('cancel')),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: isLoading ? const CircularProgressIndicator() : Text(AppLocalizations.of(context).translate('create')),
                    onPressed: isLoading ? null : () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        final newTrainer = Trainer(
                          id: 0,
                          name: name,
                          email: email,
                          phone: phone,
                          address: address,
                          specialty: specialty,
                          description: description,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );
                        context.read<TrainerCubit>().addTrainer(newTrainer);
                      }
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrainerCubit, TrainerState>(
      listener: (context, state) {
        if (state is TrainerLoaded) {
          _fetchPendingTrainers();
        }
      },
      child: CommonScaffold(
        title: AppLocalizations.of(context).translate('pending_trainer_requests'),
        scaffoldKey: _scaffoldKey,
        body: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                ),
                onPressed: () => _showAddTrainerDialog(context),
                child: Text(
                  AppLocalizations.of(context).translate('create_new_trainer'),
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<PendingTrainerCubit, PendingTrainerState>(
                  builder: (context, state) {
                    if (state is PendingTrainerLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PendingTrainerLoaded) {
                      return ListView.builder(
                        itemCount: state.pendingTrainers.length,
                        itemBuilder: (context, index) {
                          final trainer = state.pendingTrainers[index];
                          return Card(
                            color: ColorManager.bc2,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            elevation: 4,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: ColorManager.bc3,
                                child: Text(
                                  trainer.name[0],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                trainer.name,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context).translate('email')}: ${trainer.email}',
                                    style: TextStyle(color: ColorManager.bc4),
                                  ),
                                  Text(
                                    '${AppLocalizations.of(context).translate('specialty')}: ${trainer.specialty}',
                                    style: TextStyle(color: ColorManager.bc3),
                                  ),
                                ],
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 16,
                              ),
                              onTap: () {},
                            ),
                          );
                        },
                      );
                    } else if (state is PendingTrainerError) {
                      return Center(child: Text(state.message));
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
