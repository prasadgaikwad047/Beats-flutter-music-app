import 'package:beats/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../models/category.dart ';

String god = '';
List globalplaylist = [];
List playlist1 = [2, 3, 6, 10, 12, 14, 18, 22];
List playlist2 = [5, 6, 8, 10, 22, 24, 25, 26, 27];
List playlist3 = [40, 41, 42, 43, 46, 47, 48];
List playlist4 = [24, 27, 29, 35, 38, 39, 44, 48];
List playlist5 = [45, 46, 47, 48, 49, 50, 51];
List playlist6 = [10, 15, 20, 25, 30, 35, 40, 45, 50];
List playlist7 = [11, 12, 13, 14, 15, 16, 17];
List playlist8 = [21, 23, 25, 26, 32, 34, 36, 39];

class YourLibrary extends StatefulWidget {
  const YourLibrary({super.key});

  @override
  State<YourLibrary> createState() => _YourLibraryState();
}

class _YourLibraryState extends State<YourLibrary> {
  @override
  void initState() {
    super.initState();
  }

  Widget createGrid() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 600,
        child: GridView.count(
          childAspectRatio: 6 / 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          crossAxisCount: 1,
          children: createListOfCategories(),
        ),
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

  Widget createCategory(Category category) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromARGB(255, 15, 32, 40).withOpacity(0.8),
      ),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const playlistScreen()),
              );
              setState(() {
                switch (category.name) {
                  case 'Top songs':
                    god = 'Top songs';
                    globalplaylist = [];
                    globalplaylist = playlist1;
                    break;
                  case 'Hip Hop':
                    god = 'Hip Hop';
                    globalplaylist = [];
                    globalplaylist = playlist2;
                    break;
                  case 'Romantic':
                    god = 'Romantic';
                    globalplaylist = [];
                    globalplaylist = playlist3;
                    break;
                  case 'Jazz songs':
                    god = 'Jazz songs';
                    globalplaylist = [];
                    globalplaylist = playlist4;
                    break;
                  case 'Classic':
                    god = 'Classic';
                    globalplaylist = [];
                    globalplaylist = playlist5;
                    break;
                  case 'Rock Music':
                    god = 'Rock Music';
                    globalplaylist = [];
                    globalplaylist = playlist6;
                    break;
                  case "90's hits":
                    god = "90's hits";
                    globalplaylist = [];
                    globalplaylist = playlist7;
                    break;
                  case 'Folk':
                    god = 'Folk';
                    globalplaylist = [];
                    globalplaylist = playlist8;
                    break;
                }
              });
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
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  category.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          );
        },
        itemCount: 1,
      ),
    );
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
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              const Text(
                "Playlist's for you..",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              createGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomNavBar extends StatelessWidget {
  const _CustomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.deepPurple.shade800.withOpacity(0.8),
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favourites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_outline),
          label: 'Play',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}

class playlistScreen extends StatefulWidget {
  const playlistScreen({super.key});

  @override
  State<playlistScreen> createState() => _playlistScreenState();
}

class _playlistScreenState extends State<playlistScreen> {
  int ctr = 0;
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
          body: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                god,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: globalplaylist[globalplaylist.length - 1],
                    itemBuilder: (context, index) {
                      if (index >= 0 && index < musicListglobal.length) {
                        if (index == globalplaylist[ctr] - 1) {
                          ctr++;
                          print(index);

                          return InkWell(
                            onTap: (() {
                              globalmusic = musicListglobal[index];
                              setState(() {
                                ctr = 0;
                              });
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
                          );
                        } else {
                          return const Offstage();
                        }
                      } else {
                        return const Offstage();
                      }
                    }),
              ),
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
                    child: const Icon(Icons.library_books),
                    onTap: () {
                      Navigator.pop(context);
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
