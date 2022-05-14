import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamicapp/apicalls/apicall.dart';
import 'package:islamicapp/authentications/providers/models/quran_audio_model.dart';
import 'package:islamicapp/authentications/providers/models/quran_text_model.dart';
import 'package:islamicapp/mainpage/qurans/detail_page.dart';
import 'package:islamicapp/mainpage/qurans/sh/audio_surah_screen.dart';
import 'package:islamicapp/mainpage/qurans/sh/qari_custom_tile.dart';

import '../../authentications/providers/models/qari_.dart';

class Qurans extends StatefulWidget {
  const Qurans({Key? key}) : super(key: key);

  @override
  State<Qurans> createState() => _QuransState();
}

class _QuransState extends State<Qurans> {
  late Future<QuranModel> _quranText;
  late Future<QuranAudio> _quranAudio;

  @override
  void initState() {
    _quranText = ApiCalls().getQuranText();
    _quranAudio = ApiCalls().getQuranAudio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiCalls apiServices = ApiCalls();

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0xff45211a),
                    borderRadius: BorderRadius.circular(15)),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          title: const Text(
            'Quran',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent),
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
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                  future: apiServices.getQariList(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Qari>> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Qari\'s data not found '),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return QariCustomTile(
                              qari: snapshot.data![index],
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AudioSurahScreen(
                                            qari: snapshot.data![index])));
                              });
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1,
                  child: FutureBuilder<QuranModel>(
                      future: _quranText,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.data!.surahs!.length,
                              itemBuilder: (BuildContext context, int index) {
                                var surah = snapshot.data!.data!.surahs![index];
                                print(surah);
                                return InkWell(
                                  onTap: () => {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          SuratDetailsPage(snap: surah),
                                    ))
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: const EdgeInsets.only(
                                        left: 16, right: 16, top: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 14),
                                    width:
                                        MediaQuery.of(this.context).size.width,
                                    // height: 100,
                                    child: Row(
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/star.svg",
                                              height: 35,
                                              width: 35,
                                            ),
                                            Text(
                                              "${index + 1}",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 14,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              surah.englishName!,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff555555)),
                                            ),
                                            Text(
                                              surah.revelationType!
                                                      .toString()
                                                      .substring(15) +
                                                  ' • ' +
                                                  surah.ayahs!.length
                                                      .toString() +
                                                  ' Verses',
                                              style: const TextStyle(
                                                  color: Color(0xffAEAEAE),
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// if (snapshot.hasData) {
//                       return Container(
//                         margin: const EdgeInsets.only(top: 20),
//                         height: 150,
//                         child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: snapshot.data!.data!.length,
//                             itemBuilder: ((context, index) {
//                               return Column(
//                                 children: [
//                                   const Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: CircleAvatar(
//                                       radius: 40,
//                                       backgroundImage:
//                                           AssetImage('assets/ellipse.png'),
//                                     ),
//                                   ),
//                                   Text(
//                                     snapshot.data!.data![index].englishName!,
//                                     // 'Res',
//                                     style: const TextStyle(color: Colors.white),
//                                     overflow: TextOverflow.fade,
//                                   ),
//                                 ],
//                               );
//                             })),
//                       );
//                     } else {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
