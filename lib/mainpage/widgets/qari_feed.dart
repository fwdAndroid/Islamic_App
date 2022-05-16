import 'package:flutter/material.dart';
import 'package:islamicapp/mainpage/qari_feed_details_page.dart';

class QariFeed extends StatelessWidget {
  var snap;

  QariFeed({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Masijid(
                snap: snap,
              ),
            )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                height: 90,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.network(
                          snap['photoUrl'] ??
                              'https://thumbs.dreamstime.com/b/default-avatar-profile-image-vector-social-media-user-icon-potrait-182347582.jpg',
                          fit: BoxFit.cover,
                          height: 70,
                          width: 100,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          snap['mosqueName'] ?? 'No Mosque Name',
                          style: const TextStyle(
                              fontFamily: 'Gilroy',
                              color: Color(0Xff555555),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              overflow: TextOverflow.fade),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: VerticalDivider(
                          // thickness: 2,
                          color: Colors.grey,
                          width: 5,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.grey,
                          ),
                          Text(
                            snap['location'] ?? 'No Location',
                            style: const TextStyle(
                                fontFamily: 'Gilroy',
                                color: Colors.grey,
                                overflow: TextOverflow.fade),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
