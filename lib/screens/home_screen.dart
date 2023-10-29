import 'package:alan_voice/alan_voice.dart';
import 'package:beats/main.dart';
import 'package:beats/models/music.dart';
import 'package:beats/screens/radio_screen.dart';
import 'package:beats/screens/yourlibrary_screen.dart';
import 'package:beats/services/category_operations.dart';
import 'package:beats/models/category.dart ';
import 'package:beats/services/music_operations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

Music? music;
Music? globalmusic;
List<Music> musicListglobal = MusicOperations.getMusic();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    setupAlan();
  }

  setupAlan() {
    AlanVoice.addButton(
        "fed8c2f3aa3392a890b7f93123b6321b2e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);
    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

  int ctr = 0;
  _handleCommand(Map<String, dynamic> response) async {
    switch (response["command"]) {
      case "play":
        await radioPlayer.setChannel(
            title: musicListglobal[ctr].name,
            url: musicListglobal[ctr].audioURL,
            imagePath: musicListglobal[ctr].image);
        await radioPlayer.play();
        //widget._miniPlayer(musicListglobal[0], stop: true);
        break;
      case "pause":
        await radioPlayer.pause();
        break;
      case "next":
        ctr++;
        if (ctr <= 52) {
          await radioPlayer.setChannel(
              title: musicListglobal[ctr].name,
              url: musicListglobal[ctr].audioURL,
              imagePath: musicListglobal[ctr].image);
          await radioPlayer.play();
        }
        break;
      case "previous":
        ctr--;
        if (ctr > 0) {
          await radioPlayer.setChannel(
              title: musicListglobal[ctr].name,
              url: musicListglobal[ctr].audioURL,
              imagePath: musicListglobal[ctr].image);
          await radioPlayer.play();
        }
        break;
      case "dharia":
        await radioPlayer.setChannel(
            title: musicListglobal[1].name,
            url: musicListglobal[1].audioURL,
            imagePath: musicListglobal[1].image);
        await radioPlayer.play();
        break;
      case "play_music":
        final no = response["id"];
        await radioPlayer.pause();
        await radioPlayer.setChannel(
            title: musicListglobal[no].name,
            url: musicListglobal[no].audioURL,
            imagePath: musicListglobal[no].image);
        await radioPlayer.play();
        break;
      default:
    }
  }

  Widget createCategory(Category category) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromARGB(255, 15, 32, 40).withOpacity(0.8),
      ),
      child: InkWell(
        onTap: (() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Search()));
        }),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                category.imageURL,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              category.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ]),
      ),
    );
  }

// single column of music that is card
  Widget createMusic(Music music) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent, width: 0)),
            height: 180,
            width: 180,
            // inkwell makes images clickable like buttons
            child: InkWell(
              onTap: () {
                globalmusic = music;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MusicPlayingView()),
                );
                // widget._miniPlayer(music, stop: true);
              },
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  music.image,
                  // fit: BoxFit.cover,
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          Text(
            music.name,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            music.desc,
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget createMusicList(String label, int flag) {
    List<Music> musicList = MusicOperations.getMusic();

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                int reverseindex = musicList.length - 1 - index;
                if (flag == 0) {
                  return createMusic(musicList[index]);
                } else {
                  return createMusic(musicList[reverseindex]);
                }
              },
              itemCount: musicList.length,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> createListOfCategories() {
    List<Category> categoryList = <Category>[
      Category('Top songs',
          'https://is4-ssl.mzstatic.com/image/thumb/Purple122/v4/f5/1e/85/f51e856c-52c9-a109-44c2-acf22f742643/AppIcon-1x_U007emarketing-0-7-0-sRGB-85-220.png/256x256bb.jpg'),
      Category('Hip Hop',
          'https://img.freepik.com/premium-vector/street-style-black-white-print-with-big-boombox-hip-hop-rap-music-type_185390-358.jpg'),
      Category('Romantic',
          'https://us.123rf.com/450wm/ukususha/ukususha1601/ukususha160100137/51613528-treble-clef-of-hearts-romantic-music-symbol.jpg'),
      Category('Jazz songs',
          'https://is3-ssl.mzstatic.com/image/thumb/Purple3/v4/88/1a/9b/881a9b3d-e662-51a6-8d04-da7292fc3814/source/256x256bb.jpg'),
      Category('Classic',
          'https://www.cmuse.org/wp-content/uploads/2020/11/What-Makes-Classical-Music-Classical.jpg'),
      Category('Rock Music',
          'https://i.pinimg.com/originals/ac/9d/1d/ac9d1d9f22ebd188737dc9714311efbf.jpg'),
      Category("90's hits",
          'https://www.musicgrotto.com/wp-content/uploads/2021/10/90s-music-cassette-tapes-records-graphic-art.jpg'),
      Category('Folk',
          'https://previews.123rf.com/images/seamartini/seamartini1611/seamartini161100193/66208449-folk-music-heart-emblem-of-musical-instruments-music-label-with-pattern-of-music-folk-instruments-vi.jpg'),
    ]; // recieved data
    // converted data to widget using map func
    List<Widget> categories = categoryList
        .map((Category category) => createCategory(category))
        .toList();
    return categories;
  }

  Widget createGrid() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 220,
        child: GridView.count(
          childAspectRatio: 6 / 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          crossAxisCount: 2,
          children: createListOfCategories(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  // margin: const EdgeInsets.only(right: 20),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(

                        //'https://www.woolha.com/media/2020/03/eevee.png'
                        // 'https://cdn-icons-png.flaticon.com/512/195/195123.png'
                        "https://pbs.twimg.com/profile_images/840950881025708032/1k6km0os_400x400.jpg"),
                    radius: 15,
                  ),

                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.logout_sharp,
                        size: 35,
                      ),
                      onPressed: () async {
                        // await  Firebase.auth().signOut;
                        await Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const Loginbase()));
                      },
                    ),
                  ],
                ),
              ),
              /* const SizedBox(
            height: 2,
          ),*/
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: const Text(
                  "Groom with Beats",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold),
                ),
              ),
              createGrid(),
              SizedBox(
                height: 13,
              ),
              createMusicList('Music for you', 0),
              createMusicList('Popular', 1)
            ]),
      ),
    );
  }
}

