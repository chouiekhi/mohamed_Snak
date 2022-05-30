import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AudioCache playerSonido = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();

  // ignore: unused_field

  // or as a local variable

  // call this method when desired

  List<int> snakePosition = [42, 62, 82, 102];
  //List<int> snakePosition = [45, 6, 82, 102];
  int numberOfSquares = 760;

  static var randomNumber = Random();
  int food = randomNumber.nextInt(700);
  int Enmigos = randomNumber.nextInt(500);
  int Enmigos2 = randomNumber.nextInt(800);
  int Enmigos3 = randomNumber.nextInt(200);
  int Enmigos4 = randomNumber.nextInt(400);

  // List<int> enmigo2 = randomNumber.nextInt(200, 400)

  var speed = 300;

  bool playing = false;
  bool music = false;

  var direction = 'down';

  bool x1 = false;
  bool x2 = false;
  bool x3 = false;
  bool playSonido = false;

  bool endGame = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (direction != 'up' && details.delta.dy > 0) {
                  direction = 'down';
                } else if (direction != 'down' && details.delta.dy < 0) {
                  direction = 'up';
                }
              },
              onHorizontalDragUpdate: (details) {
                if (direction != 'left' && details.delta.dx > 0) {
                  direction = 'right';
                } else if (direction != 'right' && details.delta.dx < 0) {
                  direction = 'left';
                }
              },
              child: Stack(
                children: [
                  /*  Center(
                    child: Image.asset('assets/images/snake.png',
                        fit: BoxFit.contain)),*/
                  GridView.builder(
                    itemCount: numberOfSquares,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 20,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (snakePosition.contains(index)) {
                        return Center(
                          child: Container(
                              padding: const EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(300.0),
                                child: Image.network(
                                    "https://c8.alamy.com/compes/h4f0xa/una-ilustracion-de-una-caricatura-snake-h4f0xa.jpg"),
                              ) /*ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                color: Colors.red,
                              ),
                            ),*/
                              ),
                        );
                      }

                      if (index == food) {
                        return Container(
                            padding: const EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(300.0),
                              child: Image.network(
                                  "https://i.pinimg.com/originals/82/b8/7c/82b87c721531d75baf6323a3b73c6f1f.jpg"),
                            )

                            /*ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: const Center(
                                child: Icon(
                              Icons.set_meal_rounded,
                              size: 15,
                              color: Colors.yellow,
                            )),
                          ),*/
                            );
                      } else if (snakePosition.length >= 8 &&
                          index == Enmigos) {
                        return Container(
                            padding: const EdgeInsets.all(0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(300.0),
                              child: Image.network(
                                  "http://24.media.tumblr.com/5b0a0aadff922245ed64fe974c71531c/tumblr_mkt79sZ45I1rb2pojo1_400.gif"),
                            ));
                      } else if (snakePosition.length >= 15 &&
                          index == Enmigos2) {
                        return Container(
                            padding: const EdgeInsets.all(0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(300.0),
                              child: Image.network(
                                  "https://c.tenor.com/30YKBVzUjBkAAAAd/eagle-freedom.gif"),
                            ));
                      } else if (snakePosition.length > 20 &&
                          index == Enmigos3) {
                        return Container(
                            padding: const EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(300.0),
                              child: Image.network(
                                  "https://c.tenor.com/an6OMlnxJRwAAAAM/hehehe.gif"),
                            ));
                      } else if (snakePosition.length > 25 &&
                          index == Enmigos4) {
                        return Container(
                            padding: const EdgeInsets.all(0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(300.0),
                              child: Image.network(
                                  "https://i.makeagif.com/media/11-27-2020/IRzePJ.gif"),
                            ));
                      } else {
                        return Container(
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          !playing
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: x1 ? Colors.green : Colors.transparent,
                      ),
                      margin: const EdgeInsets.all(10),
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              x1 = true;
                              x2 = false;
                              x3 = false;
                              speed = 300;
                            });
                          },
                          child: const Text(
                            'X1',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: x2 ? Colors.green : Colors.transparent,
                      ),
                      margin: const EdgeInsets.all(10),
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              x2 = true;
                              x1 = false;
                              x3 = false;
                              speed = 200;
                            });
                          },
                          child: const Text(
                            'X2',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: x3 ? Colors.green : Colors.transparent,
                      ),
                      margin: const EdgeInsets.all(10),
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              x3 = true;
                              x1 = false;
                              x2 = false;
                              speed = 100;
                            });
                          },
                          child: const Text(
                            'X3',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ),
                    Container(
                      height: 20,
                      width: 1,
                      color: Colors.white70,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          startGame();
                        },
                        child: Row(
                          children: const [
                            Text(
                              'Start',
                              style: TextStyle(color: Colors.yellow),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.play_arrow, color: Colors.yellow),
                          ],
                        ))
                  ],
                )
              : Container(
                  height: 50,
                  color: Colors.white12,
                  child: Center(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          endGame = true;
                        });
                      },
                      child: Text(
                        'End the Game and show result',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  // funciones
  // startGame()
  startGame() {
    setState(() {
      playing = true;

      playerSonido.loop("clash.mp3");
    });

    endGame = false;
    snakePosition = [42, 62, 82, 102];
    var duration = Duration(milliseconds: speed);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if (gameOver() || endGame) {
        timer.cancel();
        showGameOverDialog();
        playing = false;
        x1 = false;
        x2 = false;
        x3 = false;
      }
    });
  }

  gameOver() {
    for (int i = 0; i < snakePosition.length; i++) {
      int count = 0;
      for (int j = 0; j < snakePosition.length; j++) {
        if (snakePosition[i] == snakePosition[j]) {
          count += 1;
        }
        if (count == 2) {
          setState(() {
            playing = false;
          });

          playerSonido.play("fatality.mp3");

          return true;
        } else {}
      }
    }
    return false;
  }

  showGameOverDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          if (snakePosition.length == 30) {
            return AlertDialog(
              title: const Text('Congratulations!! has won.'),
              content: Text('your score is ' + snakePosition.length.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      startGame();
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Play Again')),
                RaisedButton(
                    disabledColor: Colors.red,
                    disabledTextColor: Colors.black,
                    onPressed: () {
                      SystemNavigator.pop();

                      exit(0);
                    },
                    child: const Text("close app"))
              ],
            );
          } else {
            return AlertDialog(
              title: const Text('Game over'),
              content: Text('your score is ' + snakePosition.length.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      startGame();
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Play Again')),
                RaisedButton(
                    disabledColor: Colors.red,
                    disabledTextColor: Colors.black,
                    onPressed: () {
                      SystemNavigator.pop();

                      exit(0);
                    },
                    child: const Text("close app"))
              ],
            );
          }
        });
  }

  generateNewFood() {
    food = randomNumber.nextInt(700);
    // Enmigos = randomNumber.nextInt(500);
  }

  updateSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          if (snakePosition.last > 740) {
            snakePosition.add(snakePosition.last + 20 - 760);
            //  playSonido = false;

            //playerSonido.play('comer.wav');
          } else {
            snakePosition.add(snakePosition.last + 20);
          }
          break;

        case 'up':
          if (snakePosition.last < 20) {
            snakePosition.add(snakePosition.last - 20 + 760);
          } else {
            snakePosition.add(snakePosition.last - 20);
          }
          break;

        case 'left':
          if (snakePosition.last % 20 == 0) {
            snakePosition.add(snakePosition.last - 1 + 20);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
          break;

        case 'right':
          if ((snakePosition.last + 1) % 20 == 0) {
            snakePosition.add(snakePosition.last + 1 - 20);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
          break;

        default:
      }
      if (snakePosition.last == food) {
        playerSonido.play('yes.mp3');
        generateNewFood();
      } else if (snakePosition.last == Enmigos ||
          snakePosition.last == Enmigos2 ||
          snakePosition.last == Enmigos3 ||
          snakePosition.last == Enmigos4) {
        // generaEnmigos1();

        setState(() {
          endGame = true;
          playerSonido.play("fatality.mp3");
        });
      } else if (snakePosition.length == 30) {
        setState(() {
          endGame = true;
          playerSonido.play("gain.mp3");
        });
      } else {
        snakePosition.removeAt(0);
      }
    });
  }
}
