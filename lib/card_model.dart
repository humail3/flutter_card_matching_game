class CardModel {
  final String frontImage;
  final String backImage;
  bool isFaceUp;
  bool isMatched; // Add isMatched for match logic

  CardModel({
    required this.frontImage,
    required this.backImage,
    this.isFaceUp = false,
    this.isMatched = false, // Initialize as false
  });
}
