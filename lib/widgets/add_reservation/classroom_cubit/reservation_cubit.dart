import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:memoire/modules/classroom_amphi_screen/classroom_amphi_screen.dart';
import 'package:memoire/modules/reservations/classroom_reservation_screen.dart';
import 'package:memoire/widgets/add_clasrrom/cubit/add_cubit.dart';
import 'package:memoire/widgets/add_reservation/classroom_cubit/reservation_list.dart';
import '../../../models/reservation_model/classroom_reservation,_model.dart';
import '../../../modules/home_screen/home_screen.dart';
import '../../../modules/reservations/notifications.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/cache_helper.dart';
import '../../../shared/network/dio_helper.dart';

class ReservationCubit extends Cubit<ReservationStates>{
  ReservationCubit() : super(ReservationInitialState());
  static ReservationCubit get(context)=>BlocProvider.of(context);
late ReservationModel reservationModel;
late ReservationData reservationData;
  void addReservation({
    required String  time,
    required String  date,
    required String goal,
    required id_user,
    required id_classroom,
    required etat,
    required context
  }){
    emit(ReservationAddLoadingState());
    DioHelper.postData(url: 'http://127.0.0.1:8000/api/reservation/add', data:{
      'time':time,
      'date':date,
      'goal':goal,
      'id_classroom':id_classroom,
      'id_user':id_user,
      'etat':CacheHelper.getData(key: 'role')=='admin'?etat='accepted':etat==true?'waiting':'accepted'

    },).then((value) {
      reservationModel=ReservationModel.fromJson(value.data);
      print('data used ${reservationModel.data!.etat}');
      print(value.data);
      print('salle added');
      flutterToast(msg: 'reservation Added Successfully', state: toastStates.success).then((value) {
        navigateTo(context, ClassroomScreen());
        getReservation(context);
        getAllReservation(context);
        getParticularClassroom();
      });
      emit(ReservationADDSuccessState());
    }).catchError((onError){
      flutterToast(msg: 'classroom already reserved!', state: toastStates.success).then((value) =>navigateTo(context, ClassroomScreen()));
      print(onError);
      emit(ReservationAddErrorState(onError.toString()));
    });
  }
  // get reservation by id

  List<ReservationData> reservations=[];
  void getReservation(context){
    //getReservationall(context, id);
    reservations=[];
    // print(classModel!.data!.name);
    emit(ReservationGetLoadingState());
    DioHelper.getData(url: 'http://127.0.0.1:8000/api/findList/${CacheHelper.getData(key: 'ID')}').then((value) {
        value.data.forEach((e){
        reservationData=ReservationData.fromJson(e);
        reservations.add(ReservationData.fromJson(e));
      });
      // this one worked fine
      emit(ReservationGetSuccessState());
    }).catchError((onError){
      print(onError);
      emit(ReservationGetErrorState());
    });
  }

  List<ReservationData>particular=[];
  void getParticularClassroom(){
    particular=[];
    emit(ReservationGetLoadingState());
    DioHelper.getData(url: 'http://127.0.0.1:8000/api/getParticular').then((value) {
      print(' data is ${value.data}');
      value.data.forEach((e){
        reservationData=ReservationData.fromJson(e);
        print('etat  ${reservationData.etat}');
        particular.add(ReservationData.fromJson(e));
      });
      // this one worked fine
      emit(ReservationGetSuccessState());
    }).catchError((onError){
      print(onError);
      emit(ReservationGetErrorState());
    });

  }
  List<ReservationData> allReservationsByID=[];
   getAllReservationsByID(context,id){
     allReservations=[];
    // print(classModel!.data!.name);
    emit(ReservationallGetLoadingState());
    DioHelper.getData(url: 'http://127.0.0.1:8000/api/findList/$id').then((value) {
      //print('hello world');
      // classModel=ClassModel.fromJson(value.data);
      print(' list data is ${value.data}');
      value.data.forEach((e){
        reservationData=ReservationData.fromJson(e);
        print(reservationData.time);
        allReservations.add(ReservationData.fromJson(e));
      });
      // this one worked fine

      emit(ReservationallGetSuccessState());
    }).catchError((onError){
      print(onError);
      emit(ReservationallGetErrorState());
    });
    return allReservations.length;
  }
// update a reservation
  List<ReservationData> allReservations=[];
  void getAllReservation(context){
    //getReservationall(context, id);
    allReservations=[];
    // print(classModel!.data!.name);
    emit(ReservationGetLoadingState());
    DioHelper.getData(url: 'http://127.0.0.1:8000/api/getReservations').then((value) {
      print(value.data);
      //print('hello world');
      // classModel=ClassModel.fromJson(value.data);
      value.data.forEach((e){
        reservationData=ReservationData.fromJson(e);
       // print(' time is : ${reservationData.time}');
        allReservations.add(ReservationData.fromJson(e));
        print(allReservations.length);
      });
      // this one worked fine
      /*salles=value.data;
      print(salles);
      print(value.data[0]);
       data=Data.fromJson(value.data[0]);
      print(data.name);*/
      // print(classModel);
      //salles.add(value.data);
      //print(value.data);
      //  salles=value.data;
      // print(salles.length);
      //print(s);
      /* s.forEach((element) {
      // print(element['id']);
      classModel=ClassModel.fromJson(element['id']);
      print(ClassModel.fromJson(element['id']));
     });*/
      //print(salles.length);
      //
      //print(salles[0][1]['name']);
      //print(salles[0][0]['name']);
      // salles.forEach((element) {
      // s=element.data();
      //  print(element);
      // classModel=ClassModel.fromJson(element);
      // s.add(element.data());
      // print('the sec list is $s');
      // });
      emit(ReservationGetSuccessState());
    }).catchError((onError){
      flutterToast(msg: 'Something went wrong, try again!', state: toastStates.success).then((value) =>navigateTo(context, ClassroomScreen()));

      print(onError.toString());
      emit(ReservationGetErrorState());
    });
  }


  void updateReservation({
   required id,
    required context,
    required String  time,
    required String  date,
    required String goal,

}){
    emit(ReservationUpdateLoadingState());
    DioHelper.updateData(url: 'http://127.0.0.1:8000/api/reservation/$id', data: {
      'time':time,
      'date':date,
      'goal':goal,
      'id_classroom':'${reservationData.id_classroom}',
      'id_user':'${CacheHelper.getData(key: 'ID')}',
    }).then((value) {
      flutterToast(msg: 'reservation updated Successfully', state: toastStates.success).then((value) {
        navigateTo(context, ClassroomReservationScreen());
        getReservation(context);
        getAllReservation(context);
        getParticularClassroom();
      });
      print(value.data);
      print('all updated !');
      // print(value.data);
      //salles=value.data;
      // print(salles);
      emit(ReservationUpdateSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(ReservationUpdateErrorState());
    });
  }


  void updateReservationForAdmin({
    required id,
    required context,
    required String  time,
    required String  date,
    required String goal,
    required id_user,
    required etat
  }){
    emit(ReservationUpdateLoadingState());
    DioHelper.updateData(url: 'http://127.0.0.1:8000/api/reservation/$id', data: {
      'time':time,
      'date':date,
      'goal':goal,
      'id_classroom':'${reservationData.id_classroom}',
      'id_user':id_user,
      'etat':etat==true?'waiting':'accepted'
    }).then((value) {
      print(value.data);
      print('all updated !');
      flutterToast(msg: 'reservation updated!', state: toastStates.success).then((value) {
       // Navigator.of(context).pop(HomeScreen());
       // navigateTo(context, HomeScreen());
        //Navigator.pop(context);
        navigateTo(context, ClassroomReservationScreen());
        getParticularClassroom();
        getAllReservation(context);
        getReservation(context);
        //navigateTo(context, const Notifications());
      });
      // print(value.data);
      //salles=value.data;
      // print(salles);
      emit(ReservationUpdateSuccessState());
    }).catchError((onError){
      flutterToast(msg: 'something went wrong!', state: toastStates.error);
      print(onError.toString());
      emit(ReservationUpdateErrorState());
    });
  }

  //delete a reservation
  void deleteReservation(id,context){
    getAllReservation(context);
   // getReservation(context);
   //  getAllReservationsByID(context, id);
    DioHelper.deleteData(url:'http://127.0.0.1:8000/api/reservation/$id' ).then((value){
      flutterToast(msg: 'Reservation deleted!', state: toastStates.success).then((value) {
        Navigator.pop(context);
        getReservation(context);
        getParticularClassroom();
        getAllReservation(context);
      });
      // getReservation(context);
      print(value.data);// this shows that salle deleted that i put in my api
      emit(ReservationDeleteSuccessState());
    }).catchError((onError){
      flutterToast(msg: 'Something went wrong,try again!', state: toastStates.error).then((value) =>navigateTo(context, ClassroomScreen()));
      emit(ReservationDeleteErrorState());
    });
  }

}