import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:intl/intl.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:memoire/modules/classroom_amphi_screen/classroom_amphi_screen.dart';
import 'package:memoire/modules/home_screen/home_screen.dart';
import 'package:memoire/modules/material_screen/material_screen.dart';
import 'package:memoire/modules/reservations/classroom_reservation_screen.dart';
import 'package:memoire/modules/teachers_screen/teachers_screen.dart';
import 'package:memoire/widgets/add_clasrrom/add_classroom.dart';
import 'package:memoire/widgets/add_material/cubit/material_cubit.dart';
import 'package:memoire/widgets/search/search_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/reservation_model/classroom_reservation,_model.dart';
import '../../modules/request_admin_account/request_admin_account.dart';
import '../../modules/reservations/material_reservation_screen.dart';
import '../../modules/welcome_screen/welcome_screen.dart';
import '../../widgets/add_clasrrom/cubit/add_cubit.dart';
import '../../widgets/add_material/add_material.dart';
import '../../widgets/add_reservation/classroom_cubit/reservation_cubit.dart';
import '../../widgets/add_reservation/classroom_cubit/reservation_list.dart';
import '../../widgets/add_reservation/material_reservation/material_reservation_cubit.dart';
import '../../widgets/login/cubit/cubit.dart';
import '../../widgets/login/cubit/states.dart';
import '../../widgets/login/login_widget.dart';
import '../../widgets/register/register_cubit/register_cubit.dart';
import '../../widgets/register/register_widget.dart';
import '../cubit/app_cubit.dart';
import '../network/cache_helper.dart';
import '../styles/icons.dart';
import 'constants.dart';

Widget customTextButton(
        {double? fontSize,
        onHover,
        bool isHover = false,
        required String text,
        color,
        var onPressed}) =>
    TextButton(

      onHover: onHover,
      onPressed: onPressed,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
          //padding: EdgeInsets.all(isHoverings ?15: 10),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            // borderRadius: BorderRadius.circular(15),
          ),
          child: Text(text,
              style: TextStyle(
                  fontSize: fontSize ?? 16,
                  color: color ?? Colors.white,
                  height: 1.6,
                  decoration: isHover == false
                      ? TextDecoration.none
                      : TextDecoration.underline))),
    );

Widget customEventContainer({
  required onHover,
  bool isHover = false,
}) =>
    InkWell(
      onTap: () => null,
      onHover: onHover,
      child: AnimatedContainer(
          width: 300,
          height: 500,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          duration: const Duration(milliseconds: 200),
          // curve: Curves.decelerate,
          padding: EdgeInsets.all(isHover ? 00 : 5),
          decoration: BoxDecoration(
              color: isHover ? Colors.indigoAccent : Colors.green,
              borderRadius: BorderRadius.circular(0),
              image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://th.bing.com/th/id/R.4c4b9345f562cf772cff2f664876a3a8?rik=a3dHe%2b8CRR0%2bjg&pid=ImgRaw&r=0'))),
          child: Container(
            color: isHover ? Colors.grey.withOpacity(.3) : Colors.transparent,
            //padding:const EdgeInsets.symmetric(horizontal: 30.0,vertical: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('hello world',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        decoration: isHover == false
                            ? TextDecoration.none
                            : TextDecoration.underline)),
                const SizedBox(
                  height: 20.0,
                ),
                if (isHover == true)
                  const Text(
                    'hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world  ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 3,
                  )
              ],
            ),
          )),
    );

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [home, share, settings];
  static const List<MenuItem> secondItems = [login];
  static const home = MenuItem(text: 'Home', icon: IconBroken.Home);
  static const share = MenuItem(text: 'Researchers', icon: IconBroken.User);
  static const settings = MenuItem(text: 'Faculties', icon: IconBroken.Setting);
  static const login = MenuItem(text: 'Log In', icon: IconBroken.Login);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
        //Do something
        break;
      case MenuItems.settings:
        //Do something
        break;
      case MenuItems.share:
        //Do something
        break;
      case MenuItems.login:
        // AddClassWidgetMinSized();
        break;
    }
  }
}

var email = TextEditingController();
Widget header(context) => SliverAppBar(
      leadingWidth: 90,
      toolbarHeight: 80,
      leading: Container(
          margin: const EdgeInsets.only(
              top: 5.0, left: 10.0, right: 5.0, bottom: 5.0),
          width: 100,
          height: 55,
          child: const CircleAvatar(
            backgroundImage: NetworkImage('assets/images/univlogo.png'),
          )),
      title: JustTheTooltip(
        backgroundColor: Colors.grey.withOpacity(.3),
        child: const Text(
          'University Constantine 2 -UC 2\nAbdelhamid mehri',
          style: TextStyle(color: Colors.white, fontSize: 13.0, height: 1.6),
        ),
        content: const Padding(
          padding: EdgeInsets.all(0.0),
          child: Text(
            'ABDELHAMID MEHRI university',
            style: TextStyle(color: Colors.white, fontSize: 15.0),
          ),
        ),
      ),
      snap: false,
      pinned: false,
      floating: true,
      expandedHeight: 80,
      backgroundColor: const Color.fromRGBO(20, 30, 29, 1),
      actions: <Widget>[
        const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: LoginWidget()),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
          child: animatedToggleSwitch(context, (b) {
            AppCubit.get(context).changeAppMode();
          }),
        )
      ], //<Widget>[]
    );

void navigateAndReplace(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);
void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
final RegExp phoneRegex = new RegExp(r'^[6-9]\$');

Widget verticalSizedBox(double height) => SizedBox(height: height);
Widget horizontalSizedBox(double width) => SizedBox(height: width);

Widget customTextField(
  context, {
  required TextEditingController controller,
  required String label,
  IconData? icon,
  required TextInputType textInputType,
  //dynamic onFieldSubmitted,
  bool obscureText = false,
  inputFormatters,
  Color? color,
      textColor,
      int? maxLines
}) =>
    TextFormField(
      maxLines: maxLines??1,
        inputFormatters: inputFormatters,
        //onFieldSubmitted:onFieldSubmitted,
        keyboardType: textInputType,
        obscureText: obscureText,
        style: TextStyle(
            color:textColor==null? dark(context) ? Colors.white : Colors.black:textColor, fontSize: 16.0),
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return '$label field is Empty';
          }
          if (label == 'Email') {
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Email badly formatted';
            }
          }

          return null;
        },
        decoration: InputDecoration(
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: Colors.black38,
                )
              : null,
          filled: true,
          fillColor: Colors.white12,
          labelText: label,
          labelStyle: TextStyle(color: color ?? Colors.green.withOpacity(.6)),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            borderSide:
                BorderSide(width: 3, color: Colors.green.withOpacity(.6)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green.withOpacity(.6)),
            borderRadius: BorderRadius.circular(30.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(.4),
              )),
        ));