int isplaying = 0;

class MusicPlayingView extends StatefulWidget {
  const MusicPlayingView({super.key});

  @override
  State<MusicPlayingView> createState() => _MusicPlayingViewState();
}

class _MusicPlayingViewState extends State<MusicPlayingView> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blueGrey.shade900.withOpacity(0.8),
            Colors.blueGrey.shade600.withOpacity(0.5),
          ],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text("Stay Tuned"),
            elevation: 0,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 75, right: 75, top: 0),
                child: CircleAvatar(
                  radius: 130,
                  backgroundImage: NetworkImage(
                    globalmusic!.image,
                    // fit: BoxFit.cover,
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50, right: 50, top: 25, bottom: 25),
                child: Text(
                  globalmusic!.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 140,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 56),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () async {
                          if (isplaying == 0) {
                            currentplayingid = globalmusic!.id;
                            globalmusic = musicListglobal[currentplayingid - 2];

                            setState(() {});
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MusicPlayingView()));
                          }
                        },
                        icon: Icon(
                          Icons.skip_previous_rounded,
                          size: 67,
                          color: Colors.blueGrey.shade200,
                        )),
                    IconButton(
                      onPressed: () async {
                        if (isplaying == 0) {
                          await radioPlayer.setChannel(
                              title: globalmusic!.name,
                              url: globalmusic!.audioURL,
                              imagePath: globalmusic!.image);
                          await radioPlayer.play();
                          isplaying = 1;
                          currentplayingid = globalmusic!.id;
                        } else {
                          await radioPlayer.pause();
                          isplaying = 0;
                        }
                        setState(() {});
                      },
                      icon: isplaying == 0
                          ? Icon(
                              Icons.play_circle_fill_rounded,
                              size: 75,
                              color: Colors.blueGrey.shade200,
                            )
                          : Icon(
                              Icons.pause_circle_filled_rounded,
                              size: 75,
                              color: Colors.blueGrey.shade200,
                            ),
                    ),
                    IconButton(
                        onPressed: () async {
                          if (isplaying == 0) {
                            globalmusic = musicListglobal[currentplayingid];
                            currentplayingid = globalmusic!.id;
                            setState(() {});
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MusicPlayingView()));
                          }
                        },
                        icon: Icon(
                          Icons.skip_next_rounded,
                          size: 67,
                          color: Colors.blueGrey.shade200,
                        ))
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.grey.shade900.withOpacity(0.8),
              unselectedItemColor: Colors.blueGrey.shade200,
              selectedItemColor: Colors.blueGrey.shade200,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: InkWell(
                    child: const Icon(Icons.home),
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/myapp',
                        ((route) => false),
                      );
                    },
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: InkWell(
                    child: const Icon(Icons.radio),
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/radioscreen',
                        ((route) => false),
                      );
                    },
                  ),
                  label: 'radio',
                ),
              ]),
        ),
      ),
    );
  }
}

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  void updateList(String value) {
    setState(() {
      musicListglobal = MusicOperations.getMusic()
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blueGrey.shade900.withOpacity(0.8),
            Colors.blueGrey.shade600.withOpacity(0.5),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Search for a song",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) => updateList(value),
                style: TextStyle(color: Colors.blueGrey.shade900),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "eg: cheap thrills",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blueGrey.shade900,
                  ),
                  prefixIconColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: musicListglobal.length,
                    itemBuilder: (context, index) => InkWell(
                          onTap: (() {
                            globalmusic = musicListglobal[index];
                            setState(() {});
                            print(globalmusic!.name);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MusicPlayingView()),
                            );
                          }),
                          child: ListTile(
                            title: Text(
                              musicListglobal[index].name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: Padding(
                              padding: const EdgeInsets.all(3),
                              child:
                                  Image.network(musicListglobal[index].image),
                            ),
                          ),
                        )),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        // appBar:,
      ),
    );
  }
}
