import 'package:beats/screens/app.dart';
import 'package:beats/screens/home_screen.dart';
import 'package:beats/screens/radio_screen.dart';
import 'package:beats/screens/yourlibrary_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'services/dialog_box.dart';

void main() {
  runApp(MaterialApp(
      title: 'Beats',
      debugShowCheckedModeBanner: false,
      //   home: MyApp(),
      home: const Loginbase(),
      routes: {
        '/playingview': (context) => const radioplayingview(),
        '/myapp': (context) => const MyApp(),
        '/radioscreen': (context) => const RadioScreen(),
        '/musicplayingview': ((context) => const MusicPlayingView()),
        '/playlistview': (context) => const playlistScreen(),
        '/loginbase': (context) => const Loginbase(),
        //'/searchmusicplayingview': ((context) => const SearchMusicPlayingView())
      }));
}

class Loginbase extends StatefulWidget {
  const Loginbase({super.key});

  @override
  State<Loginbase> createState() => _LoginbaseState();
}

class _LoginbaseState extends State<Loginbase> {
  // intializing firebase...
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
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
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const Loginscreen();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        await showErrorDialog(
          context,
          'User not found',
        );
      } else if (e.code == "wrong-password") {
        await showErrorDialog(
          context,
          'Wrong password',
        );
      } else {
        await showErrorDialog(
          context,
          'Authentication error',
        );
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: const Image(
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://pbs.twimg.com/profile_images/840950881025708032/1k6km0os_400x400.jpg'),
                ),
              ),
            ),
          ),
          const Center(
            child: Text(
              "Beats",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Login to your App",
            style: TextStyle(
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _emailController,
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: "User Email",
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(
                  Icons.mail,
                  color: Colors.white,
                )),
          ),
          const SizedBox(
            height: 22,
          ),
          TextField(
            controller: _passwordController,
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            decoration: const InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                )),
          ),
          const SizedBox(
            height: 36,
          ),
          Container(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor: Colors.blueGrey.shade200,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: () async {
                User? user = await loginUsingEmailPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                    context: context);
                if (user != null) {
                  print(user);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const MyApp()));
                }
              },
              child: const Text(
                "Login",
                style: TextStyle(
                    color: Color.fromARGB(255, 40, 45, 47),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            child: const Text(
              "Click here to Sign up",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            onTap: (() {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const Registerscreen()));
            }),
          )
        ],
      ),
    );
  }
}

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  static Future<User?> registerUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        await showErrorDialog(
          context,
          'User not found',
        );
      } else if (e.code == "user-already-exist") {
        await showErrorDialog(
          context,
          'User already exist',
        );
      } else {
        await showErrorDialog(
          context,
          'Authentication error',
        );
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
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
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: const Image(
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://pbs.twimg.com/profile_images/840950881025708032/1k6km0os_400x400.jpg'),
                        ),
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Beats",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Register Yourself",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: "User Email",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  TextField(
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Container(
                    width: double.infinity,
                    child: RawMaterialButton(
                      fillColor: Colors.blueGrey.shade200,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onPressed: () async {
                        User? user = await registerUsingEmailPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                            context: context);
                        if (user != null) {
                          print(user);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Loginbase()));
                        }
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: Color.fromARGB(255, 40, 45, 47),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    child: const Text(
                      "Click Here to Sign In",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: (() {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Loginbase()));
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
