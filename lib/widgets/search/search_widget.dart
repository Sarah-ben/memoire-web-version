import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:memoire/shared/components/constants.dart';
import 'package:memoire/widgets/add_clasrrom/cubit/add_cubit.dart';
import 'package:memoire/widgets/add_clasrrom/cubit/add_states.dart';
import '../../shared/components/components.dart';
import '../../shared/network/cache_helper.dart';
import '../../shared/styles/icons.dart';
import '../add_reservation/classroom_cubit/reservation_cubit.dart';


class SearchWidget extends StatelessWidget {
  TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCubit, AddStates>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: dark(context)?Colors.black:Colors.white,
            appBar: AppBar(
              toolbarHeight: 100,
              title:   SizedBox(
                width: 400.0,
                //  padding: const EdgeInsets.all(100.0),
                child: defaultFormField(context,controller: searchController,
                    inputType: TextInputType.text,
                    label: 'Search',
                    //suffix: Icons.search,
                    onChange: (value){
                      AddCubit.get(context).searchData(value);
                    }),
              ),
              leading: InkWell(
                onTap: ()=>Navigator.pop(context),
                child: Icon(IconBroken.Arrow___Left_2,color:dark(context)?Colors.white:Colors.black ,),
              ),
              backgroundColor: dark(context)?Colors.black:Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.only(left:45.0,right: 45.0,top: 20,),
              child:
                  state is! SearchErrorState?
                   ListView.separated(
                        scrollDirection: Axis.horizontal,
                          physics:const BouncingScrollPhysics(),
                          itemBuilder: (context,index){
                            return buildSearchItem(AddCubit.get(context).search[index],context);
                          }, separatorBuilder: (c,i)=>const SizedBox(), itemCount:AddCubit.get(context).search.length )
                      : Center(child: Text('no data',style:dark(context)?const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  ):const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),))

            )
          );
          /* InkWell(
              onTap:(){
                showDialog(
                    barrierColor: dark(context) ? Colors.white24 : Colors.black26,
                    context: context, builder: (context){
                  return Dialog(
                    elevation: 0,
                    backgroundColor:dark(context)?Colors.black:Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SingleChildScrollView(
                      child: SizedBox(
                          width: 400,
                          height: 500,
                          child:Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: defaultFormField(context,controller: searchController,
                                    inputType: TextInputType.text,
                                    label: 'Search',
                                    suffix: Icons.search,
                                    onChange: (value){
                                      AddCubit.get(context).searchData(value);
                                    }),
                              ),
                              state is! SearchErrorState?
                              Expanded(
                                child: ListView.separated(
                                    physics:const BouncingScrollPhysics(),
                                    itemBuilder: (context,index){
                                      return buildSearchItem(AddCubit.get(context).search[index],context);
                                    }, separatorBuilder: (c,i)=>const Divider(), itemCount:AddCubit.get(context).search.length ),
                              )
                                  :const Center(child: CircularProgressIndicator())
                            ],
                          )
                      ),
                    ),
                  );
                });
              },
              child: Icon(IconBroken.Search,color: dark(context)?Colors.white:Colors.black,));*/
        },
        listener: (context, state) {});
  }
}
Widget buildSearchItem(dynamic data,BuildContext context)=> Padding(
    padding: const EdgeInsets.all(0.0),
    child: Container(
      height: 500.0,
      width: 400,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Container(
           height: 250.0,
           width: 300,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(.3),
                  borderRadius: BorderRadius.circular(15)
              ),
              padding: EdgeInsets.all(20),
              child:!isAdmin? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('id : ${data['id']}',style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: dark(context)?Colors.white:Colors.black
                    ),maxLines: 4,overflow: TextOverflow.ellipsis,),

                  Text('name : ${data['name']}',style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: dark(context)?Colors.white:Colors.black
                    ),maxLines: 4,overflow: TextOverflow.ellipsis,),

                  Text('type : ${data['type']}',style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: dark(context)?Colors.white:Colors.black
                    ),maxLines: 4,overflow: TextOverflow.ellipsis,),

                  Text('stage : ${data['etage']}',style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: dark(context)?Colors.white:Colors.black
                    ),maxLines: 4,overflow: TextOverflow.ellipsis,),

                  Text('capacity : ${data['capcity']}',style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: dark(context)?Colors.white:Colors.black
                  ),maxLines: 4,overflow: TextOverflow.ellipsis,),

                  Text('particular : ${data['particulier']}',style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: dark(context)?Colors.white:Colors.black
                  ),maxLines: 4,overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap:(){
                      showDialog(
                          barrierColor: dark(context) ? Colors.white24 : Colors.black26,
                          context: context, builder: (context){
                        return Dialog(
                          elevation: 0,
                          backgroundColor:dark(context)?Colors.black:Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SingleChildScrollView(
                            child: SizedBox(
                              width: 350.0,
                              height: 497.0,
                              child:
                              Padding(padding: const EdgeInsets.all(25.0),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        getCloseButton(context),
                                        const SizedBox(height: 5.0,),
                                        customText(context, text: '   Goal',upperCase: false),
                                        const SizedBox(height: 15.0,),
                                        customTextField(context,
                                            maxLines: 3,
                                            controller: reservationGoal,
                                            label: '',
                                            textInputType: TextInputType.text),
                                        verticalSizedBox(15.0),
                                        customUpdateItem(context, controller: reservationTime,onPressed: (){
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) =>
                                          reservationTime.text = value!.format(context).toString());
                                        }),
                                        verticalSizedBox(15.0),
                                        customUpdateItem(context, controller: reservationDate,onPressed: (){
                                          showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2050))
                                              .then((value) =>
                                          reservationDate.text =
                                              DateFormat.yMMMd()
                                                  .format(value!));
                                        }),
                                        verticalSizedBox(15.0),
                                        defaultButton(function: (){
                                          print( ' is it part? :${data.particulier}');
                                          if(formKey.currentState!.validate()){
                                            ReservationCubit.get(context).addReservation(context:context,time: reservationTime.text,date: reservationDate.text, goal: reservationGoal.text, id_user:CacheHelper.getData(key: 'ID'), id_classroom: data.id, etat: data.particulier,);
                                          }
                                        }, text: 'Add'),
                                        verticalSizedBox(5.0),
                                      ],
                                    ),
                                  )),




                            ),
                          ),
                        );
                      });
                    },
                    child: customText(context, text: 'Reserve',color:Colors.yellow,upperCase: false),
                  ),
                ],
              ):
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('id : ${data['id']}',style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: dark(context)?Colors.white:Colors.black
                  ),maxLines: 4,overflow: TextOverflow.ellipsis,),

                  Text('name : ${data['name']}',style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: dark(context)?Colors.white:Colors.black
                  ),maxLines: 4,overflow: TextOverflow.ellipsis,),

                  Text('type : ${data['type']}',style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: dark(context)?Colors.white:Colors.black
                  ),maxLines: 4,overflow: TextOverflow.ellipsis,),

                  Text('stage : ${data['etage']}',style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: dark(context)?Colors.white:Colors.black
                  ),maxLines: 4,overflow: TextOverflow.ellipsis,),

                  Text('capacity : ${data['capcity']}',style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: dark(context)?Colors.white:Colors.black
                  ),maxLines: 4,overflow: TextOverflow.ellipsis,),

                  Text('particular : ${data['particulier']}',style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: dark(context)?Colors.white:Colors.black
                  ),maxLines: 4,overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap:(){
                          showDialog(
                              barrierColor: dark(context) ? Colors.white24 : Colors.black26,
                              context: context, builder: (context){
                            return Dialog(
                              elevation: 0,
                              backgroundColor:dark(context)?Colors.black:Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  width: 350.0,
                                  height: 497.0,
                                  child:
                                  Padding(padding: const EdgeInsets.all(25.0),
                                      child: Form(
                                        key: formKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            getCloseButton(context),
                                            const SizedBox(height: 5.0,),
                                            customText(context, text: '   Goal',upperCase: false),
                                            const SizedBox(height: 15.0,),
                                            customTextField(context,
                                                maxLines: 3,
                                                controller: reservationGoal,
                                                label: '',
                                                textInputType: TextInputType.text),
                                            verticalSizedBox(15.0),
                                            customUpdateItem(context, controller: reservationTime,onPressed: (){
                                              showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              ).then((value) =>
                                              reservationTime.text = value!.format(context).toString());
                                            }),
                                            verticalSizedBox(15.0),
                                            customUpdateItem(context, controller: reservationDate,onPressed: (){
                                              showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2050))
                                                  .then((value) =>
                                              reservationDate.text =
                                                  DateFormat.yMMMd()
                                                      .format(value!));
                                            }),
                                            verticalSizedBox(15.0),
                                            defaultButton(function: (){
                                              print( ' is it part? :${data.particulier}');
                                              if(formKey.currentState!.validate()){
                                                ReservationCubit.get(context).addReservation(context:context,time: reservationTime.text,date: reservationDate.text, goal: reservationGoal.text, id_user:CacheHelper.getData(key: 'ID'), id_classroom: data.id, etat: data.particulier,);
                                              }
                                            }, text: 'Add'),
                                            verticalSizedBox(5.0),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                            );
                          });
                        },
                        child: customText(context, text: 'Reserve',color: Colors.white,upperCase: false),
                      ),
                      InkWell(
                        onTap:(){
                          deleteConfirmation(context, text1: data['name'],function: (){
                            AddCubit.get(context).deleteSalle(
                                data.id, context);
                          });
                        },
                        child: customText(context, text: 'Delete',color:Colors.red,upperCase: false),
                      ),
                      InkWell(
                        onTap:(){
                          TextEditingController _classStage=TextEditingController(text: '${data['etage']}');
                          TextEditingController _classCapacity=TextEditingController(text: '${data['capcity']}');
                          updateClassDialog(context,id:data['id'],name:data['name'],classStage: _classStage,classCapacity: _classCapacity);
                          //print('tapped');
                          //MaterialCubit.get(context).deleteMaterial(data.id, context);
                        },
                        child: customText(context, text: 'Edit',color:Colors.yellow,upperCase: false),
                      )
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );

