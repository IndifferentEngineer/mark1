Here's an updated README for your Tic Tac Toe project, including the GitHub link:

---

# Tic Tac Toe Flutter App

This project is a simple Tic Tac Toe game built using Flutter. The app allows two players to take turns marking spaces in a 3×3 grid, with the objective of placing three respective marks in a horizontal, vertical, or diagonal row to win the game.

## Features

- **Two-Player Mode:** Players alternate turns to mark the grid.
- **Reset Functionality:** Reset the game board at any time to start a new game.
- **Winning Animation:** Highlights the winning line when a player wins.

## Project Structure

- **main.dart:** The main file that initializes the app and contains the core game logic and UI components.

## How to Run

1. **Setup Flutter:**
   - Ensure you have Flutter installed. You can download and set it up from the official Flutter website: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install).

2. **Clone the Repository:**
   ```bash
   git clone https://github.com/IndifferentEngineer/mark1
   cd mark1
   ```

3. **Run the App:**
   - Use the following command to run the app on an emulator or a connected device:
     ```bash
     flutter run
     ```

## Code Explanation

### Main Entry Point

```dart
void main() {
  runApp(const TicTacToeApp());
}
```
- The `main` function is the entry point of the application, calling `runApp` to start the Tic Tac Toe app.

### TicTacToeApp Class

```dart
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
```
- `TicTacToeApp` sets up the main application theme and routes to the `TicTacToePage`.

### TicTacToePage Class

```dart
class TicTacToePage extends StatefulWidget {
  const TicTacToePage({Key? key}) : super(key: key);

  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}
```
- `TicTacToePage` is a stateful widget that represents the main game interface.

### _TicTacToePageState Class

```dart
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
        board[row][col] = isPlayer1Turn ? '@' : '#';
        isPlayer1Turn = !isPlayer1Turn;
        checkWinner();
      });
    }
  }

  void checkWinner() {
    // Check for winners and set game state accordingly
    // ...
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
```
- The `_TicTacToePageState` class handles the state of the game, including the game board, player turns, game over status, and winning animation.
- The `resetBoard` method initializes or resets the game board.
- The `makeMove` method handles player moves and toggles the turn.
- The `checkWinner` method checks the board for a winner and updates the game state if a winning combination is found.
- The `build` method constructs the game UI, including the grid and reset button.

## Conclusion

This Tic Tac Toe app demonstrates the use of Flutter for building a simple interactive game with basic game mechanics and state management. Feel free to customize and enhance the app further based on your needs.

---

You can include this README file in your project repository to provide clear instructions and an overview for users.
