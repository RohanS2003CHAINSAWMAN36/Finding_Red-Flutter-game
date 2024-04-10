import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:finding_red/finding_red.dart';

void mainmenu() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  FindingRed game = FindingRed();

  runApp(MyApp(game: game));
}

class MyApp extends StatelessWidget {
  final FindingRed game;

  MyApp({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finding Red',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 10, 1, 27)),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Finding Red - Made By Rohan S and Srisha S K',
        game: game,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.game});
  final String title;
  final FindingRed game;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Push the button to play the game',
            ),
            Text(
              'Finding Red',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20), // Add some space between text and button
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GameWidget(game: widget.game)),
                );
              },
              child: const Icon(Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }
}
