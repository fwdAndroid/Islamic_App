import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamicapp/mainpage/IslamicFeed/views/screens/video_screen.dart';
import 'package:islamicapp/mainpage/myhomepage.dart';
import 'package:islamicapp/mainpage/qibla.dart';
import 'package:islamicapp/mainpage/settings/settings.dart';
import 'package:islamicapp/mainpage/widgets/community.dart';
import 'package:islamicapp/mainpage/widgets/islamfeed.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    MyHomePage(),
    VideoScreen(),
    Community(),
    Settings()
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = MyHomePage(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => Qibla()));
          },
          child:
              Image.asset(
            'assets/group.png',
            height: 120,
            width: 120,
          )),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff321410),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            MyHomePage(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/home.svg',
                          height: 25,
                          width: 25,
                          color: currentTab == 0
                              ? const Color(0xff3f48cc)
                              : const Color(0xff8d8282),
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 10,
                            color: currentTab == 0
                                ? const Color(0xff3f48cc)
                                : const Color(0xff8d8282),
                          ),
                        )
                      ],
                    ),
                  ),

                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = VideoScreen();
                        // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/islam_feed.svg',
                          height: 30,
                          width: 30,
                          color: currentTab == 1
                              ? const Color(0xff3f48cc)
                              : const Color(0xff8d8282),
                        ),
                        Text(
                          'Islamfeed',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 10,
                            color: currentTab == 1
                                ? const Color(0xff3f48cc)
                                : const Color(0xff8d8282),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            const Community(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/community_icon.svg',
                          height: 30,
                          width: 30,
                          color: currentTab == 2
                              ? const Color(0xff3f48cc)
                              : const Color(0xff8d8282),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            'Community',
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 10,
                              color: currentTab == 2
                                  ? Color(0xff3f48cc)
                                  : Color(0xff8d8282),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  ///Create Orders
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            const Settings(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/profile_icon.svg',
                          height: 24,
                          width: 24,
                          color: currentTab == 3
                              ? const Color(0xff3f48cc)
                              : const Color(0xff8d8282),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            'Profile',
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 10,
                              color: currentTab == 3
                                  ? const Color(0xff3f48cc)
                                  : const Color(0xff8d8282),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
