import 'dart:async';
import 'package:finding_red/components/jump_button.dart';
import 'package:finding_red/components/level.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:finding_red/components/player.dart';
import 'package:flutter/painting.dart';

class FindingRed extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        HasCollisionDetection,
        TapCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late CameraComponent cam;
  Player player = Player(character: 'Mask Dude');
  late JoystickComponent joystick;
  bool showControls = true;
  List<String> levelNames = ['level-01', 'level-02', 'level-03', 'level-04'];
  int currentLevelIndex = 0;
  double score = 0; // Define score variable

  late TextComponent scoreText;

  FutureOr<void> onLoad() async {
    // Load all images into cache
    await images.loadAllImages();
    if (showControls) {
      addJoyStick();
      add(JumpButton());
    }
    _loadLevel();
    scoreText = TextComponent(
      text: 'Score: ${score.toStringAsFixed(0)}',
    )
      ..anchor = Anchor.topRight
      ..x = size.x - 16
      ..y = 16;
    add(scoreText);
    return super.onLoad();
  }

  // Update the score text whenever score changes
  void updateScore(double points) {
    score += points;
    scoreText.text = 'Score: ${score.toStringAsFixed(0)}';
    // You can update the UI or perform any other action related to the score here
  }

  @override
  void update(double dt) {
    if (showControls) {
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoyStick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );

    add(joystick);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }

  void loadNextLevel() {
    if (currentLevelIndex < levelNames.length - 1) {
      currentLevelIndex++;
      _loadLevel();
    } else {}
  }

  void _loadLevel() {
    priority = 5;
    Future.delayed(const Duration(seconds: 1), () {
      Level world = Level(
        player: player,
        levelName: levelNames[currentLevelIndex],
      );

      cam = CameraComponent.withFixedResolution(
          world: world, width: 550, height: 360);
      cam.viewfinder.position = Vector2(330, 190);
      addAll([cam, world]);
    });
  }
}
