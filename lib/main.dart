import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';
import 'card_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameState(),
      child: CardGridApp(),
    ),
  );
}

class CardGridApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Card Grid',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CardGridScreen(),
    );
  }
}

class CardGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);

    return Scaffold(
      backgroundColor: Color(0xFFFF81CE),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Center(child: Text('Card Grid Game',style: TextStyle(color: Colors.white),)),
      ),
      body: GridView.builder(
        padding: EdgeInsets.only(top: 130),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gameState.gridSize, // Dynamic grid size
          childAspectRatio: 1,
        ),
        itemCount: gameState.cards.length,
        itemBuilder: (context, index) {
          final card = gameState.cards[index];
          return GestureDetector(
            onTap: () => gameState.flipCard(index),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return RotationTransition(
                  turns: Tween(begin: 1.0, end: 0.0).animate(animation),
                  child: child,
                );
              },
              child: card.isFaceUp
                  ? Image.asset(
                card.frontImage,
                key: ValueKey('front_$index'),
              ) // Front image
                  : Image.asset(
                card.backImage,
                key: ValueKey('back_$index'),
              ), // Back image
            ),
          );
        },
      ),
    );
  }
}
