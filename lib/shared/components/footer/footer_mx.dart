import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components.dart';
import '../constants.dart';

class footer extends StatefulWidget {
  const footer({Key? key}) : super(key: key);

  @override
  _footerState createState() => _footerState();
}

class _footerState extends State<footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
      color: const Color.fromRGBO(20, 30, 29, 1),
      width: MediaQuery.of(context).size.width,
      height: 314.0,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 238.0,
                  alignment: AlignmentDirectional.center,
                  child:Row(
                    children: [
                      Image.asset('assets/images/univlogo.png',width: 170.0,),
                      const SizedBox(width: 20.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('University Constantine 2 - UC2\nAbdelhamid MEHRI University\nNew Technologies Departement\nNouvelle ville -Constntine',style: TextStyle(fontSize: 16.0,color: Colors.white,height: 1.4,fontWeight: FontWeight.normal),),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              const Icon(Icons.link,color: Colors.white,),
                              customTextButton(
                                  onHover: (hover) {
                                    setState(() => isElearning = hover);
                                  },
                                  text: 'www.elearing.com',
                                  isHover: isElearning),
                            ],
                          )

                        ],
                      ),
                    ],
                  )
              ),
             const Spacer(),
              SizedBox(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Helpful links',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 4),
                    ),
                    const Divider(thickness: 2,color: Colors.white,),
                    verticalSizedBox(10.0),
                    customTextButton(
                        onHover: (hover) {
                          setState(() {
                            isContactus = hover;
                          });
                        },
                        text: 'Contact Us',
                        isHover: isContactus),
                    customTextButton(
                        onHover: (hover) {
                          setState(() => isAccessible = hover);
                        },
                        text: 'Accessibility',
                        isHover: isAccessible),
                    customTextButton(
                        onHover: (hover) {
                          setState(() => isPrivacy = hover);
                        },
                        text: 'Privacy policy',
                        isHover: isPrivacy),
                  ],
                ),
              ),
              const SizedBox(width: 50.0,),
              SizedBox(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Social links',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 4),
                    ),
                    const Divider(thickness: 2,color: Colors.white,),
                    verticalSizedBox(10.0),
                    customTextButton(
                        onHover: (Hover) {
                          setState(() {
                            isFacebook = Hover;
                          });
                        },
                        text: 'Facebook',
                        isHover: isFacebook),
                    customTextButton(
                        onHover: (Hover) {
                          setState(() {
                            isTwitter = Hover;
                          });
                        },
                        text: 'Twitter',
                        isHover: isTwitter),
                    customTextButton(
                        onHover: (Hover) {
                          setState(() {
                            isInstagram = Hover;
                          });
                        },
                        text: 'Instagram',
                        isHover: isInstagram),
                    customTextButton(
                        onHover: (Hover) {
                          setState(() {
                            isYoutube = Hover;
                          });
                        },
                        text: 'Youtube',
                        isHover: isYoutube),
                    customTextButton(
                        onHover: (Hover) {
                          setState(() {
                            isLnkedIn = Hover;
                          });
                        },
                        text: 'LinkedIn',
                        isHover: isLnkedIn),
                  ],
                ),
              ),
              const SizedBox(width: 50,),
            ],
          ),
          Container(
            alignment: AlignmentDirectional.center,
            child:const Text(
              '© 2022 The President and Fellows of Abdelhamid MEHRI College',
              style: TextStyle(
                  fontSize: 13.0, color: Colors.grey),
            ),
          ),

        ],
      ),
    );
  }
}
