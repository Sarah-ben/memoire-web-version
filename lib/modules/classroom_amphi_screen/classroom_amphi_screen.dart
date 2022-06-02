import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:memoire/modules/welcome_screen/welcome_screen.dart';
import 'package:memoire/shared/components/components.dart';
import 'package:memoire/shared/components/constants.dart';
import 'package:memoire/shared/network/cache_helper.dart';
import 'package:memoire/widgets/add_clasrrom/cubit/add_cubit.dart';
import 'package:memoire/widgets/add_clasrrom/cubit/add_states.dart';
import 'package:memoire/widgets/register/register_widget.dart';
import '../../shared/components/footer/footer_mx.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/styles/icons.dart';
import '../../widgets/add_clasrrom/add_classroom.dart';
import '../../widgets/add_material/add_material.dart';
import '../../widgets/add_reservation/classroom_cubit/reservation_cubit.dart';
import '../../widgets/add_reservation/classroom_cubit/reservation_list.dart';

class ClassroomScreen extends StatefulWidget {
  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}


CustomPopupMenuController _controller = CustomPopupMenuController();
CustomPopupMenuController _controller2 = CustomPopupMenuController();
CustomPopupMenuController _notificationsController = CustomPopupMenuController();

Type _type = Type.classroom;
particular _particular = particular.no;
class _ClassroomScreenState extends State<ClassroomScreen> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCubit,AddStates>(builder: (BuildContext context, state) {
      return Scaffold(
          backgroundColor: dark(context) ? Colors.black : Colors.white,
          body: CustomScrollView(
            slivers: [
              // headerMax(context),
              headerMainScreen(context, (b) {
                setState(() {
                  AppCubit.get(context).changeAppMode();
                });
              }, controller: _controller2),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) => Column(
                    children: [
                      CacheHelper.getData(key: 'role')=='admin'? rightMenu(context,emailHover: (hover) {
                        setState(() {
                          isEmail = hover;
                        });
                      },logoutHover:(hover) {
                        setState(() {
                          isLogOut = hover;
                        });
                      },controller: _controller
                          , notificationController: _notificationsController
                      ): rightMenu2(context,emailHover: (hover) {
                        setState(() {
                          isEmail = hover;
                        });
                      },logoutHover:(hover) {
                        setState(() {
                          isLogOut = hover;
                        });
                      },controller: _controller,
                      ),
                      Container(
                        padding:  getWidth(context) >= 1025
                            ? const EdgeInsets.symmetric(horizontal: 80)
                            : const EdgeInsets.symmetric(horizontal: 20),
                        color: dark(context) ? Colors.black : Colors.white,
                        height: 700,
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getWidth(context) >= 900
                                ? leftMenu(context)
                                : const SizedBox(),
                            Expanded(
                              child: Padding(
                                padding: getWidth(context) > 900
                                    ? AddCubit.get(context).classrooms.length >= 5
                                    ? const EdgeInsets.only(
                                    left: 40.0, top: 70.0)
                                    : const EdgeInsets.only(
                                    left: 70.0, top: 40.0)
                                    : const EdgeInsets.only(left: 5.0, top: 70.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText(context, text: 'Classrooms and amphitheatre',upperCase: false),
                                    verticalSizedBox(20.0),
                                   isAdmin? DataTable2(
                                        border:TableBorder.all(color: Colors.grey.withOpacity(.4)) ,
                                        headingRowColor:MaterialStateProperty.all(Colors.grey.withOpacity(.5)) ,
                                        //dataRowColor:MaterialStateProperty.all(Colors.green) ,
                                        columnSpacing: 12,
                                        horizontalMargin: 12,
                                        minWidth: 100,
                                        columns: [
                                          DataColumn(
                                            label: customText(context, text: 'ID',fontSize: 14.0),
                                            // size: ColumnSize.L,
                                          ),
                                          DataColumn(
                                            label:  customText(context, text: 'name',fontSize: 14.0),
                                          ),
                                          DataColumn2(
                                            size: ColumnSize.L,
                                            label:  customText(context, text: 'stage',fontSize: 14.0),
                                          ),
                                          DataColumn(
                                            label:  customText(context, text: 'capacity',fontSize: 14.0),
                                          ),
                                          DataColumn(
                                            label:  customText(context, text: 'type',fontSize: 14.0),
                                          ),
                                          DataColumn(
                                            label:  customText(context, text: 'particularity',fontSize: 14.0),
                                          ),
                                          const DataColumn(
                                            label:Text(''),
                                          ),
                                          const DataColumn(
                                            label:Text(''),
                                          ),
                                          const DataColumn(
                                            label:Text(''),
                                          ),
                                          /*const DataColumn(
                                          label: Text('Column NUMBERS'),
                                          numeric: false,
                                        ),*/
                                        ],
                                        rows:AddCubit.get(context).classrooms
                                            .map((data) => DataRow(cells: [
                                          DataCell(customText(context, text: '${data.id!}',fontSize: 12.0,upperCase: false)),
                                          DataCell(customText(context, text: data.name!,fontSize: 12.0,upperCase: false)),
                                          DataCell(customText(context, text: '${data.etage!}',fontSize: 12.0,upperCase: false)),
                                          DataCell(customText(context, text: '${data.capcity!}',fontSize: 12.0,upperCase: false)),
                                          DataCell(customText(context, text: data.type!,fontSize: 12.0,upperCase: false)),
                                          DataCell(customText(context, text: '${data.particulier!}',fontSize: 12.0,upperCase: false)),
                                          DataCell(
                                              Row(
                                                children: [
                                                   const Icon(IconBroken.Edit,color: Colors.yellow,size: 15,),
                                                  InkWell(
                                                    onTap:(){
                                                      TextEditingController _classStage=TextEditingController(text: '${data.etage}');
                                                      TextEditingController _classCapacity=TextEditingController(text: '${data.capcity}');
                                                      updateClassDialog(context,id:data.id,name:data.name,classStage: _classStage,classCapacity: _classCapacity);
                                                      //print('tapped');
                                                      //MaterialCubit.get(context).deleteMaterial(data.id, context);
                                                    },
                                                    child: customText(context, text: 'Edit',color:isAdmin? Colors.blueGrey:Colors.grey,upperCase: false),
                                                  )
                                                ],
                                              )
                                          ),
                                          DataCell(
                                              Row(
                                                children: [
                                                  const Icon(IconBroken.Delete,color: Colors.red,size: 15),
                                                  InkWell(
                                                    onTap:(){
                                                      deleteConfirmation(context, text1: data.name!,function: (){
                                                        AddCubit.get(context).deleteSalle(
                                                            data.id, context);
                                                      });
                                                    },
                                                    child: customText(context, text: 'Delete',color: isAdmin? Colors.blueGrey:Colors.grey,upperCase: false),
                                                  ),
                                                ],
                                              )),
                                          DataCell(
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
                                              child: customText(context, text: 'Reserve',color: isAdmin? Colors.blueGrey:Colors.grey,upperCase: false),
                                            ),
                                          ),
                                          //  DataCell(Text(''))
                                        ])).toList()):
                                   DataTable2(
                                       border:TableBorder.all(color: Colors.grey.withOpacity(.4)) ,
                                       headingRowColor:MaterialStateProperty.all(Colors.grey.withOpacity(.5)) ,
                                       //dataRowColor:MaterialStateProperty.all(Colors.green) ,
                                       columnSpacing: 12,
                                       horizontalMargin: 12,
                                       minWidth: 100,
                                       columns: [
                                         DataColumn(
                                           label: customText(context, text: 'ID',fontSize: 14.0),
                                           // size: ColumnSize.L,
                                         ),
                                         DataColumn(
                                           label:  customText(context, text: 'name',fontSize: 14.0),
                                         ),
                                         DataColumn2(
                                           size: ColumnSize.L,
                                           label:  customText(context, text: 'stage',fontSize: 14.0),
                                         ),
                                         DataColumn(
                                           label:  customText(context, text: 'capacity',fontSize: 14.0),
                                         ),
                                         DataColumn(
                                           label:  customText(context, text: 'type',fontSize: 14.0),
                                         ),
                                         DataColumn(
                                           label:  customText(context, text: 'particularity',fontSize: 14.0),
                                         ),
                                         const DataColumn(
                                           label:Text(''),
                                         ),
                                         /*const DataColumn(
                                          label: Text('Column NUMBERS'),
                                          numeric: false,
                                        ),*/
                                       ],
                                       rows:AddCubit.get(context).classrooms
                                           .map((data) => DataRow(cells: [
                                         DataCell(customText(context, text: '${data.id!}',fontSize: 12.0,upperCase: false)),
                                         DataCell(customText(context, text: data.name!,fontSize: 12.0,upperCase: false)),
                                         DataCell(customText(context, text: '${data.etage!}',fontSize: 12.0,upperCase: false)),
                                         DataCell(customText(context, text: '${data.capcity!}',fontSize: 12.0,upperCase: false)),
                                         DataCell(customText(context, text: data.type!,fontSize: 12.0,upperCase: false)),
                                         DataCell(customText(context, text: '${data.particulier!}',fontSize: 12.0,upperCase: false)),
                                         DataCell(
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
                                             child: customText(context, text: 'Reserve',color: Colors.yellow,upperCase: false),
                                           ),
                                         ),
                                         //  DataCell(Text(''))
                                       ])).toList()),
                                  ],
                                ),
                              ),
                            )
                            /*VerticalDivider(
                                      color: Colors.grey.withOpacity(.4)),*/
                          ],
                        ),
                      ),
                      // const SizedBox(height: 500),
                      const SizedBox(
                        height: 70,
                      ),
                      const footer()
                    ],
                  ),
                  childCount: 1,
                ), //SliverChildBuildDelegate
              )
            ],
          ));
    }, listener: (BuildContext context, Object? state) {  },);
  }
}
/*
 WeekView(
            controller: EventController(),
            eventTileBuilder: (date, events, boundry, start, end) {
              // Return your widget to display as event tile.
              return Container();
            },
            showLiveTimeLineInAllDays: true, // To display live time line in all pages in week view.
            width: 500, // width of week view.
            minDay: DateTime.now(),
            maxDay: DateTime.parse('2100-01-01'),
            initialDay: DateTime.now(),
            heightPerMinute: 1, // height occupied by 1 minute time span.
            eventArranger: SideEventArranger(), // To define how simultaneous events will be arranged.
            onEventTap: (events, date) => print(date),
            onDateLongPress: (date) => print(date)
        )
 */

Widget menuItems({onTap, required String text, required IconData icon}) =>
    InkWell(
      hoverColor: Colors.grey,
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 15,
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
