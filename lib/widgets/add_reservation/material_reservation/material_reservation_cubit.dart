import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire/models/reservation_model/materal_reservation.dart';
import 'package:memoire/modules/material_screen/material_screen.dart';
import 'package:memoire/modules/reservations/material_reservation_screen.dart';
import 'package:memoire/widgets/add_material/add_material.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/cache_helper.dart';
import '../../../shared/network/dio_helper.dart';
import 'material_reservation_states.dart';

class MaterialReservationCubit extends Cubit<MaterialReservationStates>{
  MaterialReservationCubit() : super(ReservationInitialState());
  static MaterialReservationCubit get(context)=>BlocProvider.of(context);
  late MaterialReservationModel materialReservationModel;
  late MaterialReservationData reservationData;
  void addReservation({
    required  String time,
    required  String date,
    required  String goal,
    required   id_material,
    required   id_user,
    required context

  }){
    emit(ReservationAddLoadingState());
    DioHelper.postData(url: 'http://127.0.0.1:8000/api/material_reservation/add', data:{
      'time':time,
      'date':date,
      'goal':goal,
      'id_material':id_material,
      'id_user':id_user,
    },).then((value)  {
      getAllReservation(context);
      materialReservationModel=MaterialReservationModel.fromJson(value.data);
      print(materialReservationModel.data!.time);
      print(value.data);
      print('salle added');
      flutterToast(msg: 'Item ${materialReservationModel.data!.id_material} added to your reservations.', state: toastStates.error).then((value) {
        navigateTo(context, MaterialScreen());
        getAllReservation(context);
        getReservation(context);
      });
      emit(ReservationADDSuccessState());
    }).catchError((onError){
      flutterToast(msg: 'Something went wrong ,try again!', state: toastStates.error);
      print('this is the error $onError');
      emit(ReservationAddErrorState(onError.toString()));
    });
  }
  // get reservation by id

  List<MaterialReservationData> materialReservations=[];
  void getReservation(context){
    //getReservationall(context, id);
    materialReservations=[];
    // print(classModel!.data!.name);
    emit(ReservationGetLoadingState());
    DioHelper.getData(url: 'http://127.0.0.1:8000/api/findMaterial/${CacheHelper.getData(key: 'ID')}').then((value) {
      //print('hello world');
      // classModel=ClassModel.fromJson(value.data);
      value.data.forEach((e){
        reservationData=MaterialReservationData.fromJson(e);
        print(reservationData.time);
        materialReservations.add(MaterialReservationData.fromJson(e));
        print(materialReservations.length);
      });
      // this one worked fine

      emit(ReservationGetSuccessState());
    }).catchError((onError){
      print(onError);
      emit(ReservationGetErrorState());
    });
  }

  List<MaterialReservationData> allReservationsByID=[];
  getAllReservationsByID(context,id){
    allReservations=[];
    // print(classModel!.data!.name);
    emit(ReservationallGetLoadingState());
    getAllReservation(context);

    DioHelper.getData(url: 'http://127.0.0.1:8000/api/findList/$id').then((value) {
      //print('hello world');
      // classModel=ClassModel.fromJson(value.data);
      print(' list data is ${value.data}');
      value.data.forEach((e){
        reservationData=MaterialReservationData.fromJson(e);
        print(reservationData.time);
        allReservations.add(MaterialReservationData.fromJson(e));
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
  List<MaterialReservationData> allReservations=[];
  void getAllReservation(context){
    //getReservationall(context, id);
    allReservations=[];
    // print(classModel!.data!.name);
    emit(ReservationGetLoadingState());
    DioHelper.getData(url: 'http://127.0.0.1:8000/api/getAllReservations').then((value) {
      //print('hello world');
      // classModel=ClassModel.fromJson(value.data);
      value.data.forEach((e){
        print('data to show:$e');
        reservationData=MaterialReservationData.fromJson(e);
        print(reservationData.time);
        allReservations.add(MaterialReservationData.fromJson(e));
        print(allReservations.length);
      });
      // this one worked fine

      emit(ReservationGetSuccessState());
    }).catchError((onError){
      print(onError);
      emit(ReservationGetErrorState());
    });
  }


  void updateReservation({
    required id,
    context,
    required String  time,
    required String  date,
    required String goal,

  }){
    emit(ReservationUpdateLoadingState());
    DioHelper.updateData(url: 'http://127.0.0.1:8000/api/reservation/$id', data: {
      'time':time,
      'date':date,
      'goal':goal,
      'id_material':'${reservationData.id_material}',
      'id_user':'${CacheHelper.getData(key: 'ID')}',

    }).then((value) {
      getAllReservation(context);
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
    context,
    required String  time,
    required String  date,
    required String goal,
    required id_user
  }){
    getAllReservation(context);
    emit(ReservationUpdateLoadingState());
    DioHelper.updateData(url: 'http://127.0.0.1:8000/api/material_reservation/$id', data: {
      'time':time,
      'date':date,
      'goal':goal,
      'id_material':'${reservationData.id_material}',
      'id_user':id_user,
    }).then((value) {
      flutterToast(msg:'Reservation updated!', state: toastStates.success).then((value) {

        // Navigator.push(context, MaterialPageRoute(builder: (_)=>MaterialReservationScreen()));
        getReservation(context);

        getAllReservation(context);
      });
      print(value.data);
      print('all updated !');
      emit(ReservationUpdateSuccessState());
    }).catchError((onError){
      flutterToast(msg: 'Something went wrong!', state: toastStates.success).then((value) {
        Navigator.pop(context);

      });
      print(onError.toString());
      emit(ReservationUpdateErrorState());
    });
  }

  //delete a reservation
  void deleteReservation(id,context){
    getReservation(context);
    getAllReservation(context);
    getAllReservationsByID(context, id);
    DioHelper.deleteData(url:'http://127.0.0.1:8000/api/material_reservation/$id' ).then((value){
      flutterToast(msg: 'material deleted!', state: toastStates.success).then((value) {
        navigateTo(context, MaterialReservationScreen());
        getReservation(context);
        getAllReservation(context);

      });
      print(value.data);// this shows that salle deleted that i put in my api
      emit(ReservationDeleteSuccessState());
    }).catchError((onError){
      print(onError);
      emit(ReservationDeleteErrorState());
    });
  }

}