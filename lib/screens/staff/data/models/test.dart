/*
abstract class SecretariaLyoutStates {}

class SecretariaLyoutInitialStates extends SecretariaLyoutStates{}

class SecretariaLyoutChangeNavBarStates extends SecretariaLyoutStates{}

class SecretariaLyoutChangePassVisibilityState extends SecretariaLyoutStates{}

class ChangeBottomSheetState extends SecretariaLyoutStates{}

class ShowAppointmentState extends SecretariaLyoutStates{}

class selectDateState extends SecretariaLyoutStates{}

class ShowWaitingDayState extends SecretariaLyoutStates{}

class ShowApproveDayState extends SecretariaLyoutStates{}

class changeNameDoctorState extends SecretariaLyoutStates{}

class showDetailsState extends SecretariaLyoutStates{}

class showTimesState extends SecretariaLyoutStates{}

class changePhotoState extends SecretariaLyoutStates{}

class IndexWorkDayLoadingState extends SecretariaLyoutStates{}
class IndexWorkDaySuccssesState extends SecretariaLyoutStates{}
class IndexWorkDayErrorState extends SecretariaLyoutStates{}

class showTimeDayLoadingState extends SecretariaLyoutStates{}
class showTimeDaySuccssesState extends SecretariaLyoutStates{}
class showTimeDayErrorState extends SecretariaLyoutStates{}

class PatientProfLoadingState extends SecretariaLyoutStates{}
class PatientProfSuccssesState extends SecretariaLyoutStates{}
class PatientProfErrorState extends SecretariaLyoutStates{}

class PatientListLoadingState extends SecretariaLyoutStates{}
class PatientListSuccssesState extends SecretariaLyoutStates{}
class PatientListErrorState extends SecretariaLyoutStates{}

class PatientRegisterLoadingState extends SecretariaLyoutStates{}
class PatientRegisterSuccssesState extends SecretariaLyoutStates{}
class PatientRegisterErrorState extends SecretariaLyoutStates{}

class ChargeWalletLoadingState extends SecretariaLyoutStates{}
class ChargeWalletSuccssesState extends SecretariaLyoutStates{}
class ChargeWalletErrorState extends SecretariaLyoutStates{}

class LogOutLoadingState extends SecretariaLyoutStates{}
class LogOutSuccssesState extends SecretariaLyoutStates{}
class LogOutErrorState extends SecretariaLyoutStates{}

class ApppintmentListLoadingState extends SecretariaLyoutStates{}
class ApppintmentListSuccssesState extends SecretariaLyoutStates{}
class ApppintmentListErrorState extends SecretariaLyoutStates{}

class ApppintmentListByDateLoadingState extends SecretariaLyoutStates{}
class ApppintmentListByDateSuccssesState extends SecretariaLyoutStates{}
class ApppintmentListByDateErrorState extends SecretariaLyoutStates{}

class ApproveApppintmentListByDateLoadingState extends SecretariaLyoutStates{}
class ApproveApppintmentListByDateSuccssesState extends SecretariaLyoutStates{}
class ApproveApppintmentListByDateErrorState extends SecretariaLyoutStates{}

class AppointmentListDoctorLoadingState extends SecretariaLyoutStates{}
class AppointmentListDoctorSuccssesState extends SecretariaLyoutStates{}
class AppointmentListDoctorErrorState extends SecretariaLyoutStates{}

class DateWaitingAppointmentLoadingState extends SecretariaLyoutStates{}
class DateWaitingAppointmentSuccssesState extends SecretariaLyoutStates{}
class DateWaitingAppointmentErrorState extends SecretariaLyoutStates{}

class DateApproveAppointmentLoadingState extends SecretariaLyoutStates{}
class DateApproveAppointmentSuccssesState extends SecretariaLyoutStates{}
class DateApproveAppointmentErrorState extends SecretariaLyoutStates{}

class ViewInfoHandleLoadingState extends SecretariaLyoutStates{}
class ViewInfoHandleSuccssesState extends SecretariaLyoutStates{}
class ViewInfoHandleErrorState extends SecretariaLyoutStates{}

class ApproveTheAppointmentLoadingState extends SecretariaLyoutStates{}
class ApproveTheAppointmentSuccssesState extends SecretariaLyoutStates{}
class ApproveTheAppointmentErrorState extends SecretariaLyoutStates{}

class CancelAppointmentLoadingState extends SecretariaLyoutStates{}
class CancelAppointmentSuccssesState extends SecretariaLyoutStates{}
class CancelAppointmentErrorState extends SecretariaLyoutStates{}

class DeleteAppointmentLoadingState extends SecretariaLyoutStates{}
class DeleteAppointmentSuccssesState extends SecretariaLyoutStates{}
class DeleteAppointmentErrorState extends SecretariaLyoutStates{}

class HandelApppintmentLoadingState extends SecretariaLyoutStates{}
class HandelApppintmentSuccssesState extends SecretariaLyoutStates{}
class HandelApppintmentErrorState extends SecretariaLyoutStates{}

class DoctorListLoadingState extends SecretariaLyoutStates{}
class DoctorListSuccssesState extends SecretariaLyoutStates{}
class DoctorListErrorState extends SecretariaLyoutStates{}

class DoctorProfLoadingState extends SecretariaLyoutStates{}
class DoctorProfSuccssesState extends SecretariaLyoutStates{}
class DoctorProfErrorState extends SecretariaLyoutStates{}

class DoctorListByDepartmentLoadingState extends SecretariaLyoutStates{}
class DoctorListByDepartmentSuccssesState extends SecretariaLyoutStates{}
class DoctorListByDepartmentErrorState extends SecretariaLyoutStates{}

class WorkTimeListLoadingState extends SecretariaLyoutStates{}
class WorkTimeListSuccssesState extends SecretariaLyoutStates{}
class WorkTimeListErrorState extends SecretariaLyoutStates{}

class SecretariaProfLoadingState extends SecretariaLyoutStates{}
class SecretariaProfSuccssesState extends SecretariaLyoutStates{}
class SecretariaProfErrorState extends SecretariaLyoutStates{}

class StoreAppointmentSecLoadingState extends SecretariaLyoutStates{}
class StoreAppointmentSecSuccssesState extends SecretariaLyoutStates{}
class StoreAppointmentSecErrorState extends SecretariaLyoutStates{}*/

