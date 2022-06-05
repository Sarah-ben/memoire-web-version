import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components.dart';
import '../constants.dart';

class FooterMin extends StatefulWidget {
  const FooterMin({Key? key}) : super(key: key);

  @override
  _FooterMinState createState() => _FooterMinState();
}

class _FooterMinState extends State<FooterMin> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
      color: const Color.fromRGBO(20, 30, 29, 1),
      width: MediaQuery.of(context).size.width,
      height: 700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Image.asset('assets/images/univlogo.png',width: 150,),
          verticalSizedBox(20.0),
          Column(
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
                  onPressed: (){
                    sendEmail('djihane.laadjal@univ-constantine2.dz', 'Contact Developer');
                  },
                  onHover: (hover) {
                    setState(() {
                      isContactus = hover;
                    });
                  },
                  text: 'Contact Us',
                  isHover: isContactus),

              customTextButton(
                  onPressed: (){
                    launchUrl('https://www.freeprivacypolicy.com/live/ff2de365-f95c-4f05-8dc4-b7e18f2b6c71');
                  },
                  onHover: (hover) {
                    setState(() => isPrivacy = hover);
                  },
                  text: 'Privacy policy',
                  isHover: isPrivacy),
            ],
          ),
          Column(
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
                  onPressed: (){
                    launchUrl('https://web.facebook.com/faculteNTICUC2');
                  },
                  onHover: (Hover) {
                    setState(() {
                      isFacebook = Hover;
                    });
                  },
                  text: 'Facebook',
                  isHover: isFacebook),
              customTextButton(
                  onPressed: (){
                    launchUrl('https://twitter.com/fac_ntic_UC2');
                  },
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
                      isLnkedIn = Hover;
                    });
                  },
                  text: '031783173',
                  isHover: isLnkedIn),
              customTextButton(
                  onPressed: (){
                    sendEmail('fac.ntic@univ-constantine2.dz', '');
                  },
                  onHover: (Hover) {
                    setState(() {
                      isEmail = Hover;
                    });
                  },
                  text: 'Email',
                  isHover: isEmail),
            ],
          ),
           Spacer(),
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
/*
Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: double.infinity,
            height: 509,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(width: 40.0,),
                Column(
                  children: [
                    const Text(
                      'Get in touch',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 4),
                    ),
                    customTextButton(
                        onHover: (hover) {
                          setState(() {
                            isAboutUs = hover;
                          });
                        },
                        text: 'About Us',
                        isHover: isAboutUs),
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
                          setState(() {
                            isMaps = hover;
                          });
                        },
                        text: 'Maps & Directions',
                        isHover: isMaps),
                  ],
                ),
                const SizedBox(
                  width: 30.0,
                ),
                const VerticalDivider(
                  color: Colors.white,
                  indent: 10.0,
                  endIndent: 10.0,
                ),
                const SizedBox(
                  width: 30.0,
                ),
                Column(
                  children: [
                    const Text(
                      'Website',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 4),
                    ),
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
                    customTextButton(
                        onHover: (hover) {
                          setState(
                                  () => isTermAndCondition = hover);
                        },
                        text: 'Term of service',
                        isHover: isTermAndCondition),
                  ],
                ),
                const SizedBox(
                  width: 30.0,
                ),
                const VerticalDivider(
                  color: Colors.white,
                  indent: 10.0,
                  endIndent: 10.0,
                ),
                const SizedBox(
                  width: 30.0,
                ),
                Column(
                  children: [
                    const Text(
                      'Resources',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 4),
                    ),
                    customTextButton(
                        onHover: (hover) {
                          setState(() => isElearning = hover);
                        },
                        text: 'E-learning',
                        isHover: isElearning),
                    customTextButton(
                        onHover: (hover) {
                          setState(() => isCalendar = hover);
                        },
                        text: 'Academic calendar',
                        isHover: isCalendar),
                    customTextButton(
                        onHover: (hover) {
                          setState(() => isEvent = hover);
                        },
                        text: 'Events',
                        isHover: isEvent),
                  ],
                ),
                // SizedBox(width: 40.0,),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
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
                const SizedBox(height: 20.0,),
                const Text(
                  '© 2022 The President and Fellows of Abdelhamid MEHRI College',
                  style: TextStyle(
                      fontSize: 13.0, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
 */
