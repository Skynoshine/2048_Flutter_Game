import 'package:flutter/material.dart';
import 'package:game/controllers/game_controller.dart';
import 'package:game/module/module_service.dart';
import 'package:game/widgets/game_board.dart';
import 'package:game/widgets/components/game_controls.dart';
import 'package:game/widgets/components/game_header.dart';
import 'package:get_it/get_it.dart';

GetIt di = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ModuleService.of.initialize();
  runApp(Game2048App());
}

class Game2048App extends StatelessWidget {
  const Game2048App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048',
      theme: ThemeData(primarySwatch: Colors.orange, fontFamily: 'Arial'),
      home: GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameController _gameController = di<GameController>();

  @override
  void initState() {
    super.initState();
    _gameController.setFullScreen(true);
  }

  @override
  void dispose() {
    _gameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF8EF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              GameHeader(controller: _gameController),
              SizedBox(height: 20),
              Expanded(
                child: Center(child: GameBoard(controller: _gameController)),
              ),
              SizedBox(height: 20),
              GameControls(ct: _gameController),
            ],
          ),
        ),
      ),
    );
  }
}
