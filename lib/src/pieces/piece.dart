part of tetris;

abstract class Piece {
  Rotation rotation = Rotation.zero;

  // The x, y position of the piece.
  // the x value is column that the piece starts in.
  // the y values is the row the the piece ends in.
  Point<int> location;

  Piece(int midPoint) {
    location = new Point<int>(midPoint, -1);
  }

  // all the function below return true if they successfully made an update to the board.
  bool moveLeft(Board board);
  bool moveRight(Board board);
  bool moveDown(Board board);
  bool rotateClockwise(Board board);
  bool rotateCounterClockwise(Board board);
  bool moveToBottom(Board board);
}
