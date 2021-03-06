import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:islamicapp/mainpage/add_qari_feed.dart';
import 'package:islamicapp/mainpage/widgets/qari_feed.dart';

class IslamFeed extends StatefulWidget {
  const IslamFeed({Key? key}) : super(key: key);

  @override
  State<IslamFeed> createState() => _IslamFeedState();
}

class _IslamFeedState extends State<IslamFeed> {
  String? search;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        backgroundColor: new Color(0xFFE57373),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddQariFeed(),
          ))),
        
      
    

      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/back.png',),fit: BoxFit.cover),
        
      ),
      child: Column(
        children: [
          FutureBuilder(
                future: search == null
                    ? FirebaseFirestore.instance
                        .collection('QariMosqueFeed')
                        .get()
                    : FirebaseFirestore.instance
                        .collection('QariMosqueFeed')
                        .where('mosqueName', isGreaterThanOrEqualTo: search)
                        .get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return QariFeed(
                        snap: snapshot.data!.docs[index].data(),
                      );
                    },
                  );
                }),
                
          ],
        ),
      
        
      ),
      
    );
    
  }
}
