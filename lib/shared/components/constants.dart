import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cubit/app_cubit.dart';
import '../network/cache_helper.dart';
bool isContactus = false;
bool isMaps = false;
bool isAboutUs = false;
bool isAccessible = false;
bool isTermAndCondition = false;
bool isPrivacy = false;
bool isFacebook = false;
bool isTwitter = false;
bool isInstagram = false;
bool isYoutube = false;
bool isLnkedIn = false;
bool isCalendar = false;
bool isEvent = false;
bool isElearning = false;
bool isEvents = false;
bool isReadMore = false;
bool isHover=false;
bool isEdit=false;
bool isDelete=false;
 getWidth(context)=> MediaQuery.of(context).size.width;
 getHeight(context)=> MediaQuery.of(context).size.height;
 dark(context)=> AppCubit.get(context).isDark;
 var isAdmin=CacheHelper.getData(key: 'role')=='admin';
TextEditingController emailController=TextEditingController();
TextEditingController firstNameController=TextEditingController();
TextEditingController lastNameController=TextEditingController();
TextEditingController phoneController=TextEditingController();
TextEditingController gradeController=TextEditingController();
TextEditingController placeController=TextEditingController();
TextEditingController passwordController=TextEditingController();
GlobalKey<FormState> formKey=GlobalKey();
var emailVerifier=RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
var reservationTime=TextEditingController();
var reservationDate=TextEditingController();
var reservationGoal=TextEditingController();

bool isEmail = false;
bool isLogOut = false;
bool positive = false;



