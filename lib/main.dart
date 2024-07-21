import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TicTacToePage(),
    );
  }
}

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({Key? key}) : super(key: key);

  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  late List<List<String>> board;
  late bool isPlayer1Turn;
  late bool gameOver;
  late List<int> winningIndices;
  late bool showWinningAnimation;

  @override
  void initState() {
    super.initState();
    resetBoard();
  }

  void resetBoard() {
    board = List.generate(3, (_) => List.filled(3, ''));
    isPlayer1Turn = true;
    gameOver = false;
    winningIndices = [];
    showWinningAnimation = false;
  }

  void makeMove(int row, int col) {
    if (board[row][col].isEmpty && !gameOver) {
      setState(() {
        if (isPlayer1Turn) {
          board[row][col] = '@';
        } else {
          board[row][col] = '#';
        }
        isPlayer1Turn = !isPlayer1Turn;
        checkWinner();
      });
    }
  }

  void checkWinner() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] &&
          board[i][1] == board[i][2] &&
          board[i][0].isNotEmpty) {
        gameOver = true;
        winningIndices = [i * 3, i * 3 + 1, i * 3 + 2];
        break;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[0][i] == board[1][i] &&
          board[1][i] == board[2][i] &&
          board[0][i].isNotEmpty) {
        gameOver = true;
        winningIndices = [i, i + 3, i + 6];
        break;
      }
    }

    // Check diagonals
    if ((board[0][0] == board[1][1] &&
            board[1][1] == board[2][2] &&
            board[0][0].isNotEmpty) ||
        (board[0][2] == board[1][1] &&
            board[1][1] == board[2][0] &&
            board[0][2].isNotEmpty)) {
      gameOver = true;
      if (board[1][1].isNotEmpty) {
        winningIndices = [0, 4, 8];
      } else {
        winningIndices = [2, 4, 6];
      }
    }

    if (gameOver) {
      showWinningAnimation = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                final row = index ~/ 3;
                final col = index % 3;
                final isWinningCell = winningIndices.contains(index);

                return GestureDetector(
                  onTap: () {
                    makeMove(row, col);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      color: isWinningCell && showWinningAnimation
                          ? Colors.lightGreenAccent
                          : Colors.lightBlueAccent,
                    ),
                    child: Center(
                      child: Text(
                        board[row][col],
                        style: TextStyle(
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold,
                          color: isWinningCell ? Colors.black87 : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                resetBoard();
              });
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
