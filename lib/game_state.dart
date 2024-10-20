import 'package:flutter/material.dart';
import 'card_model.dart';
import 'dart:async'; // For using Future.delayed

class GameState with ChangeNotifier {
  final int gridSize = 4; // Change to 6 for a 6x6 grid
  late List<CardModel> _cards;
  List<CardModel> flippedCards = []; // Store currently flipped cards
  bool isFlipping = false; // Prevent multiple flips at the same time

  List<String> front_images = [
    'assets/subassets/five.png',
    'assets/subassets/joker.png',
    'assets/subassets/king.png',
    'assets/subassets/queen.png',
    'assets/subassets/three.png',
    // Add more images as required
  ];

  GameState() {
    _initializeCards();
  }

  List<CardModel> get cards => _cards;

  void _initializeCards() {
    _cards = List.generate(16, (index) {
      final frontImage =
          front_images[index % front_images.length]; // Rotate images
      return CardModel(
        frontImage: frontImage,
        backImage: 'assets/cards_back.jpg',
      );
    });

    _cards.shuffle(); // Shuffle the cards for randomness
  }

  void flipCard(int index) async {
    if (_cards[index].isMatched || isFlipping)
      return; // Ignore if matched or flipping

    _cards[index].isFaceUp = !_cards[index].isFaceUp;
    notifyListeners();

    if (_cards[index].isFaceUp) {
      flippedCards.add(_cards[index]);

      if (flippedCards.length == 2) {
        isFlipping = true; // Block further flips until match check completes
        await Future.delayed(Duration(seconds: 1)); // Delay for showing cards

        if (flippedCards[0].frontImage == flippedCards[1].frontImage) {
          flippedCards[0].isMatched = true;
          flippedCards[1].isMatched = true;
        } else {
          flippedCards[0].isFaceUp = false;
          flippedCards[1].isFaceUp = false;
        }

        flippedCards.clear();
        isFlipping = false;
        notifyListeners();
      }
    }
  }
}