Widget headerMin(context) => SliverAppBar(
      leadingWidth: 90,
      toolbarHeight: 100,
      leading: Container(
          margin: const EdgeInsets.all(8.0),
          width: 100,
          height: 200,
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://th.bing.com/th/id/R.e6e6c149a198cb02fa177bd0742683ba?rik=R6zJ9A7iZXeLNQ&pid=ImgRaw&r=0'),
          )),
      title: JustTheTooltip(
        backgroundColor: Colors.grey.withOpacity(.3),
        child: const Text(
          'ABDELHAMID MEHRI \n university',
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        content: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'ABDELHAMID MEHRI \n university',
            style: TextStyle(color: Colors.white, fontSize: 15.0),
          ),
        ),
      ),
      snap: false,
      pinned: false,
      floating: true,
      expandedHeight: 80,
      backgroundColor: const Color.fromRGBO(20, 30, 29, 1),
      actions: <Widget>[
        JustTheTooltip(
          backgroundColor: Colors.grey.withOpacity(.3),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              customButton: const Icon(
                Icons.list,
                size: 46,
                color: Colors.white,
              ),
              customItemsIndexes: const [3],
              customItemsHeight: 8,
              items: [
                ...MenuItems.firstItems.map(
                  (item) => DropdownMenuItem<MenuItem>(
                    value: item,
                    child: MenuItems.buildItem(item),
                  ),
                ),
                const DropdownMenuItem<Divider>(
                    enabled: false, child: Divider()),
                ...MenuItems.secondItems.map(
                  (item) => DropdownMenuItem<MenuItem>(
                    value: item,
                    child: MenuItems.buildItem(item),
                  ),
                ),
              ],
              onChanged: (value) {
                MenuItems.onChanged(context, value as MenuItem);
              },
              itemHeight: 48,
              itemPadding: const EdgeInsets.only(left: 16, right: 16),
              dropdownWidth: 160,
              dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey.withOpacity(.4),
              ),
              dropdownElevation: 8,
              offset: const Offset(0, 8),
            ),
          ),
          content: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('menu',
                style: TextStyle(color: Colors.white, fontSize: 15.0)),
          ),
        ),
        const SizedBox(
          width: 20.0,
        )
      ], //<Widget>[]
    );

/*Future loginAlertDialog(context)=> showDialog(
    context: context,
    builder: (_) =>  AlertDialog(
      shape:const RoundedRectangleBorder(
          borderRadius:
          BorderRadius.all(
              Radius.circular(10.0))),
      content: Builder(
        builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return SizedBox(
            height: (height/2)-20,
            width: (width /3)-50,
            child:  Column(
              children: [
                getCloseButton(context),
                Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 40.0),
                  child: SizedBox(
                    height:(height/2 )-65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultFormField(context, controller: TextEditingController(), inputType: TextInputType.emailAddress, validator: (val){
                          if(val.isEmpty){
                            return 'email is empty';
                          }
                        }, label: 'Email'),
                        const SizedBox(height: 10.0,),
                        defaultFormField(context, controller: TextEditingController(), inputType: TextInputType.emailAddress, validator: (val){
                          if(val.isEmpty){
                            return 'email is empty';
                          }
                        }, label: 'Password',obsText: true ),
                        const SizedBox(height: 25.0,),
                        defaultButton(function: (){}, text: 'Log In'),
                        const SizedBox(height: 20.0,),
                        TextButton(onPressed: (){}, child:const Text('Forgot password?',style: TextStyle(color: Colors.green),)),
                        const SizedBox(height: 15.0,),
                        const Divider(indent: 20.0,endIndent: 20.0,)
                      ],
                    ),
                  ),
                ),
              ],
            ),

          );
        },
      ),
    )
);
*/

Widget defaultFormField(context,
        {required TextEditingController controller,
        obsText = false,
        required TextInputType inputType,
        onSubmit,
        onChange,
        required String label,
        suffix,
        bool isClickable = true,
        onPressed,
        inputFormatter,
        onTap}) =>
    TextFormField(
        inputFormatters: inputFormatter,
        style: TextStyle(color: dark(context) ? Colors.white : Colors.black),
        keyboardType: inputType,
        obscureText: obsText,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        //onTap: onTap,
        validator: (value) {
          if (value!.isEmpty) {
            return '$label field is Empty';
          }
          if (label == 'Email') {
            if (!emailVerifier.hasMatch(value)) {
              return "Enter Correct Email Address";
            }
          }
          if (label == 'Password') {
            if (value.length < 8) {
              return "Password must contain at least 8 caracters";
            }
          }

          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          //suffix: Icon( suffix,color: Colors.black,),
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(suffix),
          ),
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(width: 3, color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color: Colors.grey,
              )),
        ));

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.green,
  @required function,
  @required text,
  bool iconText = false,
  icon,
  radius
}) =>
    Container(
      decoration: BoxDecoration(
          color: background,
          borderRadius:  BorderRadius.all(Radius.circular(radius??10.0))),
      width: width,
      height: 50,
      child: MaterialButton(
        onPressed: function,
        child: iconText == false
            ? Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              )
            : Icon(icon),
      ),
    );

getCloseButton(context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
    child: GestureDetector(
      onTap: () {},
      child: Container(
        alignment: FractionalOffset.topRight,
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.grey,
            )),
      ),
    ),
  );
}

//not used yet
Widget customListTile({
  required double width,
  required String text,
  required value,
  required groupValue,
}) =>
    SizedBox(
      width: width,
      child: ListTile(
        title: Text(text),
        leading: Radio(
            fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
            focusColor:
                MaterialStateColor.resolveWith((states) => Colors.green),
            value: value,
            groupValue: groupValue,
            onChanged: null),
      ),
    );

Widget customFlatButton(context,
        {required String text, onPressed, required Color color}) =>
    FlatButton(
        onPressed: onPressed,
        child: Container(
          padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
          width: 250,
          child: Text(
            text,
            style:
                TextStyle(color: dark(context) ? Colors.white : Colors.black),
          ),
        ),
        hoverColor: color);
Widget customDivider({Color? color}) => Container(
      height: 1.5,
      color: color ?? Colors.green,
    );

Widget leftMenu(context) => Container(
      padding:CacheHelper.getData(key: 'role')=='admin'? getWidth(context) > 1025
          ? const EdgeInsets.only(left: 50, top: 50)
          : const EdgeInsets.only(top: 50):const EdgeInsets.only(top: 100),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         FlatButton(
            onPressed: () {
              navigateTo(context, HomeScreen());
            },
            child: Container(
              padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
              width: 300,
              child: Text(
                'administrative team',
                style: textStyle(context),
              ),
            ),
            hoverColor: Colors.lightGreen.withOpacity(.4),
          ),
          Container(
            height: 1.5,
            color: Colors.green,
          ),
          CacheHelper.getData(key: 'role')=='admin'?  FlatButton(
            onPressed: () {
              navigateTo(context, TeachersScreen());
              //ReservationCubit.get(context).getAllReservations(context, id);
            },
            child: Container(
              padding:const EdgeInsets.only(left: 10, top: 15, bottom: 15),
              width: 300,
              child: Text(
                'Professors',
                style: textStyle(context),
              ),
            ),
            hoverColor: Colors.lightGreen.withOpacity(.4),
          ):const SizedBox(),
          Container(
            height: 1.5,
            color: Colors.green,
          ),
          FlatButton(
            onPressed: () {
              navigateTo(context, ClassroomScreen());

            },
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
              width: 300,
              child: Text(
                'Classrooms and Amphitheatre',
                style: textStyle(context),
              ),
            ),
            hoverColor: Colors.lightGreen.withOpacity(.4),
          ),
          Container(
            height: 1.5,
            color: Colors.green,
          ),
          FlatButton(
            onPressed: () {
              navigateTo(context, MaterialScreen());
            },
            child: Container(
              padding:const EdgeInsets.only(left: 10, top: 15, bottom: 15),
              width: 300,
              child: Text(
                'Materials',
                style: textStyle(context),
              ),
            ),
            hoverColor: Colors.lightGreen.withOpacity(.4),
          ),
          Container(
            height: 1.5,
            color: Colors.green,
          ),
          Container(
            width: 300,
            height: 117,
            color: Colors.lightGreen.withOpacity(.3),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reservation space of teachers',
                    style: TextStyle(color: Colors.green),
                  ),
                  verticalSizedBox(10.0),
                  TextButton(
                      onPressed: () {
                        ReservationCubit.get(context).getReservation(context);
                       // print('users id ${LoginCubit.get(context).userData.id}');
                      //  print(ReservationCubit.get(context).getAllReservation(context));
                        navigateTo(context, ClassroomReservationScreen());
                      },
                      child: Text(
                        'Classrooms & Amphitheatre',
                        style: textStyle(context, fontSize: 12.0),
                      )),
                  verticalSizedBox(5.0),
                  TextButton(
                      onPressed: () {
                        navigateTo(context, MaterialReservationScreen());
                      },
                      child: Text(
                        'Material',
                        style: textStyle(context, fontSize: 12.0),
                      )),
                ],
              ),
            ),
          ),
          verticalSizedBox(10),

        ],
      ),
    );

