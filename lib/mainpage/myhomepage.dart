import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:islamicapp/mainpage/News/news_screen.dart';
import 'package:islamicapp/mainpage/current_prayer.dart';
import 'package:islamicapp/mainpage/duaandhadith.dart';
import 'package:islamicapp/mainpage/prayertimings.dart';
import 'package:islamicapp/mainpage/qibla.dart';
import 'package:islamicapp/mainpage/qurans/quran.dart';
import 'package:islamicapp/mainpage/radio/radio-session.dart';
import 'package:islamicapp/mainpage/settings/settings.dart';

import '../apicalls/apicall.dart';

import '../models/prayertimemodel.dart';
import '../services/location_methods.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String assetImage1 = "assets/back.svg";
  String? newdata;
  int currentPage = 0;
  final _controller = PageController(initialPage: 0);

  String? _cPrayer;
  var time = TimeOfDay.now();
  bool init = true;

  @override
  void initState() {
    getLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (init == true) {
      setState(() {
        _cPrayer = CurrentPrayer().currentPrayer(time);
        // print(cPrayer);
      });
      init = false;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void getLocation() async {
    await LocationMethods()
        .checkLocationStatus()
        .then((value) => newdata = value);
    setState(() {
      newdata;
    });
  }

  // int _getSize(var size){
  //   if(size.height > )
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (builder) => Settings()));
            },
            child: Container(
              margin: EdgeInsets.only(left: 5, top: 8),
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                  color: Color(0xff441009),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/grid.png',
                  height: 13,
                  width: 13,
                ),
              ),
            )),
        centerTitle: true,
        title: const Text(
          'Next prayer time',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy',
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (builder) => Settings()));
            },
            child: Container(
                margin: const EdgeInsets.only(right: 5, top: 8),
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    color: Color(0xff441009),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.settings)),
          )
        ],
      ),
      // extendBody: true,
      extendBodyBehindAppBar: true,
      // drawer: MyDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  _cPrayer == 'Fajr'
                      ? "assets/fajr_back.png"
                      : _cPrayer == 'Dhuhr'
                          ? "assets/duhr_back.png"
                          : _cPrayer == 'Asar'
                              ? "assets/asr_back.png"
                              : _cPrayer == 'Maghrib'
                                  ? "assets/maghrib_back.png"
                                  : "assets/isha_back.png",
                ),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  // height: 110,
                  child: StreamBuilder<PrayerTimeModel>(
                    stream: ApiCalls().gettime(const Duration(seconds: 0)),
                    builder:
                        (context, AsyncSnapshot<PrayerTimeModel> snapshot) {
                      if (snapshot.hasData) {
                        PrayerTimeModel data = snapshot.data!;
                        return Column(
                          children: [
                            SizedBox(
                              // height: 110,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        newdata.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Gilroy',
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                      // margin: EdgeInsets.only(top: 20),
                                      child: Text(
                                    DateFormat()
                                        .add_jms()
                                        .format(DateTime.now()),
                                    style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Text(
                                    _cPrayer!,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Today',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Gilroy',
                                    ),
                                  ),
                                  Text(
                                    data.data.date.hijri!.month!.number
                                            .toString() +
                                        '  ' +
                                        data.data.date.hijri!.month!.en
                                            .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                          // ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 20),
                //   child: Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Container(
                //           margin: const EdgeInsets.only(top:30,left: 10),
                //           child: Text(
                //             'Today',
                //             style: TextStyle(
                //                 fontFamily: 'Gilroy',
                //                 color: Colors.white,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 18),
                //           ),
                //         ),
                //        Container(
                //                                    margin: const EdgeInsets.only(top:10,left: 10),

                //          child: Text(
                //               '25 Ramadan',
                //               style: TextStyle(
                //                   fontFamily: 'Gilroy',
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.w300,
                //                   fontSize: 12),
                //             ),
                //        ),

                //       ]),
                // ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Categories',
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: PageView(
                      controller: _controller,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Table(
                                children: [
                                  TableRow(children: [
                                    InkWell(
                                      onTap: () {
                                        // Navigator.pushNamed(context , categories[index].route),
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (builder) => Qurans(),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.25),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: SvgPicture.asset(
                                                'assets/qurans.svg',
                                                height: 50,
                                                width: 50,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Quran',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Gilroy',
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    PrayersTimes()));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.25),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: SvgPicture.asset(
                                                'assets/mos.svg',
                                                height: 50,
                                                width: 50,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            'Prayer Times',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Gilroy',
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    RadioSessions()));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.25),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: SvgPicture.asset(
                                                'assets/radio.svg',
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Q/A Radio',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Gilroy',
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ])
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Table(
                                children: [
                                  TableRow(children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    DuaAndHadith()));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.25),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: SvgPicture.asset(
                                                'assets/ram.svg',
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Dua/Hadiths',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Gilroy',
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) => Qibla()));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.25),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: SvgPicture.asset(
                                                'assets/qib.svg',
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Qibla',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Gilroy',
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    Settings()));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.25),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: SvgPicture.asset(
                                                'assets/sett.svg',
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Setting',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Gilroy',
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ])
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceAround,
                              //   children: [

                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Table(
                              children: [
                                TableRow(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (builder) => Settings()));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.25),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Image.asset(
                                                'assets/membership.png',
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Membership',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Gilroy',
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    NewsScreen()));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.25),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child:
                                                  Image.asset('assets/nes.png'),
                                            ),
                                          ),
                                          Text(
                                            'News',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Gilroy',
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (builder) => RadioSessions()));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 70,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text("")),
                                          ),
                                          Text(
                                            '',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Gilroy',
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.05),
                  child: Center(
                    child: DotsIndicator(
                      dotsCount: 2,
                      position: currentPage.toDouble(),
                      decorator: DotsDecorator(
                        color: Colors.grey, // Inactive color
                        activeColor: Color(0xff3F48CC),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
