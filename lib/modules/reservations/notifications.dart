import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire/models/reservation_model/classroom_reservation,_model.dart';
import 'package:memoire/shared/components/components.dart';
import 'package:memoire/shared/components/constants.dart';
import 'package:memoire/widgets/add_reservation/classroom_cubit/reservation_cubit.dart';
import 'package:memoire/widgets/add_reservation/classroom_cubit/reservation_list.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReservationCubit, ReservationStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              color: Colors.red,
              height: getHeight(context),
              width: getWidth(context),
              child: ListView.separated(itemBuilder: (context, index) {
                return buildPartItems(context, ReservationCubit
                    .get(context)
                    .particular[index]);
              },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: ReservationCubit
                      .get(context)
                      .particular
                      .length),
            ),
          ),
        );
      },);
  }

  Widget buildPartItems(context, ReservationData model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3.0,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.white,
          width: getWidth(context),
          height: 74.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(context,
                  text: 'Reservation demand of ${model.id_classroom} Classroom',
                  color: Colors.black,
                  upperCase: false),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customTextButton(
                      color: Colors.green, text: 'Accept', onPressed: () {
                    ReservationCubit.get(context).updateReservationForAdmin(
                      id: model.id,
                      context: context,
                      time: model.time!,
                      date: model.date!,
                      goal: model.goal!,
                      id_user: model.id_user,
                      etat: 'reserved',);
                  }),
                  customTextButton(
                      color: Colors.red, text: 'Refuse', onPressed: () {
                    ReservationCubit.get(context).deleteReservation(
                        model.id, context);
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