Widget headerMainScreen(context, onChange,{ controller}) => SliverAppBar(
      leadingWidth: 90,
      toolbarHeight: 55,
      snap: false,
      pinned: false,
      floating: true,
      expandedHeight: 55,
      backgroundColor: Colors.black,
      actions: <Widget>[
        Padding(
          padding: getWidth(context) >= 900
              ? const EdgeInsets.only(top: 8.0, right: 80)
              : const EdgeInsets.only(top: 8.0, right: 20),
          child: Row(
            children: [
              customText(context, text: '+213 (0) 31.78.31.73',color: Colors.white),
              const SizedBox(
                width: 30,
              ),
               InkWell(
                 onTap:()=>sendEmail(' fac.ntic@univ-constantine2.dz', ''),
                 child: Container(
                    padding: const EdgeInsets.all(5),
                    alignment: AlignmentDirectional.center,
                    width: 30,
                    height: 30,
                    color: Colors.green,
                    child: Image.asset(
                      'assets/images/email.png',
                    )),
               ),

             const SizedBox(
                width: 10,
              ),
              socialMedia('assets/images/twitter.png', ('https://twitter.com/fac_ntic_UC2')),
             const SizedBox(
                width: 10,
              ),
              socialMedia('assets/images/facebook.png', ('https://web.facebook.com/faculteNTICUC2')),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        Padding(
          padding: getWidth(context) >= 900
              ? const EdgeInsets.only(top: 8.0, right: 30, bottom: 8.0)
              : const EdgeInsets.only(top: 8.0, right: 20, bottom: 8.0),
          child: AnimatedToggleSwitch<bool>.dual(
            innerColor:
                AppCubit.get(context).isDark ? Colors.white : Colors.grey,
            current: AppCubit.get(context).isDark,
            first: false,
            second: true,
            dif: 1.0,
            borderColor: Colors.transparent,
            borderWidth: 5.0,
            height: 40,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1.5),
              ),
            ],
            onChanged: onChange,
            colorBuilder: (b) => b ? Colors.black : Colors.white,
            iconBuilder: (value) => value
                ? const Icon(
                    Icons.brightness_4_outlined,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.brightness_4_outlined,
                    color: Colors.black,
                  ),
            textBuilder: (value) => !value
                ? const Icon(
                    Icons.brightness_4_outlined,
                    color: Colors.grey,
                  )
                : const Icon(
                    Icons.brightness_4_outlined,
                    color: Colors.white,
                  ),
          ),
        ),
        Padding(
           padding: getWidth(context) >= 900
               ? const EdgeInsets.only(top: 8.0, right: 80, bottom: 8.0)
               : const EdgeInsets.only(top: 8.0, right: 20, bottom: 8.0),
           child:CustomPopupMenu(
             arrowSize: 30,
             arrowColor: Colors.transparent,
             child:Center(child: customText(context, text: 'ME'),),
             menuBuilder: () => ClipRRect(
               borderRadius:
               BorderRadius.circular(5),
               child: Container(
                 color: Colors.white,
                 child: IntrinsicWidth(
                   child: Column(
                     crossAxisAlignment:
                     CrossAxisAlignment
                         .stretch,
                     children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,top:10),
                        child:  Row(
                            children: [
                              customText(context, text: CacheHelper.getData(key: 'first_name'),upperCase: false,color: Colors.black),
                              const SizedBox(width: 5,),
                              customText(context, text: CacheHelper.getData(key: 'last_name'),color: Colors.black),
                              const SizedBox(width: 15,),
                              InkWell(
                                onTap: (){
                                  TextEditingController
                                  _firstNameController =
                                  TextEditingController(
                                      text:CacheHelper.getData(key: 'first_name'));
                                  TextEditingController
                                  _lastNameController =
                                  TextEditingController(
                                      text:
                                      CacheHelper.getData(key: 'last_name'));
                                  TextEditingController
                                  _gradeController =
                                  TextEditingController(
                                      text: CacheHelper.getData(key: 'grade'));
                                  TextEditingController
                                  _placeController =
                                  TextEditingController(
                                      text: CacheHelper.getData(key: 'place'));
                                  updateUserDialog(context,
                                      firstName:
                                      _firstNameController,
                                      lastName:
                                      _lastNameController,
                                      grade: _gradeController,
                                      place: _placeController,
                                      function: () {
                                        if (formKey.currentState!
                                            .validate()) {
                                          LoginCubit.get(context).userUpdate(
                                              id: CacheHelper.getData(key: 'ID'),
                                              first_name:
                                              _firstNameController
                                                  .text,
                                              last_name:
                                              _lastNameController
                                                  .text,
                                              grade:
                                              _gradeController
                                                  .text,
                                              place:
                                              _placeController
                                                  .text,
                                              role: _role.name, context: context);
                                          LoginCubit.get(context).getUsers();
                                        }
                                        //update
                                      });
                                },
                                  child: const Icon(Icons.edit,color: Colors.green,))
                            ],
                          ),

                      ),
                        Padding(
                         padding:const  EdgeInsets.only(left: 10,right: 10,top:10),
                         child:customText(context, text: CacheHelper.getData(key: 'grade'),upperCase: false,color: Colors.black),
                       ),
                       Padding(
                         padding:const  EdgeInsets.only(left: 10,right: 10,top:10),
                         child:customText(context, text: CacheHelper.getData(key: 'place'),upperCase: false,color: Colors.black),
                       ),
                       const SizedBox(height: 10,),
                       Divider(color: Colors.green,),
                       customTextButton(
                         onPressed: () {
                           showDialog(
                               context: context,
                               builder: (_) {
                                 return AlertDialog(
                                   title:const Text(
                                       'Are you sure you want to log out?'),
                                   actions: [
                                     Row(
                                       children: [
                                         Expanded(
                                             child: defaultButton(
                                                 function: () {
                                                   Navigator.pop(context);
                                                 },
                                                 text: 'no',
                                                 background: Colors.grey)),
                                         const SizedBox(
                                           width: 15,
                                         ),
                                         Expanded(
                                             child: defaultButton(
                                                 background: Colors.red,
                                                 text: 'yes',
                                                 function: (){
                                                   CacheHelper.clearData();
                                                   print(CacheHelper.getData(
                                                       key: 'token'));
                                                   //CacheHelper.getData(key: 'ID')
                                                   navigateAndReplace(
                                                       context, const WelcomePage());
                                                 })),
                                       ],
                                     )
                                   ],
                                 );
                               });
                         },
                         color:  Colors.green
                             ,

                         text: 'Log out',

                         isHover: isLogOut,
                       ),
                       Divider(color: Colors.red,),
                       customTextButton(
                         onPressed: () {
                           deleteConfirmation(context,
                               text1: 'your account?',
                               function: () {
                                 LoginCubit.get(context)
                                     .deleteAccount(
                                     CacheHelper.getData(key: 'ID'), context);
                               });
                         },
                         color:  Colors.red
                         ,
                         text: 'Delete account',

                         isHover: isLogOut,
                       ),
                       const SizedBox(height: 10,),

                     ],
                   ),
                 ),
               ),
             ),
             pressType: PressType.singleClick,
             verticalMargin: -10,
             controller: controller,
           ),
         ),

      ], //<Widget>[]
    );
