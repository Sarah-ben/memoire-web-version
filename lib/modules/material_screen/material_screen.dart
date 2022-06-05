import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:memoire/modules/welcome_screen/welcome_screen.dart';
import 'package:memoire/shared/components/components.dart';
import 'package:memoire/shared/components/constants.dart';
import 'package:memoire/shared/network/cache_helper.dart';
import 'package:memoire/widgets/add_material/cubit/material_cubit.dart';
import 'package:memoire/widgets/add_material/cubit/material_states.dart';

import '../../shared/components/footer/footer_min.dart';
import '../../shared/components/footer/footer_mx.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/styles/icons.dart';
import '../../widgets/add_clasrrom/add_classroom.dart';
import '../../widgets/add_material/add_material.dart';
import '../../widgets/add_reservation/classroom_cubit/reservation_cubit.dart';
import '../../widgets/add_reservation/classroom_cubit/reservation_list.dart';
import '../../widgets/login/cubit/cubit.dart';

class MaterialScreen extends StatefulWidget {
  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

CustomPopupMenuController _controller = CustomPopupMenuController();
CustomPopupMenuController _notificationsController = CustomPopupMenuController();


class _MaterialScreenState extends State<MaterialScreen> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MaterialCubit,MaterialStates>(builder: (BuildContext context, state) {
      return Scaffold(
          backgroundColor: dark(context) ? Colors.black : Colors.white,
          body: CustomScrollView(
            slivers: [
              // headerMax(context),
              headerMainScreen(context, (b) {
                setState(() {
                  AppCubit.get(context).changeAppMode();
                });
              }),
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
                      },controller: _controller,
                           notificationController: _notificationsController
                      ): rightMenu2(context,emailHover: (hover) {
                        setState(() {
                          isEmail = hover;
                        });
                      },logoutHover:(hover) {
                        setState(() {
                          isLogOut = hover;
                        });
                      },controller: _controller
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
                                    ? MaterialCubit.get(context).materials.length >= 5
                                    ? const EdgeInsets.only(
                                    left: 40.0, top: 40.0)
                                    : const EdgeInsets.only(
                                    left: 70.0, top: 40.0)
                                    : const EdgeInsets.only(left: 5.0, top: 70.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText(context, text: 'Materials',upperCase: false),
                                    verticalSizedBox(20.0),
                                    MaterialCubit.get(context).materials.length >0?   isAdmin? DataTable2(
                                        border:TableBorder.all(color: Colors.grey.withOpacity(.4)) ,
                                        headingRowColor:MaterialStateProperty.all(Colors.grey.withOpacity(.5)) ,
                                        //dataRowColor:MaterialStateProperty.all(Colors.green) ,
                                        columnSpacing: 12,
                                        horizontalMargin: 12,
                                        minWidth: 100,
                                        columns: [
                                          DataColumn(
                                            label: customText(context, text: 'Material ID',fontSize: 14.0),
                                            // size: ColumnSize.L,
                                          ),
                                          DataColumn(
                                            label:  customText(context, text: 'Category',fontSize: 14.0),
                                          ),
                                          DataColumn2(
                                            size: ColumnSize.L,
                                            label:  customText(context, text: 'Name',fontSize: 14.0),
                                          ),

                                          const DataColumn(
                                            label:  Text(''),
                                          ),
                                          const DataColumn(
                                            label:  Text(''),
                                          ),
                                          /*const DataColumn(
                                          label: Text('Column NUMBERS'),
                                          numeric: false,
                                        ),*/
                                        ],
                                        rows:MaterialCubit.get(context).materials
                                            .map((data) => DataRow(cells: [
                                          DataCell(customText(context, text: '${data.id!}',fontSize: 12.0,upperCase: false)),
                                          DataCell(customText(context, text: data.category!,fontSize: 12.0,upperCase: false)),
                                          DataCell(customText(context, text: data.name!,fontSize: 12.0,upperCase: false)),
                                          DataCell( Row(
                                            children: [
                                           const Icon(IconBroken.Delete,color: Colors.red,size: 15),
                                              const SizedBox(width: 5,),
                                              InkWell(
                                                onTap:(){
                                                deleteConfirmation(context, text1: data.name! , function: (){
                                                    MaterialCubit.get(context).deleteMaterial(data.id, context);
                                                  });
                                                },
                                                child: customText(context, text: 'Delete',color: Colors.blueGrey,upperCase: false),
                                              ),
                                            ],
                                          )),
                                          DataCell(InkWell(
                                            onTap:(){
                                              var reservationTime=TextEditingController();
                                              var reservationDate=TextEditingController();
                                              var reservationGoal=TextEditingController();
                                              materialReservation(context,CacheHelper.getData(key: 'ID'), data.id, reservationTime, reservationDate, reservationGoal);
                                              //  MaterialReservationCubit.get(context).addReservation(date: 'test', time: 'testone');
                                            },
                                            child: customText(context, text: 'reserve',color: Colors.yellow,upperCase: false),
                                          ),), //  DataCell(Text(''))
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
                                           label: customText(context, text: 'Material ID',fontSize: 14.0),
                                           // size: ColumnSize.L,
                                         ),
                                         DataColumn(
                                           label:  customText(context, text: 'Category',fontSize: 14.0),
                                         ),
                                         DataColumn2(
                                           size: ColumnSize.L,
                                           label:  customText(context, text: 'Name',fontSize: 14.0),
                                         ),


                                         const DataColumn(
                                           label:  Text(''),
                                         ),
                                         /*const DataColumn(
                                          label: Text('Column NUMBERS'),
                                          numeric: false,
                                        ),*/
                                       ],
                                       rows:MaterialCubit.get(context).materials
                                           .map((data) => DataRow(cells: [
                                         DataCell(customText(context, text: '${data.id!}',fontSize: 12.0,upperCase: false)),
                                         DataCell(customText(context, text: data.category!,fontSize: 12.0,upperCase: false)),
                                         DataCell(customText(context, text: data.name!,fontSize: 12.0,upperCase: false)),

                                         DataCell(InkWell(
                                           onTap:(){
                                             var reservationTime=TextEditingController();
                                             var reservationDate=TextEditingController();
                                             var reservationGoal=TextEditingController();
                                             materialReservation(context,CacheHelper.getData(key: 'ID'), data.id, reservationTime, reservationDate, reservationGoal);
                                             //  MaterialReservationCubit.get(context).addReservation(date: 'test', time: 'testone');
                                           },
                                           child: customText(context, text: 'reserve',color: Colors.yellow,upperCase: false),
                                         ),), //  DataCell(Text(''))
                                       ])).toList()):
                                   Padding(padding: EdgeInsets.all(300),
                                     child: customText(context, text: 'no material yet',color: Colors.grey),
                                   ),
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
                      getWidth(context)>=950 ?footer():FooterMin()
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
