import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:islamicapp/mainpage/add_qari_feed.dart';
import 'package:islamicapp/mainpage/widgets/qari_feed.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  String? search;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/back.png",
                ),
                fit: BoxFit.cover)),
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Nearest Mosque',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(120),
                      ),
                      fillColor: const Color(0xcc000000),
                      filled: true,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: const Color(0xff3F48CC)),
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(top: 20, left: 20),
                      hintText: 'Search nearest mosque',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gilroy',
                      ),
                    ),
                    onChanged: (text) {
                      setState(() {
                        search = text;
                      });
                    },
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20, left: 20),
                    child: const Text(
                      'Find Mosque',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Gilroy',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: FutureBuilder(
                      future: search == null
                          ? FirebaseFirestore.instance
                              .collection('QariMosqueFeed')
                              .get()
                          : FirebaseFirestore.instance
                              .collection('QariMosqueFeed')
                              .where('mosqueName',
                                  isGreaterThanOrEqualTo: search)
                              .get(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return index == null
                                ? const Text('Data is Not Laded')
                                : QariFeed(
                                    snap: snapshot.data!.docs[index].data(),
                                  );
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFFE57373),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddQariFeed(),
          ),
        ),
      ),
    );
  }
}

// Row(
//   children: [
//     Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         controller: _searchController,
//         decoration: const InputDecoration(
//           hintText: 'Please Search',
//           border: OutlineInputBorder(),
//         ),
//       ),
//     ),
//     IconButton(
//         onPressed: () => setState(() {
//               search = _searchController.text;
//             }),
//         icon: const Icon(Icons.search))
//   ],
// ),
// SizedBox(
//   height: MediaQuery.of(context).size.height * 0.03,
// ),
