import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire/shared/components/components.dart';
import 'package:memoire/shared/components/constants.dart';
import 'package:memoire/shared/network/cache_helper.dart';
import 'package:memoire/widgets/add_reservation/material_reservation/material_reservation_states.dart';
import '../../shared/components/footer/footer_mx.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/styles/icons.dart';
import '../../widgets/add_reservation/classroom_cubit/reservation_cubit.dart';
import '../../widgets/add_reservation/classroom_cubit/reservation_list.dart';
import '../../widgets/add_reservation/material_reservation/material_reservation_cubit.dart';

class MaterialReservationScreen extends StatefulWidget {
  @override
  State<MaterialReservationScreen> createState() => _MaterialReservationScreenState();
}

String? text;

CustomPopupMenuController _controller = CustomPopupMenuController();
CustomPopupMenuController _notificationsController = CustomPopupMenuController();


class _MaterialReservationScreenState extends State<MaterialReservationScreen> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MaterialReservationCubit,MaterialReservationStates>(builder: (BuildContext context, state) {
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
                      CacheHelper.getData(key: 'role')=='admin'? rightMenu(
                          context,emailHover: (hover) {
                        setState(() {
                          isEmail = hover;
                        });
                      },logoutHover:(hover) {
                        setState(() {
                          isLogOut = hover;
                        });
                      },controller: _controller , notificationController: _notificationsController,
                          child:ReservationCubit.get(context).particular.isEmpty?Center(child: customText(context, text: 'No requests',upperCase: true),):BlocConsumer<ReservationCubit,ReservationStates>(builder: (context,state){
                        return  ListView.separated(itemBuilder:(context,index){
                          return buildNotificationItem(context,ReservationCubit.get(context).particular[index]);
                        } , separatorBuilder:(context,index)=>const Divider() , itemCount: ReservationCubit.get(context).particular.length) ;
                      }, listener: (context,state){})
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
                        padding: getWidth(context) >= 1025
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
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Padding(
                                  padding: getWidth(context) > 900
                                      ? MaterialReservationCubit.get(context).allReservations.length >= 5
                                      ||MaterialReservationCubit.get(context).materialReservations.length >= 5
                                      ? const EdgeInsets.only(
                                      left: 40.0, top: 70.0)
                                      : const EdgeInsets.only(
                                      left: 70.0, top: 40.0)
                                      : const EdgeInsets.only(left: 5.0, top: 70.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      customText(context, text: 'Material reservations',upperCase: false),
                                      verticalSizedBox(20.0),
                                      CacheHelper.getData(key: 'role')=='admin'?
                                      DataTable2(
                                          showCheckboxColumn: true,
                                          border: TableBorder.all(
                                              color: Colors.grey.withOpacity(.4)),
                                          headingRowColor: MaterialStateProperty.all(
                                              Colors.grey.withOpacity(.5)),
                                          //dataRowColor:MaterialStateProperty.all(Colors.green) ,
                                          columnSpacing: 12,
                                          horizontalMargin: 12,
                                          minWidth: 100,
                                          columns: [
                                            DataColumn(
                                              label: customText(context,
                                                  text: 'reservation id', fontSize: 14.0),
                                              // size: ColumnSize.L,
                                            ),
                                            DataColumn(
                                              label: customText(context,
                                                  text: 'time', fontSize: 14.0),
                                            ),
                                            DataColumn2(
                                              size: ColumnSize.L,
                                              label: customText(context,
                                                  text: 'date', fontSize: 14.0),
                                            ),
                                            DataColumn(
                                              label: customText(context,
                                                  text: 'goal', fontSize: 14.0),
                                            ),
                                            DataColumn(
                                              label: customText(context,
                                                  text: 'material id', fontSize: 14.0),
                                            ),
                                            DataColumn(
                                              label: customText(context,
                                                  text: 'user id', fontSize: 14.0),
                                            ),
                                            DataColumn(
                                              label: customText(context,
                                                  text: '', fontSize: 14.0),
                                            ),
                                            DataColumn(
                                              label: customText(context,
                                                  text: '', fontSize: 14.0),
                                            ),
                                            /*const DataColumn(
                                            label: Text('Column NUMBERS'),
                                            numeric: false,
                                          ),*/
                                          ],
                                          rows: MaterialReservationCubit.get(context)
                                              .allReservations
                                              .map((data) => DataRow(cells: [
                                            DataCell(
                                                customText(context,
                                                    text: '${data.id!}',
                                                    fontSize: 12.0,
                                                    upperCase: false),
                                                onTap: () {
                                                  print(data.id);
                                                }),
                                            DataCell(customText(context,
                                                text: data.time!,
                                                fontSize: 12.0,
                                                upperCase: false)),
                                            DataCell(customText(context,
                                                text: data.date!,
                                                fontSize: 12.0,
                                                upperCase: false)),
                                            DataCell(customText(context,
                                                text: data.goal!,
                                                fontSize: 12.0,
                                                upperCase: false)),
                                            DataCell(customText(context,
                                                text: '${data.id_material!}',
                                                fontSize: 12.0,
                                                upperCase: false)),
                                            DataCell(customText(context,
                                                text: '${data.id_user!}',
                                                fontSize: 12.0,
                                                upperCase: false)),
                                            DataCell(Row(
                                              children: [
                                                const Icon(
                                                  IconBroken.Edit,
                                                  color: Colors.yellow,
                                                  size: 15,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    var reservationTime=TextEditingController(text: data.time);
                                                    var reservationDate=TextEditingController(text: data.date);
                                                    var reservationGoal=TextEditingController(text: data.goal);
                                                    updateMaterialReservation(context, data.id,data.id_user,reservationTime,reservationDate,reservationGoal);
                                                    //print('tapped');
                                                    //MaterialCubit.get(context).deleteMaterial(data.id, context);
                                                  },
                                                  child: customText(context,
                                                      text: 'Edit',
                                                      color: Colors.blueGrey,
                                                      upperCase: false),
                                                )
                                              ],
                                            )),
                                            DataCell(Row(
                                              children: [
                                                const Icon(IconBroken.Delete,
                                                    color: Colors.red,
                                                    size: 15),
                                                InkWell(
                                                  onTap: () {
                                                    deleteConfirmation(context,
                                                        text1: 'ID : ${data.id!} ',
                                                        function: () {
                                                          ReservationCubit.get(context)
                                                              .deleteReservation(
                                                              data.id, context);
                                                        });
                                                  },
                                                  child: customText(context,
                                                      text: 'Delete',
                                                      color: Colors.blueGrey,
                                                      upperCase: false),
                                                ),
                                              ],
                                            )),
                                            //  DataCell(Text(''))
                                          ]))
                                              .toList())
                                          :DataTable2(
                                          showCheckboxColumn: true,
                                          border: TableBorder.all(
                                              color: Colors.grey.withOpacity(.4)),
                                          headingRowColor: MaterialStateProperty.all(
                                              Colors.grey.withOpacity(.5)),
                                          //dataRowColor:MaterialStateProperty.all(Colors.green) ,
                                          columnSpacing: 12,
                                          horizontalMargin: 12,
                                          minWidth: 100,
                                          columns: [
                                            DataColumn(
                                              label: customText(context,
                                                  text: 'reservation id', fontSize: 14.0),
                                              // size: ColumnSize.L,
                                            ),
                                            DataColumn(
                                              label: customText(context,
                                                  text: 'time', fontSize: 14.0),
                                            ),
                                            DataColumn2(
                                              size: ColumnSize.L,
                                              label: customText(context,
                                                  text: 'date', fontSize: 14.0),
                                            ),
                                            DataColumn(
                                              label: customText(context,
                                                  text: 'goal', fontSize: 14.0),
                                            ),
                                            DataColumn(
                                              label: customText(context,
                                                  text: 'material id', fontSize: 14.0),
                                            ),
                                            DataColumn(
                                              label: customText(context,
                                                  text: 'user id', fontSize: 14.0),
                                            ),
                                            DataColumn(
                                              label: customText(context,
                                                  text: '', fontSize: 14.0),
                                            ),
                                            DataColumn(
                                              label: customText(context,
                                                  text: '', fontSize: 14.0),
                                            ),
                                            /*const DataColumn(
                                            label: Text('Column NUMBERS'),
                                            numeric: false,
                                          ),*/
                                          ],
                                          rows: MaterialReservationCubit.get(context)
                                              .materialReservations
                                              .map((data) => DataRow(cells: [
                                            DataCell(
                                                customText(context,
                                                    text: '${data.id!}',
                                                    fontSize: 12.0,
                                                    upperCase: false),
                                                onTap: () {
                                                  print(data.id);
                                                }),
                                            DataCell(customText(context,
                                                text: data.time!,
                                                fontSize: 12.0,
                                                upperCase: false)),
                                            DataCell(customText(context,
                                                text: data.date!,
                                                fontSize: 12.0,
                                                upperCase: false)),
                                            DataCell(customText(context,
                                                text: data.goal!,
                                                fontSize: 12.0,
                                                upperCase: false)),
                                            DataCell(customText(context,
                                                text: '${data.id_material!}',
                                                fontSize: 12.0,
                                                upperCase: false)),
                                            DataCell(customText(context,
                                                text: '${data.id_user!}',
                                                fontSize: 12.0,
                                                upperCase: false)),
                                            DataCell(Row(
                                              children: [
                                                const Icon(
                                                  IconBroken.Edit,
                                                  color: Colors.yellow,
                                                  size: 15,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    var reservationTime=TextEditingController(text: data.time);
                                                    var reservationDate=TextEditingController(text: data.date);
                                                    var reservationGoal=TextEditingController(text: data.goal);
                                                    updateMaterialReservation(context, data.id,data.id_user,reservationTime,reservationDate,reservationGoal);
                                                    //print('tapped');
                                                    //MaterialCubit.get(context).deleteMaterial(data.id, context);
                                                  },
                                                  child: customText(context,
                                                      text: 'Edit',
                                                      color: Colors.blueGrey,
                                                      upperCase: false),
                                                )
                                              ],
                                            )),
                                            DataCell(Row(
                                              children: [
                                                const Icon(IconBroken.Delete,
                                                    color: Colors.red,
                                                    size: 15),
                                                InkWell(
                                                  onTap: () {
                                                    deleteConfirmation(context,
                                                        text1: 'ID : ${data.id!} ',
                                                        function: () {
                                                          ReservationCubit.get(context)
                                                              .deleteReservation(
                                                              data.id, context);
                                                        });
                                                  },
                                                  child: customText(context,
                                                      text: 'Delete',
                                                      color: Colors.blueGrey,
                                                      upperCase: false),
                                                ),
                                              ],
                                            )),
                                            //  DataCell(Text(''))
                                          ]))
                                              .toList()) ,
                                    ],
                                  ),
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