Widget headerMainScreenMinSize(context, onchange) => SliverAppBar(
      leadingWidth: 90,
      toolbarHeight: 55,
      snap: false,
      pinned: false,
      leading: const Icon(
        Icons.list,
        color: Colors.green,
        size: 40,
      ),
      floating: true,
      expandedHeight: 55,
      backgroundColor: Colors.black,
      actions: <Widget>[
        /* AnimatedToggleSwitch<bool>.dual(
          current: positive,
          first: false,
          second: true,
          dif: 50.0,
          borderColor: Colors.transparent,
          borderWidth: 5.0,
          height: 55,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1.5),
            ),
          ],
          onChanged: (b) => setState(() => positive = b),
          colorBuilder: (b) => b ? Colors.red : Colors.green,
          iconBuilder: (value) => value
              ? Icon(Icons.coronavirus_rounded)
              : Icon(Icons.tag_faces_rounded),
          textBuilder: (value) => value
              ? Center(child: Text('Oh no...'))
              : Center(child: Text('Nice :)')),
        ),*/
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 10, bottom: 8.0),
          child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
              //padding:const EdgeInsets.all(5),
              alignment: AlignmentDirectional.center,
              width: 40,
              height: 20,
              child:  Icon(
                IconBroken.Search,
                color:dark(context)? Colors.white:Colors.black,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 10, bottom: 8.0),
          child: AnimatedToggleSwitch<bool>.dual(
            innerColor:
                AppCubit.get(context).isDark ? Colors.white : Colors.grey,
            current: AppCubit.get(context).isDark,
            first: false,
            second: true,
            dif: 1.0,
            borderColor: Colors.transparent,
            borderWidth: 5.0,
            height: 40,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1.5),
              ),
            ],
            onChanged: onchange,
            colorBuilder: (b) => b ? Colors.black : Colors.white,
            iconBuilder: (value) => value
                ? const Icon(
                    Icons.brightness_4_outlined,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.brightness_4_outlined,
                    color: Colors.black,
                  ),
            textBuilder: (value) => !value
                ? const Icon(
                    Icons.brightness_4_outlined,
                    color: Colors.grey,
                  )
                : const Icon(
                    Icons.brightness_4_outlined,
                    color: Colors.white,
                  ),
          ),
        ),
      ], //<Widget>[]
    );

TextStyle textStyle(context, {double? fontSize}) => TextStyle(
    color: dark(context) ? Colors.white : Colors.black,
    fontSize: fontSize ?? 15.0);
enum toastStates { success, error, warning }

toastColor(toastStates state) {
  Color color;
  switch (state) {
    case toastStates.success:
      color = Colors.green;
      break;
    case toastStates.warning:
      color = Colors.amber;
      break;
    case toastStates.error:
      color = Colors.red;
      break;
  }
  return color;
}

Future flutterToast(
        {required String msg,
        Color color = Colors.red,
        required toastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: toastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

// Home screen min size components
flatIConItems(
        {required String label, required onTap, required IconData icon}) =>
    HawkFabMenuItem(
      label: label,
      ontap: onTap,
      labelBackgroundColor: Colors.grey,
      icon: Icon(
        icon,
        color: Colors.grey,
      ),
      color: Colors.white,
      labelColor: Colors.white,
    );
animatedToggleSwitch(context, onChange) => AnimatedToggleSwitch<bool>.dual(
      innerColor: AppCubit.get(context).isDark ? Colors.white : Colors.grey,
      current: AppCubit.get(context).isDark,
      first: false,
      second: true,
      dif: 1.0,
      borderColor: Colors.transparent,
      borderWidth: 5.0,
      height: 40,
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          spreadRadius: 1,
          blurRadius: 2,
          offset: Offset(0, 1.5),
        ),
      ],
      onChanged: onChange,
      colorBuilder: (b) => b ? Colors.black : Colors.white,
      iconBuilder: (value) => value
          ? const Icon(
              Icons.brightness_4_outlined,
              color: Colors.white,
            )
          : const Icon(
              Icons.brightness_4_outlined,
              color: Colors.black,
            ),
      textBuilder: (value) => !value
          ? const Icon(
              Icons.brightness_4_outlined,
              color: Colors.grey,
            )
          : const Icon(
              Icons.brightness_4_outlined,
              color: Colors.white,
            ),
    );
sliderView(context) => Container(
      color: Colors.grey.withOpacity(.7),
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            '   Nick',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontFamily: 'BalsamiqSans'),
          ),
          const SizedBox(
            height: 50,
          ),
          FlatButton(
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
              width: 300,
              child: Text(
                'administrative team',
                style: textStyle(context),
              ),
            ),
            hoverColor: Colors.lightGreen.withOpacity(.4),
          ),
          FlatButton(
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
              width: 300,
              child: Text(
                'Teachers',
                style: textStyle(context),
              ),
            ),
            hoverColor: Colors.lightGreen.withOpacity(.4),
          ),
          FlatButton(
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
              width: 300,
              child: Text(
                'Classrooms and Amphitheatre',
                style: textStyle(context),
              ),
            ),
            hoverColor: Colors.lightGreen.withOpacity(.4),
          ),
          FlatButton(
            onPressed: () {},
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
              width: 300,
              child: Text(
                'Materials',
                style: textStyle(context),
              ),
            ),
            hoverColor: Colors.lightGreen.withOpacity(.4),
          ),
          verticalSizedBox(10),
          FlatButton(
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
              width: 300,
              child: Text('Messaging', style: textStyle(context)),
            ),
            hoverColor: Colors.lightGreen.withOpacity(.4),
          ),
          SizedBox(
            height: 300,
          )
        ],
      ),
    );
sliderAppBAr(context) => SliderAppBar(
      appBarPadding: const EdgeInsets.all(0),
      drawerIcon: const Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Icon(
          Icons.list,
          color: Colors.green,
          size: 40,
        ),
      ),
      title: const Text(''),
      trailing: SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0, right: 10, bottom: 0.0),
              child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.green)),
                  //padding:const EdgeInsets.all(5),
                  alignment: AlignmentDirectional.center,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    IconBroken.Search,
                    color: Colors.white,
                  )),
            ),
            Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, right: 10, bottom: 8.0),
                child: animatedToggleSwitch(context, (b) {
                  AppCubit.get(context).changeAppMode();
                })),
          ],
        ),
      ),
      appBarHeight: 55,
      drawerIconColor: Colors.green,
      //drawerIcon: Icon(Icons.list,color: Colors.green,size: 30,),
      appBarColor: Colors.black,
    );