/*import 'package:dio/dio.dart';

import '../utils/constants.dart';

class DioHelper
{
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(

        baseUrl: '${Constants.baseURL}api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };

    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }
}*/

/*import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:patient_app/core/utils/constants.dart';

import '../../../../core/api/services/local/cache_helper.dart';
import '../../../core/api/dio_helper.dart';
import '../../../core/models/secretaria/secretaria_appointment/approve_the_appointment_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/cancel_appointment_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/date_approve_appointment_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/date_waiting_appointment_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/delete_appointment_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/handel_appointment_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/index_appointment_by_date_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/index_appointment_doctor_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/index_approve_appointment_by_date_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/view_info_handle_model.dart';
import '../../../core/models/secretaria/secretaria_doctor/index_by_department.dart';
import '../../../core/models/secretaria/secretaria_doctor/view_doctor_model.dart';
import '../../../core/models/secretaria/secretaria_patient/charge_wallet_model.dart';
import '../../../core/models/secretaria/secretaria_patient/index_patient_model.dart';
import '../../../core/models/secretaria/secretaria_patient/index_work_day_model.dart';
import '../../../core/models/secretaria/secretaria_patient/register_patient_model.dart';
import '../../../core/models/secretaria/secretaria_patient/store_appointment_sec_model.dart';
import '../../../core/models/secretaria/secretaria_patient/view_patient_model.dart';
import '../../../core/models/secretaria/secretaria_secretaria/view_secretary_model.dart';
import '../../../core/utils/app_assets.dart';
import '../appointments_list_date/appointments_list_date.dart';
import '../doctor_list/doctor_list.dart';
import '../patient_list/patient_list.dart';
import 'api_states.dart';

class SecretariaLyoutCubit extends Cubit<SecretariaLyoutStates> {
  SecretariaLyoutCubit() : super(SecretariaLyoutInitialStates());

  static SecretariaLyoutCubit get(context) => BlocProvider.of(context);

  Map<String, dynamic>? perInfo;
  dynamic errors;
  ////////////////////
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
///////////////////
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
      ),
      label: 'Patient',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.medical_information,
      ),
      label: 'Doctor',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.calendar_month_sharp,
      ),
      label: 'Appointment',
    ),
  ];

  List<Widget> page = [
    const PatientList(),
    const DoctorList(),
    const AppointmentsListDate(),
    *//*AppointmentsRequestsView(token: CacheHelper.getData(key: 'Token')),*//*
  ];

  void changBottomNavBar(int index) {
    currentIndex = index;
    emit(SecretariaLyoutChangeNavBarStates());
    if (index == 0) {
      indexPatient();
    } else if (index == 1) {
      viewSecretary(user_id: getMyId());
    }else if (index == 2) {
      dateHaveWaitingAppointment();
    }
  }

  IconData suffixIcon = Icons.visibility_off;
  bool isPassShow = true;

  void changePassVisibility() {
    isPassShow = !isPassShow;
    suffixIcon = isPassShow ? Icons.visibility_off : Icons.visibility;
    emit(SecretariaLyoutChangePassVisibilityState());
  }

  bool isBottomSheetShown = false;

  void changeBottomSheet({required bool isShow}) {
    isBottomSheetShown = isShow;
    emit(ChangeBottomSheetState());
  }

  bool showAppointments = false;
  bool isSelected = false;
  int indexList = 0;
  List days = [
    //Tuesday Oct 08
    DateFormat.EEEE().format(DateTime.now()),
    for (int i = 1; i <= 30; i++)
      DateFormat.EEEE().format(DateTime.now().add(Duration(days: i))),
  ];
  List month = [
    //Tuesday Oct 08
    DateFormat.MMM().format(DateTime.now()),
    for (int i = 1; i <= 30; i++)
      DateFormat.MMM().format(DateTime.now().add(Duration(days: i))),
  ];
  List dayNum = [
    //Tuesday Oct 08
    DateFormat.d().format(DateTime.now()),
    for (int i = 1; i <= 30; i++)
      DateFormat.d().format(DateTime.now().add(Duration(days: i))),
  ];
  final List colorItem = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  void showAppointment() {
    showAppointments = !showAppointments;
    isSelected = !isSelected;
    colorItem[indexList] = !colorItem[indexList];
    emit(ShowAppointmentState());
  }

  void selectDate()
  {
    isSelected = ! isSelected;
    colorItem[indexList] =! colorItem[indexList];
    emit(selectDateState());
  }

  String? doctotName;

  void changeNameDoctor({required String name}){
    doctotName = name;
    emit(changeNameDoctorState());
  }

  bool showDetail = false;

  void showDetails(){
    showDetail = true;
    emit(showDetailsState());
  }

  bool showTime = false;

  void showTimes(){
    showTime = !showTime;
    emit(showTimesState());
  }

  bool isSelectedTime = false;
  int indexTimeList = 0;
  Map<String, dynamic> color = {
    //'Select' : false,
    *//*false : Colors.grey.shade400,*//*
  };
  final List temColor = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  Color selectItemColor = Colors.purple.shade300;

  void selectDay(){
    isSelectedTime = ! isSelectedTime;
    temColor[indexTimeList] =! temColor[indexTimeList];
    color['Select'] == true ? selectItemColor = Colors.purple.shade300 : selectItemColor = Colors.grey.shade400;
    emit(showTimesState());
  }

  List workeDayList = [];
  Map<String, dynamic> StartTimeDay = {
    'Sunday' : '',
    'Monday' : '',
    'Tuesday' : '',
    'Wednesday' : '',
    'Thursday' : '',
    'Friday' : '',
    'Saturday' : '',
  };
  Map<String, dynamic> EndTimeDay = {
    'Sunday' : '',
    'Monday' : '',
    'Tuesday' : '',
    'Wednesday' : '',
    'Thursday' : '',
    'Friday' : '',
    'Saturday' : '',
  };
  Map<String, dynamic> availableDay = {
    'Sunday' : false,
    'Monday' : false,
    'Tuesday' : false,
    'Wednesday' : false,
    'Thursday' : false,
    'Friday' : false,
    'Saturday' : false,
  };

  IndexWorkDayModel? indexWorkDayModel;

  void IndexWorkDay({required int doctorId,}){
    emit(IndexWorkDayLoadingState());
    DioHelper.getData(
        url: 'indexWorkDay', query: null, token: Constants.adminToken
    ).then((value) {
      workeDayList.clear();
      workeTimeList.clear();
      timeList.clear();
      indexWorkDayModel = IndexWorkDayModel.fromJson(value.data);
      print(value.toString());
      print(indexWorkDayModel!.data[1].doctorId);
      for(int i = 0; i < indexWorkDayModel!.data.length; i++)
      {
        if(doctorId == indexWorkDayModel!.data[i].doctorId)
        {
          workeDayList.add(indexWorkDayModel!.data[i].day);

          availableDay[indexWorkDayModel!.data[i].day] = true;

          StartTimeDay[indexWorkDayModel!.data[i].day] = indexWorkDayModel!.data[i].startTime;

          EndTimeDay[indexWorkDayModel!.data[i].day] = indexWorkDayModel!.data[i].endTime;
        }
      }
      print('workeDayList: $workeDayList');
      print('StartTimeDay: $StartTimeDay');
      print('EndTimeDay: $EndTimeDay');
      print('availableDay: $availableDay');
      emit(IndexWorkDaySuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(IndexWorkDayErrorState());
    });
  }

  List timeList = [];
  List availableTimes = [];
  Map<String, dynamic> workeTimeList = {
    'Sunday' : [],
    'Monday' : [],
    'Tuesday' : [],
    'Wednesday' : [],
    'Thursday' : [],
    'Friday' : [],
    'Saturday' : [],
  };

  void showTimeDay({
    required String day,
    String? startTimeDay,
    String? endTimeDay,
  })
  {
    timeList.clear();
    workeTimeList.clear();
    emit(showTimeDayLoadingState());
    for (var time = DateFormat.Hm().parse(startTimeDay ?? StartTimeDay[day]); time.isBefore(DateFormat.Hm().parse(endTimeDay ?? EndTimeDay[day]).add(const Duration(minutes: 30)));)
    {
      var time12 = DateTime.parse(time.toString()).toString().replaceRange(0, 11, '').replaceRange(5, 12, '');
      int h = int.parse(time12.split(":").first);
      int m = int.parse(time12.split(":").last.split(" ").first);
      String send = "";
      if (h > 12) {
        var temp = h - 12;
        send =
        "0$temp:${m.toString().length == 1 ? "0$m" : m.toString()} " "PM";
      } else {
        send =
        "$h:${m.toString().length == 1 ? "0$m" : m.toString()}  " "AM";
      }
      timeList.add(send);
      workeTimeList[day] = timeList;
      time = time.add(const Duration(minutes: 30));
      print('time12: $time12');
      print('send: $send');
      print('time: $time');
    }
    availableTimes = workeTimeList[day];
    color = {for (var item in availableTimes) '$item' : false};
    *//*color.forEach((key, value) {
      key = availableTimes.;
      false;
    });*//*
    print('color: $color');
    print('workeTimeList: ${workeTimeList[day].length}');
    print('workeTimeListIndex: ${workeTimeList[day][0]}');
    print('availableTimes: ${availableTimes}');
    emit(showTimeDaySuccssesState());
    *//*if(workeTimesInDay == day)
    {
      for(int i = 0; i < indexWorkDayModel!.data.length; i++)
      {
        print(indexWorkDayModel!.data[i].id);
        print(dayIndex[day]);
        if (indexWorkDayModel!.data[i].id == dayIndex[day]) {
          for (var time = timeFormat.parse(indexWorkDayModel!.data[i].startTime); time.isBefore(timeFormat.parse(indexWorkDayModel!.data[i].endTime).add(Duration(minutes: 30)));)
          {
            var time12 = DateTime.parse(time.toString()).toString().replaceRange(1, 12, '').replaceRange(5, 12, '');
            int h = int.parse(time12.split(":").first);
            int m = int.parse(time12.split(":").last.split(" ").first);
            String send = "";
            if (h > 12) {
              var temp = h - 12;
              send =
                  "0$temp:${m.toString().length == 1 ? "0" + m.toString() : m.toString()} " +
                      "PM";
            } else {
              send =
                  "$h:${m.toString().length == 1 ? "0" + m.toString() : m.toString()}  " +
                      "AM";
            }
            workeTimeList.add(send);
            time = time.add(Duration(minutes: 30));
            workeTimesInDay[indexWorkDayModel!.data[i].day] = workeTimeList;
          }
        }
      }
    }
    availableTimes = workeTimeList;
    print(availableTimes);
    //print(workeTimeList);*//*
  }

  String paPhoto = AppAssets.defaultImagePurple;

  void changePhoto({required String gender})
  {
    paPhoto = gender == 'Male' ? AppAssets.paMa
        : AppAssets.paFe;
    emit(changePhotoState());
  }

  late IndexPatientModel indexPatientModel;

  void indexPatient() {
    emit(PatientListLoadingState());
    DioHelper.getData(
        url: 'indexPatient', query: null, token: Constants.adminToken
    ).then((value) {
      indexPatientModel = IndexPatientModel.fromJson(value.data);
      print(value.toString());
      print(indexPatientModel.patient[0].user.firstName);
      emit(PatientListSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(PatientListErrorState());
    });
  }

  late ViewPatientModel viewPatientModel;

  void viewPatient({
    required int user_id,
  }) {
    emit(PatientProfLoadingState());
    DioHelper.postData(
        url: 'viewPatient',
        data: {
          'user_id': user_id,
        },
        token: Constants.adminToken)
        .then((value) {
      print(value.data);
      viewPatientModel = ViewPatientModel.fromJson(value.data);
      print(viewPatientModel.message);
      print(viewPatientModel.patient.user.firstName);
      emit(PatientProfSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(PatientProfErrorState());
    });
  }

  late RegisterPatientModel registerPatientModel;

  void registerPatient({
    required String first_name,
    required String last_name,
    required String phone_num,
    required String birth_date,
    required String gender,
    required String address,
    required String email,
    required String password,
    required String FCMToken,
  }) {
    emit(PatientRegisterLoadingState());
    DioHelper.postData(
        url: 'registerPatient',
        data: {
          'first_name': first_name,
          'last_name': last_name,
          'phone_num': phone_num,
          'birth_date': birth_date,
          'gender': gender,
          'address': address,
          'email': email,
          'password': password,
          'FCMToken': FCMToken,
        },
        token: CacheHelper.getData(key: 'Token'))
        .then((value) {
      print(value.data);
      registerPatientModel = RegisterPatientModel.fromJson(value.data);
      print(value.toString());
      print(registerPatientModel.token);
      print(registerPatientModel.role);
      emit(PatientRegisterSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(PatientRegisterErrorState());
    });
  }

  late ChargeWalletModel chargeWalletModel;

  void chargeWallet({
    required double value,
    required int id,
  }) {
    emit(ChargeWalletLoadingState());
    DioHelper.postData(
        url: 'wallet/patient/$id',
        data: {
          'value': value,
        },
        token: CacheHelper.getData(key: 'Token'))
        .then((value) {
      print(value.data);
      chargeWalletModel = ChargeWalletModel.fromJson(value.data);
      print(chargeWalletModel.success);
      print(chargeWalletModel.message);
      emit(ChargeWalletSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(ChargeWalletErrorState());
    });
  }

  //late IndexPatientModel indexPatientModel;

  *//*void logOut({
    required BuildContext context
  })
  {
    emit(LogOutLoadingState());
    DioHelper.getData(
            url: 'logout',
            query: null,
            token: CacheHelper.getData(key: 'Token'))
        .then((value) {
      //indexPatientModel = IndexPatientModel.fromJson(value.data);
      print(value.toString());
      //print(indexPatientModel.patient[0].user.firstName);
      emit(LogOutSuccssesState());
      CacheHelper.deletData(key: 'Token');
      CacheHelper.deletData(key: 'Role');
      Navigator.pop(context, LoginView.route);
    }).catchError((error) {
      print(error.toString());
      emit(LogOutErrorState());
    });
  }
  *//*

  *//*late IndexAppointmentModel indexAppointmentModel;

  void indexAppointment() {
    emit(ApppintmentListLoadingState());
    DioHelper.getData(
            url: 'indexAppointment',
            query: null,
            token: CacheHelper.getData(key: 'Token'))
        .then((value) {
      indexAppointmentModel = IndexAppointmentModel.fromJson(value.data);
      print(value.toString());
      print(indexAppointmentModel.appointment[0].date);
      emit(ApppintmentListSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(ApppintmentListErrorState());
    });
  }
  *//*

  late IndexAppointmentByDateModel indexAppointmentByDateModel;

  Future<void> indexAppointmentByDate({
    required String date,
  }) async {
    emit(ApppintmentListByDateLoadingState());
    await DioHelper.postData(
        url: 'indexAppointmentByDate',
        data: {
          'date': date,
        },
        token: await CacheHelper.getData(key: 'Token'))
        .then((value) {
      log('xxxxxxxxxxxxx $date');
      print(value.data);
      indexAppointmentByDateModel =
          IndexAppointmentByDateModel.fromJson(value.data);
      print(indexAppointmentByDateModel.appointment[0].status);
      print(indexAppointmentByDateModel.success);
      emit(ApppintmentListByDateSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(ApppintmentListByDateErrorState());
    });
  }

  late IndexApproveAppointmentByDateModel indexApproveAppointmentByDateModel;

  void indexApproveAppointmentByDate({
    required String date,
    required int doctor_id,
  }) {
    emit(ApproveApppintmentListByDateLoadingState());
    DioHelper.postData(
        url: 'indexApproveAppointmentByDate',
        data: {
          'date': date,
          'doctor_id': doctor_id,
        },
        token: CacheHelper.getData(key: 'Token'))
        .then((value) {
      print(value.data);
      indexApproveAppointmentByDateModel =
          IndexApproveAppointmentByDateModel.fromJson(value.data);
      print(indexApproveAppointmentByDateModel.appointment[0].status);
      print(indexApproveAppointmentByDateModel.success);
      emit(ApproveApppintmentListByDateSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(ApproveApppintmentListByDateErrorState());
    });
  }

  late IndexAppointmentDoctorModel indexAppointmentDoctorModel;

  void indexAppointmentDoctor({
    required int doctor_id,
  }) {
    emit(AppointmentListDoctorLoadingState());
    DioHelper.postData(
        url: 'indexAppointmentDoctor',
        data: {
          'doctor_id': doctor_id,
        },
        token: CacheHelper.getData(key: 'Token'))
        .then((value) {
      print(value.data);
      indexAppointmentDoctorModel =
          IndexAppointmentDoctorModel.fromJson(value.data);
      print(indexAppointmentDoctorModel.appointment[0].time);
      print(indexAppointmentDoctorModel.success);
      emit(AppointmentListDoctorSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(AppointmentListDoctorErrorState());
    });
  }

  late DateWaitingAppointmentModel dateWaitingAppointmentModel;

  void dateHaveWaitingAppointment() {
    emit(DateWaitingAppointmentLoadingState());
    DioHelper.postData(
        url: 'DateHaveAppointmentToHandel',
        data: {},
        token: CacheHelper.getData(key: 'Token'))
        .then((value) {
      print(value.data);
      dateWaitingAppointmentModel =
          DateWaitingAppointmentModel.fromJson(value.data);
      print(dateWaitingAppointmentModel.message);
      print(dateWaitingAppointmentModel.success);
      emit(DateWaitingAppointmentSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(DateWaitingAppointmentErrorState());
    });
  }

  late DateApproveAppointmentModel dateApproveAppointmentModel;

  void dateHaveApproveAppointment({
    required int doctor_id,
  }) {
    emit(DateApproveAppointmentLoadingState());
    DioHelper.postData(
        url: 'indexApproveAppointment',
        data: {
          'doctor_id': doctor_id,
        },
        token: CacheHelper.getData(key: 'Token'))
        .then((value) {
      print(value.data);
      dateApproveAppointmentModel =
          DateApproveAppointmentModel.fromJson(value.data);
      print(dateApproveAppointmentModel.message);
      print(dateApproveAppointmentModel.appointment[0].date);
      emit(DateApproveAppointmentSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(DateApproveAppointmentErrorState());
    });
  }

  late ViewInfoHandleModel viewInfoHandleModel;

  void viewInfoHandle({
    required int id,
  }) {
    emit(ViewInfoHandleLoadingState());
    DioHelper.getData(
        url: 'handled/view/$id',
        query: null,
        token: CacheHelper.getData(key: 'Token'))
        .then((value) {
      viewInfoHandleModel = ViewInfoHandleModel.fromJson(value.data);
      print(value.toString());
      print(viewInfoHandleModel.appointment.doctor.consultationPrice);
      emit(ViewInfoHandleSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(ViewInfoHandleErrorState());
    });
  }

  late ApproveTheAppointmentModel approveTheAppointmentModel;

  void approveTheAppointment({
    required int id,
  }) {
    emit(ApproveTheAppointmentLoadingState());
    DioHelper.postData(
        url: 'approveTheAppointment/$id',
        data: {},
        token: CacheHelper.getData(key: 'Token'))
        .then((value) {
      print(value.data);
      approveTheAppointmentModel =
          ApproveTheAppointmentModel.fromJson(value.data);
      print(approveTheAppointmentModel.message);
      print(approveTheAppointmentModel.success);
      emit(ApproveTheAppointmentSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(ApproveTheAppointmentErrorState());
    });
  }

  late CancelAppointmentModel cancelAppointmentModel;

  void cancelAppointment({
    required String cancel_reason,
    required int id,
  }) {
    emit(CancelAppointmentLoadingState());
    DioHelper.postData(
        url: 'cancelAppointment/$id',
        data: {
          'cancel_reason': cancel_reason,
        },
        token: CacheHelper.getData(key: 'Token'))
        .then((value) {
      print(value.data);
      cancelAppointmentModel = CancelAppointmentModel.fromJson(value.data);
      print(cancelAppointmentModel.message);
      print(cancelAppointmentModel.success);
      emit(CancelAppointmentSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(CancelAppointmentErrorState());
    });
  }

  late DeleteAppointmentModel deleteAppointmentModel;

  void deleteAppointment({
    required int id,
  }) {
    emit(DeleteAppointmentLoadingState());
    DioHelper.postData(
        url: 'deleteAppointment',
        data: {
          'id': id,
        },
        token: Constants.patientToken)
        .then((value) {
      print(value.data);
      deleteAppointmentModel = DeleteAppointmentModel.fromJson(value.data);
      print(deleteAppointmentModel.message);
      print(deleteAppointmentModel.success);
      if (deleteAppointmentModel.success) {
        emit(DeleteAppointmentSuccssesState());
      } else {
        emit(DeleteAppointmentErrorState());
      }
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(DeleteAppointmentErrorState());
    });
  }

  late HandelApppintmentModel handelApppintmentModel;

  void handelApppintment({
    required String date,
    required String time,
    required String status,
    required int id,
  }) {
    emit(HandelApppintmentLoadingState());
    DioHelper.postData(
        url: 'AppointmentHandle',
        data: {
          'date': date,
          'time': time,
          'status': status,
          'id': id,
        },
        token: CacheHelper.getData(key: 'Token'))
        .then((value) {
      print(value.data);
      handelApppintmentModel = HandelApppintmentModel.fromJson(value.data);
      print(handelApppintmentModel.appointment.cancelReason);
      print(handelApppintmentModel.success);
      emit(HandelApppintmentSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(HandelApppintmentErrorState());
    });
  }

  *//*late IndexDoctorModel indexDoctorModel;

  void indexDoctor()
  {
    emit(DoctorListLoadingState());
    DioHelperG.getDataG(
        url: 'indexDoctor',
        query: null,
        token: Constants.adminToken
    ).then((value) {
      indexDoctorModel = IndexDoctorModel.fromJson(value.data);
      print(value.toString());
      print(indexDoctorModel!.doctor[0].user.firstName);
      emit(DoctorListSuccssesState());
    }).catchError((error){
      print(error.toString());
      emit(DoctorListErrorState());
    });
  }
  *//*

  late ViewDoctorModel viewDoctorModel;

  void viewDoctor({
    required int user_id,
  }) {
    emit(DoctorProfLoadingState());
    DioHelper.postData(
        url: 'viewDoctor',
        data: {
          'user_id': user_id,
        },
        token: Constants.adminToken)
        .then((value) {
      print(value.data);
      viewDoctorModel = ViewDoctorModel.fromJson(value.data);
      print(viewDoctorModel.message);
      print(viewDoctorModel.doctor.user.firstName);
      emit(DoctorProfSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(DoctorProfErrorState());
    });
  }

  late IndexDoctorByDepartmentModel indexDoctorByDepartmentModel;

  void indexDoctorByDepartment({
    required int department_id,
  }) {
    emit(DoctorListByDepartmentLoadingState());
    DioHelper.postData(
        url: 'doctors/indexByDepartment',
        data: {
          'department_id': department_id,
        },
        token: Constants.adminToken)
        .then((value) {
      print(value.data);
      indexDoctorByDepartmentModel =
          IndexDoctorByDepartmentModel.fromJson(value.data);
      print(indexDoctorByDepartmentModel.doctor[0].description);
      print(indexDoctorByDepartmentModel.success);
      emit(DoctorListByDepartmentSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(DoctorListByDepartmentErrorState());
    });
  }

  *//*IndexMyTimeModel? indexMyTimeModel;

  void indexMyTime()
  {
    emit(WorkTimeListLoadingState());
    DioHelperG.getDataG(
        url: 'indexMyTime',























        query: null,
        token: Constants.doctorToken
    ).then((value) {
      indexMyTimeModel = IndexMyTimeModel.fromJson(value.data);
      print(value.toString());
      print(indexMyTimeModel!.workDay[0].day);
      emit(WorkTimeListSuccssesState());
    }).catchError((error){
      print(error.toString());
      emit(WorkTimeListErrorState());
    });
  }*//*

  late ViewSecretaryModel viewSecretaryModel;

  void viewSecretary({
    required int user_id,
  }) {
    emit(SecretariaProfLoadingState());
    DioHelper.postData(
        url: 'viewSecretary',
        data: {
          'user_id': user_id,
        },
        token: Constants.adminToken)
        .then((value) {
      print(value.data);
      viewSecretaryModel = ViewSecretaryModel.fromJson(value.data);
      print(viewSecretaryModel.message);
      print(viewSecretaryModel.secretary.user.firstName);
      emit(SecretariaProfSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(SecretariaProfErrorState());
    });
  }

  late StoreAppointmentSecModel storeAppointmentSecModell;

  void StoreAppointmentSec({
    required String date,
    required String time,
    required String description,
    required int doctor_id,
    required String department_id,
    required int patient_id,
  })
  {
    emit(StoreAppointmentSecLoadingState());
    DioHelper.postData(
        url: 'storeAppointmentBySecr',
        data: {
          'date': date,
          'time': time,
          'description': description,
          'doctor_id': doctor_id,
          'department_id': department_id,
          'patient_id': patient_id,
        },
        token: Constants.patientToken
    ).then((value) {
      print(value.data);
      storeAppointmentSecModell = StoreAppointmentSecModel.fromJson(value.data);
      print(storeAppointmentSecModell.message);
      //print(storeAppointmentSecModell.appointment.date);
      emit(StoreAppointmentSecSuccssesState());
    }).catchError((error) {
      print(error.toString());
      errors = error;
      emit(StoreAppointmentSecErrorState());
    });
  }

  Map<String, dynamic> decode(String token) {
    final splitToken = token.split("."); // Split the token by '.'
    if (splitToken.length != 3) {
      throw const FormatException('Invalid token');
    }
    try {
      final payloadBase64 = splitToken[1]; // Payload is always the index 1
      // Base64 should be multiple of 4. Normalize the payload before decode it
      final normalizedPayload = base64.normalize(payloadBase64);
      // Decode payload, the result is a String
      final payloadString = utf8.decode(base64.decode(normalizedPayload));
      // Parse the String to a Map<String, dynamic>
      final decodedPayload = jsonDecode(payloadString);

      perInfo = decodedPayload;
      print(payloadString);
      // Return the decoded payload
      return decodedPayload;
    } catch (error) {
      throw const FormatException('Invalid payload');
    }
  }

  int getMyId() {
    perInfo = decode(CacheHelper.getData(key: 'Token'));

    return int.parse(perInfo!['sub']);
  }
}*/