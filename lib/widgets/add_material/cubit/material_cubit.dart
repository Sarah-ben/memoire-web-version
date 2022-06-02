import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire/modules/reservations/material_reservation_screen.dart';
import '../../../models/material_model/material_model.dart';
import '../../../modules/material_screen/material_screen.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/dio_helper.dart';
import 'material_states.dart';



class MaterialCubit extends Cubit<MaterialStates>{
  MaterialCubit( ) : super(AddInitialState());

  static MaterialCubit get(context)=>BlocProvider.of(context);
  // add material
  late MaterialModel materialModel;
  late MaterialData materialData;
  void addMaterial({
    required String  name,
    required String category,
    required context
  }){
    emit(AddLoadingState());
    DioHelper.postData(url: 'http://127.0.0.1:8000/api/addMaterial', data:{
      'category':category,
      'name':name,
    },).then((value)  {
      materialModel=MaterialModel.fromJson(value.data);
      print(materialModel.data!.name);
      flutterToast(msg: 'Material added !', state: toastStates.error).then((value) =>navigateTo(context, MaterialScreen()));
      getMaterial();
      emit(AddSuccessState());
    }).catchError((onError){
      flutterToast(msg: 'Something went wrong ,try again!', state: toastStates.error).then((value) =>Navigator.pop(context));
      print(onError);
      emit(AddErrorState(onError.toString()));
    });
  }

  //delete material
  void deleteMaterial(id,context){
    DioHelper.deleteData(url:'http://127.0.0.1:8000/api/deleteMateria/$id' ).then((value){
      getMaterial();
      flutterToast(msg: 'Material deleted! ', state: toastStates.error).then((value) =>navigateTo(context, MaterialScreen()));
      print(value.data);// this shows that salle deleted that i put in my api
      emit(DeleteSuccessState());
    }).catchError((onError){
      flutterToast(msg: 'Something went wrong ,try again!', state: toastStates.error);
      emit(DeleteErrorState());
    });
  }

  //get all materials
  List<MaterialData> materials=[];
  void getMaterial(){
    materials=[];
    // print(classModel!.data!.name);
    emit(getDataState());
    DioHelper.getData(url:'http://127.0.0.1:8000/api/getMaterial').then((value) {
      //print('hello world');
      print('data');
      // classModel=ClassModel.fromJson(value.data);
      print(value.data);
      value.data.forEach((e){
        materialData=MaterialData.fromJson(e);
        print(materialData.name);
        print(materialData.id);
        //print(data.id);
        materials.add(MaterialData.fromJson(e));
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
      emit(GetSuccessState());
    }).catchError((onError){
      print(onError);
      //emit(GetErrorState());
    });
  }



}