//show Dialogs
//register dialog
role _role = role.teacher;
registerDialog(context, state) => showDialog(
    barrierColor: dark(context) ? Colors.white24 : Colors.black26,
    context: context,
    builder: (_) => AlertDialog(
        backgroundColor: dark(context) ? Colors.black : Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Builder(
              builder: (context) {
                return SizedBox(
                  height: 523.0,
                  width: 500,
                  child: Column(
                    children: [
                      getCloseButton(context),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          height: 472.0,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: defaultFormField(context,
                                          controller: firstNameController,
                                          inputType: TextInputType.name,
                                          label: 'First name'),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: defaultFormField(context,
                                          controller: lastNameController,
                                          inputType: TextInputType.name,
                                          label: 'Last name'),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: defaultFormField(context,
                                          controller: gradeController,
                                          inputType: TextInputType.text,
                                          label: 'Grade'),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: defaultFormField(context,
                                          controller: placeController,
                                          inputType: TextInputType.name,
                                          label: 'Place'),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                defaultFormField(context,
                                    controller: emailController,
                                    inputType: TextInputType.emailAddress,
                                    label: 'Email'),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                defaultFormField(context,
                                    obsText: true,
                                    controller: passwordController,
                                    inputType: TextInputType.emailAddress,
                                    label: 'Password'),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: ListTile(
                                        title: Text('Teacher',
                                            style: TextStyle(
                                                color: dark(context)
                                                    ? Colors.white
                                                    : Colors.black)),
                                        leading: Radio<role>(
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.green),
                                          value: role.teacher,
                                          groupValue: _role,
                                          onChanged: (role? value) {
                                            setState(() {
                                              _role = value!;
                                              print(_role.name);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 170,
                                      child: ListTile(
                                        title: Text('Admin',
                                            style: TextStyle(
                                                color: dark(context)
                                                    ? Colors.white
                                                    : Colors.black)),
                                        leading: Radio(
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.green),
                                          focusColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.green),
                                          value: role.admin,
                                          groupValue: _role,
                                          onChanged: (role? value) {
                                            setState(() {
                                              _role = value!;
                                              print(_role.name);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25.0,
                                ),
                                defaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        RegisterCubits.get(context)
                                            .userRegister(
                                                context: context,
                                                email: emailController.text,
                                                firstName:
                                                    firstNameController.text,
                                                lastName:
                                                    lastNameController.text,
                                                grade: gradeController.text,
                                                place: placeController.text,
                                                role: _role.name,
                                                password:
                                                    passwordController.text,
                                                passwordConfirmation:
                                                    passwordController.text);
                                        // cubits.userReg(email: emailController.text, name: nameC, role: role, password: password, password_conf: password_conf)
                                      }
                                    },
                                    text: 'Register'),
                                const Divider(
                                  indent: 20.0,
                                  endIndent: 20.0,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        )));

//class dialog

Type _type = Type.classroom;
particular _particular = particular.no;
addClassDialog(context) => showDialog(
    barrierColor: dark(context) ? Colors.white24 : Colors.black26,
    context: context,
    builder: (_) => AlertDialog(
        backgroundColor: dark(context) ? Colors.black : Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Builder(
              builder: (context) {
                return SizedBox(
                  height: 624.0,
                  width: 350.0,
                  child: Column(
                    children: [
                      getCloseButton(context),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: SizedBox(
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //customFormField(sallename),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButtonFormField2(
                                        style: TextStyle(
                                            color: dark(context)
                                                ? Colors.white
                                                : Colors.black),
                                        selectedItemHighlightColor: Colors.grey,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.zero,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                  color: Colors.white)),
                                        ),
                                        isExpanded: true,
                                        hint: Text(
                                          'Type',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: dark(context)
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: dark(context)
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        iconSize: 30,
                                        buttonHeight: 60,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 20, right: 10),
                                        dropdownDecoration: BoxDecoration(
                                          color: dark(context)
                                              ? Colors.black
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        items: classType
                                            .map((item) => DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please select a name.';
                                          }
                                        },
                                        onChanged: (value) {
                                          selectedClassroom = value.toString();
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Expanded(
                                      child: DropdownButtonFormField2(
                                        style: TextStyle(
                                            color: dark(context)
                                                ? Colors.white
                                                : Colors.black),
                                        selectedItemHighlightColor: Colors.grey,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.zero,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                  color: Colors.white)),
                                        ),
                                        isExpanded: true,
                                        hint: Text(
                                          'Number',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: dark(context)
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: dark(context)
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        iconSize: 30,
                                        buttonHeight: 60,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 20, right: 10),
                                        dropdownDecoration: BoxDecoration(
                                          color: dark(context)
                                              ? Colors.black
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        items: classNumber
                                            .map((item) => DropdownMenuItem<int>(
                                          value: item,
                                          child: Text(
                                            '$item',
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                            .toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please select a number.';
                                          }
                                        },
                                        onChanged: (value) {
                                          selectedClassroomNumber = value.toString();
                                          print(selectedClassroomNumber.toString());
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                                verticalSizedBox(
                                  20.0,
                                ),
                                defaultFormField(context,
                                    controller: salleEtage,
                                    inputType: TextInputType.number,
                                    label: 'Stage',
                                    inputFormatter: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ]),
                                /* customTextField(context,controller:salleEtage , label: '  Stage', textInputType: TextInputType.number,
                                           color: dark(context)?Colors.white:Colors.black54,inputFormatters:  <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                            ],),*/
                                verticalSizedBox(
                                  10.0,
                                ),
                                defaultFormField(context,
                                    controller: salleCapacity,
                                    inputType: TextInputType.number,
                                    inputFormatter: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    label: 'Capacity'),
                                /* customTextField(context,controller:salleCapacity , label: '  Capacity', textInputType: TextInputType.number,color:dark(context)?Colors.white:Colors.black54,inputFormatters:  <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                            ],),*/
                                verticalSizedBox(
                                  30.0,
                                ),
                                Text(
                                  'Choose the type',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: dark(context)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                verticalSizedBox(
                                  20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: ListTile(
                                        title: Text('Class',
                                            style: TextStyle(
                                                color: dark(context)
                                                    ? Colors.white
                                                    : Colors.black)),
                                        leading: Radio<Type>(
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.green),
                                          value: Type.classroom,
                                          groupValue: _type,
                                          onChanged: (Type? value) {
                                            setState(() {
                                              _type = value!;
                                              print(_type.name);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 170,
                                      child: ListTile(
                                        title: Text('Amphi',
                                            style: TextStyle(
                                                color: dark(context)
                                                    ? Colors.white
                                                    : Colors.black)),
                                        leading: Radio(
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.green),
                                          focusColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.green),
                                          value: Type.amphi,
                                          groupValue: _type,
                                          onChanged: (Type? value) {
                                            setState(() {
                                              _type = value!;
                                              print(_type.name);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSizedBox(
                                  20.0,
                                ),

                                Text(
                                  'Is it particular?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: dark(context)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                verticalSizedBox(
                                  20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 170,
                                      child: ListTile(
                                        title: Text('No',
                                            style: TextStyle(
                                                color: dark(context)
                                                    ? Colors.white
                                                    : Colors.black)),
                                        leading: Radio(
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.green),
                                          focusColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.green),
                                          value: particular.no,
                                          groupValue: _particular,
                                          onChanged: (particular? value) {
                                            setState(() {
                                              _particular = value!;
                                              print(_particular.name);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: ListTile(
                                        title: Text('Yes',
                                            style: TextStyle(
                                                color: dark(context)
                                                    ? Colors.white
                                                    : Colors.black)),
                                        leading: Radio<particular>(
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.green),
                                          value: particular.yes,
                                          groupValue: _particular,
                                          onChanged: (particular? value) {
                                            setState(() {
                                              _particular = value!;
                                              print(_particular.name);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSizedBox(
                                  30.0,
                                ),
                                SizedBox(
                                    width: 300.0,
                                    child: defaultButton(
                                        function: () {
                                          AddCubit.get(context).searchData('Item8');
                                          if (formKey.currentState!
                                              .validate()) {
                                            AddCubit.get(context).addClass(
                                                context,
                                                name:'${selectedClassroom.toString()} ${selectedClassroomNumber.toString()}',
                                                type: _type.name,
                                                etage:
                                                    int.parse(salleEtage.text),
                                                capacity: int.parse(
                                                    salleCapacity.text),
                                                particulier: _particular.name);
                                          }
                                        },
                                        text: 'Add')),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        )));

//material dialog

var _nameController = TextEditingController();

addMaterialDialog(context) => showDialog(
    barrierColor: dark(context) ? Colors.white24 : Colors.black26,
    context: context,
    builder: (_) => AlertDialog(
        backgroundColor: dark(context) ? Colors.black : Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Builder(
              builder: (context) {
                return SizedBox(
                  height: 338.0,
                  width: 300,
                  child: Column(
                    children: [
                      getCloseButton(context),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: SizedBox(
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //customFormField(sallename),
                                DropdownButtonFormField2(
                                  style: TextStyle(
                                      color: dark(context)
                                          ? Colors.white
                                          : Colors.black),
                                  selectedItemHighlightColor: Colors.grey,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            color: Colors.white)),
                                  ),
                                  isExpanded: true,
                                  hint: Text(
                                    'Choose a class name',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: dark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: dark(context)
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  iconSize: 30,
                                  buttonHeight: 60,
                                  buttonPadding: const EdgeInsets.only(
                                      left: 20, right: 10),
                                  dropdownDecoration: BoxDecoration(
                                    color: dark(context)
                                        ? Colors.black
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  items: materialType
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select a category.';
                                    }
                                  },
                                  onChanged: (value) {
                                    selectedValue = value.toString();
                                  },
                                ),
                                verticalSizedBox(
                                  20.0,
                                ),
                                customTextField(context,
                                    controller: _nameController,
                                    label: '  Name',
                                    textInputType: TextInputType.text,
                                    color: dark(context)
                                        ? Colors.white
                                        : Colors.black54),
                                verticalSizedBox(
                                  30.0,
                                ),
                                SizedBox(
                                    width: 300.0,
                                    child: defaultButton(
                                        function: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            MaterialCubit.get(context)
                                                .addMaterial(
                                              context: context,
                                                    category: selectedValue
                                                        .toString(),
                                                    name: _nameController.text);
                                          }
                                        },
                                        text: 'Add')),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        )));

// login dialog
loginDialog(context, state) => showDialog(
    barrierColor: dark(context) ? Colors.white12 : Colors.black26,
    context: context,
    builder: (_) => AlertDialog(
          backgroundColor: dark(context) ? Colors.black : Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Builder(
              builder: (context) {
                return SizedBox(
                  height: 380.0,
                  width: 430.0,
                  child: Column(
                    children: [
                      getCloseButton(context),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: SizedBox(
                          height: 330.0,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                defaultFormField(context,
                                    controller: emailController,
                                    inputType: TextInputType.emailAddress,
                                    label: 'Email'),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                defaultFormField(context,
                                    obsText: true,
                                    controller: passwordController,
                                    inputType: TextInputType.emailAddress,
                                    label: 'Password', onSubmit: (value) {
                                  if (formKey.currentState!.validate()) {
                                    if (state is! LoginLoadingState) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  } else {
                                    print('not logged');
                                  }
                                }),
                                const SizedBox(
                                  height: 25.0,
                                ),
                                defaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        if (state is! LoginLoadingState) {
                                          LoginCubit.get(context).userLogin(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                          /* CacheHelper.saveData(key: 'Welcome', val: true).then((value){
                                        if(value==true){
                                          navigateAndReplace(context,const LoginScreen());
                                        }
                                      });*/
                                        }
                                      } else {
                                        print('not logged');
                                      }
                                    },
                                    text: 'Log In'),
                                const SizedBox(
                                  height: 20.0,
                                ),

                                Divider(
                                  indent: 20.0,
                                  endIndent: 20.0,
                                  color: Colors.grey.withOpacity(.4),
                                ),
                                TextButton(
                                    onPressed: () {
                                      navigateTo(context, AdminAccountRequest());
                                    },
                                    child: const Text(
                                      'I am a new Admin? request for an Admin account',
                                      style: TextStyle(color: Colors.green),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ));

Widget customText(context,
        {bool upperCase = true,
        required String text,
        double? fontSize,
        Color? color,
        FontWeight? fontWeight}) =>
    Text(
      upperCase ? text.toUpperCase() : text,
      style: TextStyle(
          fontSize: fontSize ?? 16,
          color: color == null
              ? dark(context)
                  ? Colors.white
                  : Colors.black
              : color),
    );

deleteConfirmation(context, {required String text1, String? text2, function}) =>
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
                'Are you sure you want to delete ${text1} ${text2 ?? ''}?'),
            actions: [
              Row(
                children: [
                  Expanded(
                      child: defaultButton(
                          function: () {
                            Navigator.pop(context);
                          },
                          text: 'Cancel',
                          background: Colors.grey)),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: defaultButton(
                          background: Colors.red,
                          text: 'Delete',
                          function: function)),
                ],
              )
            ],
          );
        });
// LoginCubit.get(context).userUpdate(id: data.id,first_name: _firstNameController.text,last_name: _lastNameController.text,grade: _gradeController.text,place: _placeController.text,role: _role.name);
updateUserDialog(context,{var  firstName,
  var  lastName,
  var  grade,
  var  place,function})=> showDialog(
    barrierColor:dark(context)? Colors.white24:Colors.black26,
    context: context,
    builder: (_) => AlertDialog(
        backgroundColor:
        dark(context) ? Colors.black : Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(10.0))),
        content: StatefulBuilder(
          builder:
              (BuildContext context, StateSetter setState) {
            return Builder(
              builder: (context) {
                return SizedBox(
                  height: 350.0,
                  width: 500,
                  child: Column(
                    children: [
                      getCloseButton(context),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0),
                        child: SizedBox(
                          height:300.0,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Expanded(
                                      child: defaultFormField(
                                          context,
                                          controller:
                                          firstName,
                                          inputType:
                                          TextInputType
                                              .name,
                                          label: 'First name'),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: defaultFormField(
                                          context,
                                          controller:
                                          lastName,
                                          inputType:
                                          TextInputType
                                              .name,
                                          label: 'Last name'),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Expanded(
                                      child: defaultFormField(
                                          context,
                                          controller:
                                          grade,
                                          inputType:
                                          TextInputType
                                              .text,
                                          label: 'Grade'),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: defaultFormField(
                                          context,
                                          controller:
                                          place,
                                          inputType:
                                          TextInputType
                                              .name,
                                          label: 'Place'),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),

                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: ListTile(
                                        title: Text('Teacher',
                                            style: TextStyle(
                                                color: dark(
                                                    context)
                                                    ? Colors
                                                    .white
                                                    : Colors
                                                    .black)),
                                        leading: Radio<role>(
                                          fillColor:
                                          MaterialStateColor
                                              .resolveWith(
                                                  (states) =>
                                              Colors
                                                  .green),
                                          value: role.teacher,
                                          groupValue: _role,
                                          onChanged:
                                              (role? value) {
                                            setState(() {
                                              _role = value!;
                                              print(_role.name);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 170,
                                      child: ListTile(
                                        title: Text('Admin',
                                            style: TextStyle(
                                                color: dark(
                                                    context)
                                                    ? Colors
                                                    .white
                                                    : Colors
                                                    .black)),
                                        leading: Radio(
                                          fillColor:
                                          MaterialStateColor
                                              .resolveWith(
                                                  (states) =>
                                              Colors
                                                  .green),
                                          focusColor:
                                          MaterialStateColor
                                              .resolveWith(
                                                  (states) =>
                                              Colors
                                                  .green),
                                          value: role.admin,
                                          groupValue: _role,
                                          onChanged:
                                              (role? value) {
                                            setState(() {
                                              _role = value!;
                                              print(_role.name);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25.0,
                                ),
                                defaultButton(
                                    function:function,
                                    text: 'Update'),

                                const Divider(
                                  indent: 20.0,
                                  endIndent: 20.0,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        )));
/*
 () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            AddCubit.get(context).updateClass(data.id,data.name, stage: int.parse(_classStage.text), capacity: int.parse(_classCapacity.text), particular: _particular.name);
                                          }
                                        }
 */
particular _updateParticular = particular.no;
updateClassDialog(context,{id,name,function,classStage,classCapacity})=> showDialog(
    barrierColor: dark(context) ? Colors.white24 : Colors.black26,
    context: context,
    builder: (_) => AlertDialog(
        backgroundColor: dark(context) ? Colors.black : Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
             return Builder(
              builder: (context) {
                return SizedBox(
                  height: 414.0,
                  width: 350.0,
                  child: Column(
                    children: [
                      getCloseButton(context),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: SizedBox(
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //customFormField(sallename),
                                defaultFormField(context,
                                    controller: classStage,
                                    inputType: TextInputType.number,
                                    label: 'Stage',
                                    inputFormatter: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ]),
                                /* customTextField(context,controller:salleEtage , label: '  Stage', textInputType: TextInputType.number,
                                           color: dark(context)?Colors.white:Colors.black54,inputFormatters:  <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                            ],),*/
                                verticalSizedBox(
                                  10.0,
                                ),
                                defaultFormField(context,
                                    controller: classCapacity,
                                    inputType: TextInputType.number,
                                    inputFormatter: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    label: 'Capacity'),
                                /* customTextField(context,controller:salleCapacity , label: '  Capacity', textInputType: TextInputType.number,color:dark(context)?Colors.white:Colors.black54,inputFormatters:  <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                            ],),*/
                                verticalSizedBox(
                                  20.0,
                                ),
                                Text(
                                  'Is it particular?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: dark(context)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                verticalSizedBox(
                                  20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 170,
                                      child: ListTile(
                                        title: Text('No',
                                            style: TextStyle(
                                                color: dark(context)
                                                    ? Colors.white
                                                    : Colors.black)),
                                        leading: Radio(
                                          fillColor:
                                          MaterialStateColor.resolveWith(
                                                  (states) => Colors.green),
                                          focusColor:
                                          MaterialStateColor.resolveWith(
                                                  (states) => Colors.green),
                                          value: particular.no,
                                          groupValue: _updateParticular,
                                          onChanged: (particular? value) {
                                            setState(() {
                                              _updateParticular = value!;
                                              print(_updateParticular.name);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: ListTile(
                                        title: Text('Yes',
                                            style: TextStyle(
                                                color: dark(context)
                                                    ? Colors.white
                                                    : Colors.black)),
                                        leading: Radio<particular>(
                                          fillColor:
                                          MaterialStateColor.resolveWith(
                                                  (states) => Colors.green),
                                          value: particular.yes,
                                          groupValue: _updateParticular,
                                          onChanged: (particular? value) {
                                            setState(() {
                                              _updateParticular = value!;
                                              print('salle partic ${_updateParticular.name}');
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSizedBox(
                                  30.0,
                                ),
                                SizedBox(
                                    width: 300.0,
                                    child: defaultButton(
                                        function:(){
                                          if (formKey.currentState!
                                              .validate()) {
                                            AddCubit.get(context).updateClass(id,name, stage: int.parse(classStage.text), capacity: int.parse(classCapacity.text), particular:_updateParticular.name, context:context,);
                                          }
                                        },
                                        text: 'Update')),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        )));

userReservationDialog(context,{function,classStage,classCapacity,id})=> showDialog(
    barrierColor: dark(context) ? Colors.white24 : Colors.black26,
    context: context,
    builder: (_) => AlertDialog(
        backgroundColor: dark(context) ? Colors.black : Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Builder(
              builder: (context) {
                return SizedBox(
                  width: 300,
                  height: 400,
                  child: ListView.separated(itemBuilder: (context,index){
                    return elementOne(context,ReservationCubit.get(context).allReservations[index]);
                  },
                      separatorBuilder: (context,index)=>const Divider(), itemCount: ReservationCubit.get(context).allReservations.length),
                );
              },
            );
          },
        )));

//update reservation dialog
 updateReservation(context, int? id,int? id_user, TextEditingController reservationTime, TextEditingController reservationDate, TextEditingController reservationGoal,etat) =>
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
         width: 300,
         height: 383,
         child:Column(
           children: [
             Padding(padding: const EdgeInsets.all(25.0),
                 child:Column(
                   children: [
                     getCloseButton(context),
                     const SizedBox(height: 10,),
                     defaultFormField(context,

                         controller: reservationGoal,
                         label: 'Goal',
                         inputType: TextInputType.text),
                     verticalSizedBox(15.0),
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
                     defaultButton(
                         function:(){
                           ReservationCubit.get(context).updateReservationForAdmin(id: id,context: context,time: reservationTime.text, date: reservationDate.text, goal: reservationGoal.text, id_user:id_user, etat: etat);
                          // ReservationCubit.get(context).updateReservation(id: id,context: context,time: reservationTime.text, date: reservationDate.text, goal: reservationGoal.text);
                         },
                         text: 'Update'),
                   ],
                 )),
           ],
         ),

       ),
     ),
   );
 });

 //material reservation
updateMaterialReservation(context, int? id,int? id_user, TextEditingController reservationTime, TextEditingController reservationDate, TextEditingController reservationGoal) =>
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
            width: 300,
            height: 383,
            child:Column(
              children: [
                Padding(padding: const EdgeInsets.all(25.0),
                    child:Column(
                      children: [
                        getCloseButton(context),
                        const SizedBox(height: 10,),
                        defaultFormField(context,

                            controller: reservationGoal,
                            label: 'Goal',
                            inputType: TextInputType.text),
                        verticalSizedBox(15.0),
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
                        defaultButton(
                            function:(){
                     MaterialReservationCubit.get(context).updateReservationForAdmin(id: id, time: reservationTime.text, date: reservationDate.text, goal: reservationGoal.text, id_user: id_user);
                     navigateTo(context, MaterialReservationScreen());
                              // MaterialReservationCubit.get(context).updateReservation(id: id,context: context,time: reservationTime.text, date: reservationDate.text, goal: reservationGoal.text);
                            },
                            text: 'Update'),
                      ],
                    )),


              ],
            ),

          ),
        ),
      );
    });
materialReservation(context, int? id_user,int? id_material, TextEditingController reservationTime, TextEditingController reservationDate, TextEditingController reservationGoal) =>
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
            width: 300,
            height: 414.0,
            child:Column(
              children: [
                Padding(padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          getCloseButton(context),
                          const SizedBox(height: 10,),
                          defaultFormField(context,
                              controller: reservationGoal,
                              label: 'Goal',
                              inputType: TextInputType.text),
                          verticalSizedBox(10.0),
                          customUpdateItem(context, controller: reservationTime,onPressed: (){
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) =>
                            reservationTime.text = value!.format(context).toString());
                          }),
                          verticalSizedBox(10.0),
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
                          defaultButton(
                              function:(){
                                if(formKey.currentState!.validate()){
                                  MaterialReservationCubit.get(context).addReservation(context:context,date: reservationDate.text, time: reservationTime.text, goal: reservationGoal.text, id_user: id_user, id_material: id_material);

                                }

                                // ReservationCubit.get(context).updateReservation(id: id,context: context,time: reservationTime.text, date: reservationDate.text, goal: reservationGoal.text);
                              },
                              text: 'Add'),
                        ],
                      ),
                    )),


              ],
            ),

          ),
        ),
      );
    });

elementOne(context,ReservationData model)
{
  return customText(context, text: '${model.id}',color: Colors.white);
}

Widget customUpdateItem(context,{
  required TextEditingController controller,
  onPressed
})=> Row(
  children: [
    Expanded(
        child: TextFormField(
          controller: controller,
          validator: (value){
            if(value!.isEmpty){
              return 'This Field is Empty!';
            }
          },
          style: TextStyle(color: dark(context)?Colors.white:Colors.black),
          decoration:const InputDecoration(
            hintText: 'Choose the time',
            hintStyle:TextStyle(color: Colors.grey) ,
            enabledBorder:  OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
          ),
        )
    ),
    const SizedBox(
      width: 5.0,
    ),
    FloatingActionButton(
      backgroundColor: Colors.green,
      heroTag: 'addTime',
      onPressed:onPressed,
      mini: true,
      child:const Icon(Icons.edit),
    )
  ],
);

Widget rightMenu(context,{emailHover,logoutHover,controller, children, child, notificationController})=> Padding(
  padding:getWidth(context) > 900
      ? const EdgeInsets.only(
      right: 80, top: 10)
      : const  EdgeInsets.only(
    right: 20, top: 10),
  child: Container(
    //  color: Colors.red,
    color: dark(context) ? Colors.black : Colors.white,
    height: 230,
    width: getWidth(context),
    child: Column(
       crossAxisAlignment: CrossAxisAlignment.end,
      children: [
const SizedBox(height: 30,),
        SizedBox(
          //width:462,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.7),
                 borderRadius: BorderRadius.circular(20)
                ),
                width: 400,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const RegisterWidget(),
                    VerticalDivider(
                      color: dark(context)
                          ? Colors.white
                          : Colors.black,
                      indent: 15,
                      endIndent: 15,
                      thickness: 2,
                    ),
                    const MaterialWidget(),
                    VerticalDivider(
                      color: dark(context)
                          ? Colors.white
                          : Colors.black,
                      indent: 15,
                      endIndent: 15,
                      thickness: 2,
                    ),
                   const ClassWidget(),

SizedBox(width: 20,)
                  ],
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 462,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey)),
                      child: ListTile(
                        trailing:  InkWell(
                          onTap: ()=>navigateTo(context,  SearchWidget(),),
                          child: Icon(IconBroken.Search,color: dark(context)?Colors.white:Colors.black,),
                        ),
                        leading: CustomPopupMenu(
                          arrowSize: 30,
                          arrowColor: Colors.transparent,
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Row(
                              children: [
                                const Icon(IconBroken.Notification,color: Colors.green,),
                                Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: customText(context, text: '${ReservationCubit.get(context).particular.length}')),
                              ],
                            ),
                          ),
                          menuBuilder: () => ClipRRect(
                            borderRadius:
                            BorderRadius.circular(5),
                            child: Container(
                              color: Colors.grey.shade50,
                              child:Container(
                                color: Colors.black87,
                                height: 700,
                                width: 350,
                                child: ReservationCubit.get(context).particular.isEmpty?Center(child: customText(context, text: 'No requests',upperCase: true,color: Colors.white),):BlocConsumer<ReservationCubit,ReservationStates>(builder: (context,state){
                                  return  ListView.separated(itemBuilder:(context,index){
                                    return buildNotificationItem(context,ReservationCubit.get(context).particular[index]);
                                  } , separatorBuilder:(context,index)=>const Divider() , itemCount: ReservationCubit.get(context).particular.length) ;
                                }, listener: (context,state){}),
                              )
                            ),
                          ),
                          pressType: PressType.singleClick,
                          verticalMargin: -10,
                          controller: notificationController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ),
  ),
);
Widget rightMenu2(context,{emailHover,logoutHover,controller})=> Padding(
  padding:getWidth(context) > 900
      ? const EdgeInsets.symmetric(
      horizontal: 80, vertical: 40)
      : const EdgeInsets.symmetric(
      horizontal: 20, vertical: 40),
  child: Container(
    //  color: Colors.red,
    color: dark(context) ? Colors.black : Colors.white,
    height: 170,
    width: getWidth(context),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(),
        SizedBox(
          //width:462,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 70,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey)),
                      child: ListTile(
                        trailing:  InkWell(
                          onTap: ()=>navigateTo(context,  SearchWidget(),),
                          child: Icon(IconBroken.Search,color: dark(context)?Colors.white:Colors.black,),
                        ),


                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

Widget buildNotificationItem(context,ReservationData model) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child:Card(
      elevation: 3.0,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.grey.withOpacity(.8),
        width: getWidth(context),
        height: 74.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(context, text: 'Reservation demand of ${model.id_classroom} Classroom',upperCase: false,color: Colors.black),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                customTextButton(color: Colors.white,text: 'Accept',onPressed: (){
                  ReservationCubit.get(context).updateReservationForAdmin(id: model.id, context: context, time: model.time!, date: model.date!, goal: model.goal!, id_user: model.id_user, etat: 'accepted',);
                }),
                customTextButton(color: Colors.red,text: 'Refuse',onPressed: (){
                  ReservationCubit.get(context).deleteReservation(model.id, context);
                }),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

void launchUrl(url) async {
  var urllaunchable =
  await canLaunch(url); //canLaunch is from url_launcher package
  if (urllaunchable) {
    await launch(url); //launch is from url_launcher package to launch URL
  } else {
    print("URL can't be launched.");
  }
}

Widget socialMedia(String asset,url)=>InkWell(
onTap: (){launchUrl(url);},
child: Container(
padding: const EdgeInsets.all(5),
alignment: AlignmentDirectional.center,
width: 30,
height: 30,
color: Colors.green,
child: Image.asset(
asset,
)),
);

sendEmail(String toMailId, String subject) async {
  var url = 'mailto:$toMailId?subject=$subject';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


