import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamicapp/mainpage/IslamicFeed/views/screens/add_video_screen.dart';
import 'package:islamicapp/mainpage/IslamicFeed/views/screens/profile_screen.dart';
import '../../constants.dart';
import '../../controllers/video_controller.dart';
import '../../views/screens/comment_screen.dart';
import '../../views/widgets/circle_animation.dart';
import '../../views/widgets/video_player_iten.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final VideoController videoController = Get.put(VideoController());

  buildProfile(String profilePhoto, String uid, BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProfileScreen(uid: uid),
        )),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image(
            image: NetworkImage(profilePhoto),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  buildMusicAlbum(String profilePhoto, BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const AddVideoScreen();
              },
            ));
          },
          child: Container(
              padding: const EdgeInsets.all(11),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: const Color(0Xff8F2C2C),
                  borderRadius: BorderRadius.circular(25)),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController _searchController = TextEditingController();
    String search;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromRGBO(22, 22, 22, .2)),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Following',
                style: TextStyle(fontSize: 18, color: Color(0xff9D9D9D)),
              ),
              Container(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 2,
                height: 20,
              ),
              // Text('WorldWide',
              //     style: TextStyle(color: Colors.white, fontSize: 18))
              const Text(
                'Worldwide',
                style: TextStyle(fontSize: 18, color: Color(0xffffffff)),
              ),
            ],
          ),
        ),
        // actions: [
        //   Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     height: 48,
        //     width: 48,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(12),
        //       color: Color.fromRGBO(22, 22, 22, .2)
        //     ),
        //     child: Icon(Icons.menu,color: Colors.white,),
        //   ),
        // ),
        // ],
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.black,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(120),
                            ),
                            fillColor: Colors.grey,
                            filled: true,
                            // suffixIcon: Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Container(
                            //     width: 44,
                            //     height: 44,
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(40),
                            //         color: Color(0xff3F48CC)),
                            //     child: IconButton(
                            //       icon: Icon(Icons.search),
                            //       onPressed: () => {},
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // ),
                            contentPadding:
                                const EdgeInsets.only(top: 20, left: 20),
                            hintText: 'Please Search',
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
                      const Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),

                        // child: Container(
                        //   width: 44,
                        //   height: 44,
                        //   decoration: BoxDecoration(
                        //       color: Colors.grey,
                        //       borderRadius: BorderRadius.circular(110)),
                        //   child: IconButton(
                        //       onPressed: () {},
                        //       icon: Icon(
                        //         Icons.close,
                        //         color: Colors.white,
                        //       )),
                        // ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: ListTile(
                      leading: SvgPicture.asset(
                        'assets/icon.svg',
                        width: 25,
                        height: 25,
                      ),
                      title: const Text(
                        "Home",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ListTile(
                      leading: Image.asset('assets/p.png'),
                      title: const Text(
                        "Posts",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const ListTile(
                      leading: Icon(Icons.email, color: Colors.white),
                      title: Text(
                        "Inbox",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ListTile(
                      leading: Image.asset('assets/pp.png'),
                      title: const Text(
                        "Profile",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ListTile(
                      leading: Image.asset(
                        'assets/radioss.png',
                        height: 25,
                        width: 25,
                      ),
                      title: const Text(
                        "Following",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ListTile(
                      leading: Image.asset(
                        'assets/world.png',
                        height: 25,
                        width: 25,
                      ),
                      title: const Text(
                        "Worldwide",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Obx(() {
        return PageView.builder(
          // itemCount: 10,
          itemCount: videoController.videoList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = videoController.videoList[index];
            return Stack(
              children: [
                VideoPlayerItem(
                  videoUrl: data.videoUrl,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      buildProfile(
                                          data.profilePhoto, data.uid, context),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        data.username,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:8.0),
                                    child: Text(
                                      data.caption,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.music_note,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        data.songName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8,),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            // width: 100,
                            margin: const EdgeInsets.only(right: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // buildProfile(
                                //     data.profilePhoto, data.uid, context),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          videoController.likeVideo(data.id),
                                      child: Icon(
                                        data.likes.contains(
                                                firebaseAuth.currentUser!.uid)
                                            ? Icons.favorite
                                            : Icons.favorite_outline_outlined,
                                        size: 40,
                                        color: data.likes.contains(
                                                firebaseAuth.currentUser!.uid)
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      data.likes.length.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                        onTap: () => Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CommentScreen(
                                                  id: data.id,
                                                ),
                                              ),
                                            ),
                                        child: SvgPicture.asset(
                                          'assets/message.svg',
                                          height: 24,
                                          width: 24,
                                        )),
                                    const SizedBox(height: 3),
                                    Text(
                                      data.commentCount.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/share.svg',
                                      height: 24,
                                      width: 24,
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      data.shareCount.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                buildMusicAlbum(data.profilePhoto, context),
                                const SizedBox(
                                  height: 8,
                                ),
                                // CircleAnimation(
                                //   child: buildMusicAlbum(
                                //       data.profilePhoto, context),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
