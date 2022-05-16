import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:islamicapp/authentications/providers/models/dua_model.dart';
import 'package:islamicapp/authentications/providers/models/quran_audio_model.dart';
import 'package:islamicapp/authentications/providers/models/quran_text_asad_model.dart';
import 'package:islamicapp/authentications/providers/models/quran_text_model.dart';
import 'package:islamicapp/authentications/providers/models/test_model.dart';
import 'package:islamicapp/constants/url_links.dart';
import 'package:islamicapp/services/location_methods.dart';
import '../authentications/providers/models/qari_.dart';
import '../models/prayertimemodel.dart';
import '../../../authentications/providers/models/surah_.dart' as surah;

class ApiCalls {
//   Future<PrayerTimeModel>prayerTimes(double latitude,double longitude,String timestamp)async{
//     print(latitude);
//     print(longitude);
//     print(timestamp);
//     var url=Uri.parse("https://api.aladhan.com/v1/timings/${timestamp}?latitude=${latitude.toString()}&longitude=${longitude.toString()}&method=2");
//     var response=await Dio(). get(url);
// print(response.body);

//       return PrayerTimeModel.fromJson(jsonDecode(response.body));

//   }

  var client = http.Client();

//Internal JSON String used
  // Future<DuaModel> getDua() async {
  //   var dua = null;

  //   var myDataString = utf8.decode(duasVar.toString());

  //   var jsonMap = json.decode(myDataString);

  //   dua = DuaModel.fromJson(jsonMap);

  //   // try {
  //   //   var jsonMap = json.decode(duasVar.toString());

  //   //   dua = DuaModel.fromJson(jsonMap);
  //   // } catch (exception) {
  //   //   print(exception);
  //   //   return dua;
  //   // }

  //   return dua;
  // }

  Future<QuranModel> getQuranText() async {
    var response = await client.get(Uri.parse(Strings.quranTextUthmaniUrl));
    var quranText = null;

    try {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        quranText = QuranModel.fromJson(jsonMap);
      }
    } catch (exception) {
      print(exception);
      return quranText;
    }

    return quranText;
  }

  Future<QuranEditionModel> getTestCall() async {
    var response =
        await client.get(Uri.parse('http://api.alquran.cloud/v1/edition'));
    var quranText = null;

    try {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        quranText = QuranEditionModel.fromJson(jsonMap);
      }
    } catch (exception) {
      print(exception);
      return quranText;
    }

    return quranText;
  }

  Future<QuranTextAsad> getQuranTextAsad() async {
    var response = await client.get(Uri.parse(Strings.quranTextAsadUrl));
    print(response.body);
    var quranText;

    var jsonString = response.body;
    var jsonMap = json.decode(jsonString);

    quranText = QuranTextAsad.fromJson(jsonMap);
    print("Call Success: " + quranText);
    // try {
    //   if (response.statusCode == 200) {}
    // } catch (exception) {
    //   print("Call Failed: " + quranText);
    //   return quranText;
    // }

    return quranText;
  }

  Future<QuranAudio> getQuranAudio() async {
    var response = await client.get(Uri.parse(Strings.quranAudioUrl));
    var quranAudio = null;

    try {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        quranAudio = QuranAudio.fromJson(jsonMap);
      }
    } catch (exception) {
      print(exception);
      return quranAudio;
    }

    return quranAudio;
  }

  Future<PrayerTimeModel> prayerTimebyAddress(String address) async {
    // var url=Uri.parse("https://api.aladhan.com/v1/timingsByAddress?address=$address");
    var response = await http.get(Uri.parse(
        "https://api.aladhan.com/v1/timingsByAddress?address=$address"));
    print(response.body);

    return PrayerTimeModel.fromJson(jsonDecode(response.body));
  }

  Future<PrayerTimeModel> gettiming(String address) async {
    // var url = Uri.parse("https://api.aladhan.com/v1/timingsByAddress?address=$address");

    final response = await http.get(Uri.parse(
        // "http://api.aladhan.com/v1/timings/1398332113?latitude=51.508515&longitude=-0.1254872"));
        "https://api.aladhan.com/v1/timingsByAddress?address=$address"));
    // print("response from api: ${response.body}");

    return PrayerTimeModel.fromJson(jsonDecode(response.body));
  }

  Stream<PrayerTimeModel> gettime(Duration refreshTime) async* {
    var address = await LocationMethods().checkLocationStatus();
    print("found addres: $address");
    while (true) {
      // await Future.delayed(refreshTime);
      yield await gettiming(address!);
    }
  }

  //Shehzad
  List<Qari> qarilist = [];

  Future<List<Qari>> getQariList() async {
    final url = "https://quranicaudio.com/api/qaris";
    final res = await http.get(Uri.parse(url));

    jsonDecode(res.body).forEach((element) {
      if (qarilist.length <
          20) // 20 is not mandatory , you can change it upto 157
        qarilist.add(Qari.fromjson(element));
    });
    qarilist
        .sort((a, b) => a.name!.compareTo(b.name!)); // sort according to A B C
    return qarilist;
  }

  final endPointUrl = "http://api.alquran.cloud/v1/surah";
  List<surah.Surah> list = [];

  Future<List<surah.Surah>> getSurah() async {
    var res = await http.get(Uri.parse(endPointUrl));
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      json['data'].forEach((element) {
        if (list.length < 114) {
          list.add(surah.Surah.fromJson(element));
        }
      });
      print('ol ${list.length}');
      return list;
    } else {
      throw ("Can't get the Surah");
    }
  }
}
