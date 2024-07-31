// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project2/Bloc/manager/pending_trainer_state.dart';
// import '../../../Bloc/manager/pending_trainer_cubit.dart';
// import '../../../Bloc/secertary/course/course_cubit.dart';
// import '../../../Bloc/secertary/course/course_state.dart';
// import '../../../Bloc/manager/pending_course_cubit.dart';
// import '../../../Bloc/manager/pending_course_state.dart';
// import '../../../Bloc/secertary/trainer/trainer_cubit.dart';
// import '../../../Bloc/secertary/trainer/trainer_state.dart';
// import '../../../core/utils/color_manager.dart';
// import '../../../models/Secertary Model/course_model.dart';
// import '../../../models/Secertary Model/trainer_model.dart';
// import '../../../widgets/general_widgets/common_scaffold.dart';
//
// class PendingTrainerScreen extends StatefulWidget {
//   const PendingTrainerScreen({super.key});
//
//   @override
//   _PendingTrainerScreenState createState() => _PendingTrainerScreenState();
// }
//
// class _PendingTrainerScreenState extends State<PendingTrainerScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchPendingTrainers();
//   }
//
//   void _fetchPendingTrainers() {
//     context.read<PendingTrainerCubit>().fetchPendingTrainers().then((_) {
//       if (mounted) {
//         setState(() {});
//       }
//     });
//   }
//
//   void _showAddTrainerDialog(BuildContext context) {
//     final _formKey = GlobalKey<FormState>();
//     String name = '';
//     String email = '';
//     String phone = '';
//     String address = '';
//     String specialty = '';
//     String description = '';
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Create a New Trainer'),
//           content: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Name'),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter the trainer name';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       name = value!;
//                     },
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Email'),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter the trainer email';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       email = value!;
//                     },
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Phone'),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter the trainer phone number';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       phone = value!;
//                     },
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Address'),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter the trainer address';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       address = value!;
//                     },
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Specialty'),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter the specialty';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       specialty = value!;
//                     },
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Description'),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter the description';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       description = value!;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Create'),
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   _formKey.currentState!.save();
//                   final newTrainer = Trainer(
//                     id: 0,
//                     name: name,
//                     email: email,
//                     phone: phone,
//                     address: address,
//                     specialty: specialty,
//                     description: description,
//                     createdAt: DateTime.now(),
//                     updatedAt: DateTime.now(),
//                   );
//                   await context.read<TrainerCubit>().addTrainer(newTrainer);
//                   if (mounted) {
//                     Navigator.of(context).pop();
//                     _fetchPendingTrainers();
//                   }
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<TrainerCubit, TrainerState>(
//       listener: (context, state) {
//         if (state is TrainerLoaded && mounted) {
//           _fetchPendingTrainers();
//         }
//       },
//       child: CommonScaffold(
//         title: 'Pending Trainer Requests',
//         scaffoldKey: _scaffoldKey,
//         body: Column(
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               alignment:Alignment.centerLeft ,
//               padding: EdgeInsetsDirectional.all(10),
//               child: ElevatedButton(
//                 style: ButtonStyle(backgroundColor:WidgetStatePropertyAll(Colors.blue)),
//                 onPressed: () => _showAddTrainerDialog(context),
//                 child: Text(
//                   'Create a New Trainer',
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: BlocBuilder<PendingTrainerCubit, PendingTrainerState>(
//                   builder: (context, state) {
//                     if (state is PendingTrainerLoading) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (state is PendingTrainerLoaded) {
//                       return ListView.builder(
//                         itemCount: state.pendingTrainers.length,
//                         itemBuilder: (context, index) {
//                           final pendingTrainers = state.pendingTrainers[index];
//                           final Trainer = pendingTrainers;
//                           return Card(
//                             color: ColorManager.bc2,
//                             margin: const EdgeInsets.symmetric(vertical: 8),
//                             elevation: 4,
//                             child: ListTile(
//                               leading: CircleAvatar(
//                                 backgroundColor: ColorManager.bc3,
//                                 child: Text(
//                                   Trainer.name[0],
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                               title: Text(Trainer.name,
//                                   style:
//                                   TextStyle(fontWeight: FontWeight.bold)),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('Type: ${Trainer.type}',
//                                       style:
//                                       TextStyle(color: ColorManager.bc4)),
//                                   Text('Status: ${Trainer.status}',
//                                       style:
//                                       TextStyle(color: ColorManager.bc3)),
//                                 ],
//                               ),
//                               trailing: Icon(
//                                 Icons.circle,
//                                 color: Colors.grey,
//                                 size: 12,
//                               ),
//                               onTap: () {
//
//                               },
//                             ),
//                           );
//                         },
//                       );
//                     } else if (state is PendingTrainerError) {
//                       return Center(child: Text(state.message));
//                     } else {
//                       return Container();
//                     }
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/manager/pending_trainer_cubit.dart';
import '../../../Bloc/manager/pending_trainer_state.dart';
import '../../../Bloc/secertary/trainer/trainer_cubit.dart';
import '../../../Bloc/secertary/trainer/trainer_state.dart';
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
    final _formKey = GlobalKey<FormState>();
    String name = '';
    String email = '';
    String phone = '';
    String address = '';
    String specialty = '';
    String description = '';

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
                print("Error to create a new trainer");
              }
            },
            builder: (context, state) {
              bool isLoading = state is TrainerLoading;
              return AlertDialog(
                title: Text('Create a New Trainer'),
                content: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the trainer name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            name = value!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the trainer email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            email = value!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Phone'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the trainer phone number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            phone = value!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Address'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the trainer address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            address = value!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Specialty'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the specialty';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            specialty = value!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Description'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the description';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            description = value!;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text('Create'),
                    onPressed: isLoading
                        ? null
                        : () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
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
        title: 'Pending Trainer Requests',
        scaffoldKey: _scaffoldKey,
        body: Column(
          children: [
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                ),
                onPressed: () => _showAddTrainerDialog(context),
                child: Text(
                  'Create a New Trainer',
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
                      return Center(child: CircularProgressIndicator());
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
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                trainer.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Email: ${trainer.email}',
                                    style: TextStyle(color: ColorManager.bc4),
                                  ),
                                  Text(
                                    'Specialty: ${trainer.specialty}',
                                    style: TextStyle(color: ColorManager.bc3),
                                  ),
                                ],
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 16,
                              ),
                              onTap: () {

                              },
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
