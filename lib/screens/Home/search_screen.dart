import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/secertary/student/beneficiary_cubit.dart';
import '../../Bloc/secertary/student/beneficiary_state.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/shared_preferences_helper.dart';
import '../../widgets/general_widgets/common_scaffold.dart';
import '../Secertary_Screens/Student/beneficiary_details_screen.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;

  SearchResultsScreen({required this.query});

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();

}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late Future<String?> _userRoleFuture;

  @override
  void initState() {
    super.initState();
    _userRoleFuture = SharedPreferencesHelper.getUserRole();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return CommonScaffold(
      title: 'Search Results',
      scaffoldKey: scaffoldKey,
      body: FutureBuilder<String?>(
        future: _userRoleFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final userRole = snapshot.data;
          return BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
            builder: (context, state) {
              if (state is BeneficiaryLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is BeneficiaryLoaded) {
                if (state.beneficiaries.isEmpty) {
                  return Center(child: Text('No results found.'));
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                        decoration: BoxDecoration(
                          color: ColorManager.bc2,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'ID',
                                style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.bc5),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Name',
                                style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.bc5),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Email',
                                style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.bc5),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Phone',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.bc5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.beneficiaries.length,
                          itemBuilder: (context, index) {
                            final beneficiary = state.beneficiaries[index];
                            return Card(
                              color: ColorManager.bc2,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        beneficiary.id?.toString() ?? '',
                                        style: TextStyle(color: ColorManager.bc5, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        beneficiary.name ?? '',
                                        style: TextStyle(color: ColorManager.bc5, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        beneficiary.email ?? '',
                                        style: TextStyle(color: ColorManager.bc5, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    // Expanded(
                                    //   flex: 3,
                                    //   child: Text(
                                    //     beneficiary.numberPhone ?? '',
                                    //     textAlign: TextAlign.start,
                                    //     style: TextStyle(color: ColorManager.bc5, fontWeight: FontWeight.w500),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                onTap: () {
                                  if (userRole == 'secretary' || userRole == 'manager') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BeneficiaryDetailsScreen(
                                          beneficiaryId: beneficiary.id!,
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BeneficiaryDetailsScreen(
                                          beneficiaryId: beneficiary.id!,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is BeneficiaryError) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: Text('No results found.'));
              }
            },
          );
        },
      ),
    );
  }
}
