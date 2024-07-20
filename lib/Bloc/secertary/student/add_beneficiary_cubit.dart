// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../services/Secertary Services/student_service.dart';
// import '../../../services/Secertary Services/student_srevice_s.dart';
// import 'add_beneficiary_state.dart';
//
// class AddBeneficiaryCubit extends Cubit<AddBeneficiaryState> {
//   final BeneficiaryService_S _service;
//
//   AddBeneficiaryCubit(this._service) : super(AddBeneficiaryInitial());
//
//   Future<void> addBeneficiary(Map<String, dynamic> beneficiaryData) async {
//     try {
//       emit(AddBeneficiaryLoading());
//       final response = await _service.addBeneficiary(beneficiaryData);
//       emit(AddBeneficiarySuccess(response));
//     } catch (e) {
//       emit(AddBeneficiaryError(e.toString()));
//     }
//   }
// }