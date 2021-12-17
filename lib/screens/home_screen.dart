import 'package:flutter/material.dart';

import '../widgets/xo_board.dart';
import '../utils/cell_value.dart';
import '../controllers/game_controller.dart';
import '../controllers/board_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final BoardController boardController;
  late final GameController gameController;

  @override
  void initState() {
    super.initState();
    boardController = BoardController();
    gameController = GameController(boardController);
  }

  @override
  void dispose() {
    boardController.dispose();
    gameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Click a cell when it\'s your move.'),
            AnimatedBuilder(
              animation: gameController,
              builder: (context, _) {
                if (gameController.hasWinner) {
                  return Text(
                    'Winner is ${mapCellValueToString(gameController.winner)}',
                  );
                } else {
                  return Text(
                    'Player ${gameController.isPlayerXTurn ? 'X' : 'O'}\'s turn.',
                  );
                }
              },
            ),
            XOBoard(
              controller: boardController,
              onCellTap: gameController.onCellTap,
            ),
            ElevatedButton(
              child: const Text('Restart Game'),
              onPressed: () {
                gameController.restartGame(randomPlayer: false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
