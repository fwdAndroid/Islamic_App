import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamicapp/mainpage/Duas/duas.dart';
import 'package:islamicapp/mainpage/Duas/hadith.dart';

class DuaAndHadith extends StatefulWidget {
  const DuaAndHadith({Key? key}) : super(key: key);

  @override
  State<DuaAndHadith> createState() => _DuaAndHadithState();
}

class _DuaAndHadithState extends State<DuaAndHadith> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 5, top: 8),
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                  color: const Color(0xff441009),
                  borderRadius: BorderRadius.circular(10)),
              child: const Padding(
                  padding: EdgeInsets.all(8.0), child: Icon(Icons.arrow_back)),
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Text(
              'Dua\'s/Hadiths',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/back.png",
                  ),
                  fit: BoxFit.cover)),
          child: Container(
            margin: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => const Duas()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: const Color(0xff3F48CC),
                                    borderRadius: BorderRadius.circular(20)),
                                margin: const EdgeInsets.all(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SvgPicture.asset(
                                    'assets/ram.svg',
                                    width: 100,
                                  ),
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Dua',
                                  style: TextStyle(
                                      // color: Color(0xff555555),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8,),
                                Text(
                                  'Click here to view list of dua\'s',
                                  style: TextStyle(
                                      // color: Color(0xff555555),
                                      fontSize: 13,),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => const Hadiths()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: const Color(0xff3F48CC),
                                    borderRadius: BorderRadius.circular(20)),
                                margin: const EdgeInsets.all(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SvgPicture.asset(
                                    'assets/qurans.svg',
                                    width: 100,
                                  ),
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Hadiths',
                                  style: TextStyle(
                                    // color: Color(0xff555555),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8,),
                                Text(
                                  'Click here to view list of Hadiths',
                                  style: TextStyle(
                                    // color: Color(0xff555555),
                                    fontSize: 13,),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
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
