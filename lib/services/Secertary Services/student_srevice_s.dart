//
//
// import 'package:dio/dio.dart';
//
// import '../../core/utils/shared_preferences_helper.dart';
// import '../../models/Secertary Model/add_model.dart';
// import '../dio_error.dart';
//
// class BeneficiaryService_S {
//   final Dio _dio = Dio();
//
//   Future<CreatBeneficiaryModel> addBeneficiary(Map<String, dynamic> beneficiaryData) async {
//     try {
//       final token = await SharedPreferencesHelper.getJwtToken();
//       final response = await _dio.post(
//         'http://127.0.0.1:8000/api/addbeneficiary',
//         data: beneficiaryData,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//           },
//         ),
//       );
//
//       if (response.statusCode == 200) {
//         return CreatBeneficiaryModel.fromJson(response.data);
//       } else {
//         throw Exception('Failed to add beneficiary');
//       }
//     } catch (e) {
//       throw Exception(DioErrorHandler.handleError(e));
//     }
//   }
// }
