import 'package:beats/models/radio.dart';
import 'package:beats/screens/home_screen.dart';
import 'package:beats/services/radio_operations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:radio_player/radio_player.dart';
import 'package:beats/screens/app.dart';

RadioPlayer radioPlayer = RadioPlayer();
//RadioFunction? radiomusic;
RadioFunction? globalradio;
int currentplayingid = 0;

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});

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
          appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  "Enjoy with Radio..",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              createRadioList('')
            ],
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}

Widget createRadioList(String label) {
  List radioList = RadioOperations.getRadio();
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
        Container(
          height: 630,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return InkWell(
                child: createRadio(radioList[index]),
                onTap: () {
                  globalradio = radioList[index];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const radioplayingview()),
                  );
                },
              );
            },
            itemCount: radioList.length,
          ),
        ),
      ],
    ),
  );
}

@override
int flag = 0;
Widget createRadio(RadioFunction music) {
  return Padding(
    padding: const EdgeInsets.only(left: 5, right: 20, top: 5, bottom: 5),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromARGB(255, 15, 32, 40).withOpacity(0.8),
      ),
      height: 60,
      width: 65,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              // radius: 20,
              backgroundImage: NetworkImage(
                music.image,
                // fit: BoxFit.cover,
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 18, bottom: 15),
            child: Text(
              music.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    ),
  );
}

class radioplayingview extends StatefulWidget {
  const radioplayingview({super.key});

  @override
  State<radioplayingview> createState() => _radioplayingviewState();
}

class _radioplayingviewState extends State<radioplayingview> {
  @override
  void initState() {
    super.initState();
  }

  List radioList = RadioOperations.getRadio();
  int isplaying = 0;

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
            title: const Text(
              "Vibe with FM",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
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
                    globalradio!.image,
                    // fit: BoxFit.cover,
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50, right: 50, top: 25, bottom: 25),
                child: Text(
                  globalradio!.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
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
                            currentplayingid = globalradio!.id;
                            globalradio = radioList[currentplayingid - 2];

                            setState(() {});
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const radioplayingview()));
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
                              title: globalradio!.name,
                              url: globalradio!.radioURL,
                              imagePath: globalradio!.image);
                          await radioPlayer.play();
                          isplaying = 1;
                          currentplayingid = globalradio!.id;
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
                            globalradio = radioList[currentplayingid];
                            currentplayingid = globalradio!.id;
                            setState(() {});
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const radioplayingview()));
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
                      /* Navigator.of(context).pushNamedAndRemoveUntil(
                        '/radioscreen',
                        ((route) => false),
                      ); */
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
