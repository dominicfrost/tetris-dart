part of tetris;

abstract class Piece {
  PieceType get type;

  /// [rotation] decribes the orientation of the peice
  Rotation rotation = Rotation.zero;

  /// The x, y position of the piece.
  /// the x value is column that the piece starts in.
  /// the y values is the row the the piece ends in.
  Point<int> location;

  Piece(int midPoint) {
    print('created piece: ${this.runtimeType}');
    location = new Point<int>(midPoint, -1);
  }

  // all the function below return true if they successfully made an update to the board.
  bool moveLeft(List<List<PieceType>> board);
  bool moveRight(List<List<PieceType>> board);
  bool moveDown(List<List<PieceType>> board);
  bool rotateClockwise(List<List<PieceType>> board);
  bool rotateCounterClockwise(List<List<PieceType>> board);
  void moveToBottom(List<List<PieceType>> board) {
    // move down, forever.
    while (moveDown(board));
  }

  /// [getDrawPoints] returns instructions about how to draw this peice at its current location.
  List<Point<int>> getDrawPoints();
}
