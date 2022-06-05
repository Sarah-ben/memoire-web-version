import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire/modules/classroom_amphi_screen/classroom_amphi_screen.dart';
import 'package:memoire/shared/components/components.dart';
import '../../../models/class_model/class_model.dart';
import '../../../models/reservation_model/classroom_reservation,_model.dart';
import '../../../shared/network/dio_helper.dart';
import 'add_states.dart';



class AddCubit extends Cubit<AddStates>{
  AddCubit( ) : super(AddInitialState());
  static AddCubit get(context)=>BlocProvider.of(context);
  late ClassModel classModel;
  late ReservationModel reservationModel;
  late Data data;
// add a classroom
  void addClass(context,{
    required String  name,
    required String type,
    required etage,
    required capacity,
    required particulier,
  }){
    emit(AddLoadingState());
    DioHelper.postData(url: 'http://127.0.0.1:8000/api/addsalle', data:{
      'name':name,
      'type':type,
      'etage':etage,
      'capcity':capacity,
      'particulier':particulier=='yes'?true:false,
    },).then((value)  {
      classModel=ClassModel.fromJson(value.data);
      print(classModel.data!.name);
      print('salle added');
      getSalle();
      flutterToast(msg: '${classModel.data!.type} Added Successfully', state: toastStates.success).then((value) => navigateTo(context, ClassroomScreen()));
      emit(AddSuccessState());
    }).catchError((onError){
      flutterToast(msg: 'Classroom already existed!', state: toastStates.error);
      print('Classroom already existed!');
      emit(AddErrorState(onError.toString()));
    });
  }




  // get  all classrooms
  List<Data> classrooms=[];
  List salleName=[];

  void getSalle({id,time,date}){
    classrooms=[];
    salleName=[];
    // print(classModel!.data!.name);
    emit(getDataState());
    DioHelper.getData(url: 'http://127.0.0.1:8000/api/salle').then((value) {
      //print('hello world');
      // classModel=ClassModel.fromJson(value.data);
      value.data.forEach((e){
        data=Data.fromJson(e);
        // print(data.name);
        salleName.add(data.name!);
        print(salleName.length);
        //print(data.)
        classrooms.add(Data.fromJson(e));
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
      emit(GetErrorState());
    });
  }

  // update a classroom
  void updateClass(id,name,{
    required stage,
    required capacity,
    required particular,
    required context
  }){
    emit(UpdateDataState());
    DioHelper.updateData(url: 'http://127.0.0.1:8000/api/salle/$id', data: {
      'etage':stage,
      'capcity':capacity,
      'particulier':particular=='yes'?true:false,
    }).then((value) {

      print('all updated !');
      // print(value.data);
      //salles=value.data;
      // print(salles);
      flutterToast(msg: '$name updated successfully', state: toastStates.error).then((value) {
        getSalle();
       navigateTo(context, ClassroomScreen());});
      emit(UpdateSuccessState());
    }).catchError((onError){
      flutterToast(msg: 'Someone went wrong ,try again!', state: toastStates.error);

      emit(UpdateErrorState());
    });
  }

// delete classroom
  void deleteSalle(id,context){
    DioHelper.deleteData(url:'http://127.0.0.1:8000/api/salle/$id' ).then((value){
      print(value.data);
      flutterToast(msg: '${value.data}', state: toastStates.error).then((value) { navigateTo(context, ClassroomScreen());
      getSalle();
      });
      print(value.data);// this shows that salle deleted that i put in my api
      emit(DeleteSuccessState());
    }).catchError((onError){
      print(onError);
      flutterToast(msg: 'Something went wrong,try again!', state: toastStates.error).then((value)=>navigateTo(context, ClassroomScreen()));
      emit(DeleteErrorState());
    });
  }

  List search=[];

  searchData(value){
    search=[];
    emit(SearchLoadingState());
    DioHelper.postData(url: 'http://127.0.0.1:8000/api/searchData', data: {
      'data':'$value',
    }).
    then((v) {
      print('data i want ${v.toString()}');
      print('data i want dataa ${v}');
      search=v.data;
      print('data lenght is ${search.length}');
      emit(SearchState());
    }).catchError((onError){
      emit(SearchErrorState());
    });
  }
}