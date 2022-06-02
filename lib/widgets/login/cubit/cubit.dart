import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire/modules/teachers_screen/teachers_screen.dart';
import 'package:memoire/widgets/login/cubit/states.dart';

import '../../../models/login_model/login_model.dart';
import '../../../modules/home_screen/home_screen.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/cache_helper.dart';
import '../../../shared/network/dio_helper.dart';



class LoginCubit extends Cubit<LoginStates>{
  LoginCubit( ) : super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);
  late LoginModel loginModel;
  late UserData userData;
  void userLogin({
    required String email,
    required String password
  }){
    emit(LoginLoadingState());
    DioHelper.postData(url: 'http://127.0.0.1:8000/api/login', data:{
      'email':email,
      'password':password
    },).then((value)  {
      //  print(value.data);
      loginModel=LoginModel.fromJson(value.data);
      print('the name ${loginModel.userData!.first_name}');
      print('the role ${loginModel.userData!.role}');
      CacheHelper.saveData(key: 'ID', val:loginModel.userData!.id );
      CacheHelper.saveData(key: 'email', val:loginModel.userData!.email );
      CacheHelper.saveData(key: 'first_name', val:loginModel.userData!.first_name );
      CacheHelper.saveData(key: 'last_name', val:loginModel.userData!.last_name );
      CacheHelper.saveData(key: 'grade', val:loginModel.userData!.grade );
      CacheHelper.saveData(key: 'place', val:loginModel.userData!.place );
      CacheHelper.saveData(key: 'role', val:loginModel.userData!.role );
       print('${CacheHelper.getData(key: 'role')}');
      emit(LoginSuccessState(loginModel));
    }).catchError((onError){
      flutterToast(msg: 'Wrong information! try again.', state: toastStates.error);
      print(onError);
      emit(LoginErrorState(onError.toString()));
    });
  }
  List<UserData> users=[];
  List<UserData> admins=[];
  List<UserData> teachers=[];
  void getUsers(){
    users=[];
    admins=[];
    teachers=[];
    // print(classModel!.data!.name);
    emit(getDataState());
    DioHelper.getData(url: 'http://127.0.0.1:8000/api/getUsers').then((value) {
      //print('hello world');
      print('data');
      // classModel=ClassModel.fromJson(value.data);
      //print(value.data);
      value.data.forEach((e){
        //print(e.);
        userData=UserData.fromJson(e);
       // print(userData.first_name);
       // print(userData.id);
        //CacheHelper.saveData(key: 'email', val:userData.email );
          // print(CacheHelper.getData(key: 'First_name'));
        //print(data.id);
        users.add(userData);//UserData.fromJson(e)
        if(userData.role=='admin'){
          admins.add(userData);
        }else{
          teachers.add(userData);
        }
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

  void userUpdate({
    required id,
    String? first_name,
    String? last_name,
    String? grade,
    String? place,
    String? role,
    required context
  }){
    emit(LoginUpdateLoadingState());
    DioHelper.updateData(url: 'http://127.0.0.1:8000/api/updateuser/$id', data: {
      'first_name':first_name,
      'last_name':last_name,
      'grade':grade,
      'place':place,
      'role':role,
      // 'password':'hello world',

    }).then((value) {
      flutterToast(msg: 'profile updated!', state: toastStates.error).then((value) => navigateTo(context,TeachersScreen() ));
      print('all updated !');
      getUsers();

      // print(value.data);
      //salles=value.data;
      // print(salles);
      emit(LoginUpdateSuccessState());
    }).catchError((onError){
      flutterToast(msg: 'Wrong information! try again.', state: toastStates.error).then((value) => navigateTo(context,TeachersScreen() ));
      emit(LoginUpdateErrorState(onError));
    });
  }

  void deleteUser(id,context){
    DioHelper.deleteData(url: 'http://127.0.0.1:8000/api/delete/$id').then((value) {
      getUsers();
      print(value.data);
      emit(DeleteUserSuccessState());
      flutterToast(msg: 'User Deleted!', state: toastStates.error).then((value) => getUsers()).then((value) => Navigator.pop(context) );
    }).catchError((onError){
      flutterToast(msg: 'something went wrong!', state: toastStates.error);

      emit(DeleteUserErrorState());

    });
  }

}