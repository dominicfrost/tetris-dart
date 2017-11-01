part of tetris;

// zero, one_eighty
//  __ __ __ __
// |LP         |
//  ‾‾ ‾‾ ‾‾ ‾‾
// ninty, two_seventy
//        __
//       |  |
//       |  |
//       |  |
//       |LP|
//        ‾‾
// LP - Location Point

class IPiece extends Piece {
  IPiece(midPoint) : super(midPoint);

  @override
  PieceType get type => PieceType.I;

  @override
  bool moveLeft(List<List<PieceType>> board) {
    switch (rotation) {
      case Rotation.zero:
      case Rotation.one_eighty:
        // Check if the board edge is directly to our left
        if (location.x == 0) return false;
        // Check if there is a piece that we'll intersect if we move left
        if (board[location.x - 1][location.y] != PieceType.none) return false;
        if (location.y >= 1 && board[location.x - 1][location.y - 1] != PieceType.none) return false;
        if (location.y >= 2 && board[location.x - 1][location.y - 2] != PieceType.none) return false;
        if (location.y >= 3 && board[location.x - 1][location.y - 3] != PieceType.none) return false;
        break;
      case Rotation.ninty:
      case Rotation.two_seventy:
        // Check if the board edge is directly to our left
        if (location.x == 0) return false;
        // Check if there is a piece that we'll intersect if we move left
        if (board[location.x - 1][location.y] != PieceType.none) return false;
        break;
    }
    // Now move left
    location.x--;
    return true;
  }

  @override
  bool moveRight(List<List<PieceType>> board) {
    switch (rotation) {
      case Rotation.zero:
      case Rotation.one_eighty:
        // Check if the board edge is directly to our right
        if (location.x == board.length - 1) return false;
        // Check if there is a piece that we'll intersect if we move right
        if (board[location.x + 1][location.y] != PieceType.none) return false;
        if (location.y >= 1 && board[location.x + 1][location.y - 1] != PieceType.none) return false;
        if (location.y >= 2 && board[location.x + 1][location.y - 2] != PieceType.none) return false;
        if (location.y >= 3 && board[location.x + 1][location.y - 3] != PieceType.none) return false;
        break;
      case Rotation.ninty:
      case Rotation.two_seventy:
        // Check if the board edge is directly to our right
        if (location.x == board.length - 5) return false;
        // Check if there is a piece that we'll intersect if we move right
        if (board[location.x - 5][location.y] != PieceType.none) return false;
        break;
    }

    // Now move right
    location.x++;
    return true;
  }

  @override
  bool moveDown(List<List<PieceType>> board) {
    switch (rotation) {
      case Rotation.zero:
      case Rotation.one_eighty:
        // Check if the board edge is directly beneath us
        if (location.y == board[location.x].length - 1) return false;
        // Check if there is a piece that we'll intersect if we move down
        if (board[location.x][location.y + 1] != PieceType.none) return false;
        break;
      case Rotation.ninty:
      case Rotation.two_seventy:
        // Check if the board edge is directly beneath us
        if (location.y == board[location.x].length - 1) return false;
        // Check if there is a piece that we'll intersect if we move down
        if (board[location.x][location.y + 1] != PieceType.none) return false;
        if (board[location.x + 1][location.y + 1] != PieceType.none) return false;
        if (board[location.x + 2][location.y + 1] != PieceType.none) return false;
        if (board[location.x + 3][location.y + 1] != PieceType.none) return false;
        break;
    }

    // Now move down
    location.y++;
    return true;
  }

  @override
  bool rotateClockwise(List<List<PieceType>> board) {
    rotation = Rotation.values[(rotation.index + Rotation.values.length + 1) % Rotation.values.length];

    // how must we modify our coodinates given our new rotation state?
    switch (rotation) {
      case Rotation.zero:
      case Rotation.one_eighty:
        location.x += 2;
        break;
      case Rotation.ninty:
      case Rotation.two_seventy:
        location.x -= 2;
        break;
      default:
        print('well, that should never happen..');
    }
    return true; // TODO: add validation to rotation logic...
  }

  @override
  bool rotateCounterClockwise(List<List<PieceType>> board) {
    rotation = Rotation.values[(rotation.index + Rotation.values.length - 1) % Rotation.values.length];

    // how must we modify our coodinates given out new rotation state?
    switch (rotation) {
      case Rotation.zero:
      case Rotation.one_eighty:
        location.x += 2;
        break;
      case Rotation.ninty:
      case Rotation.two_seventy:
        location.x -= 2;
        break;
      default:
        print('well, that should never happen..');
    }
    return true; // TODO: add validation to this rotation logic.
  }

  @override
  List<Point<int>> getDrawPoints() {
    var points = new List();
    switch (rotation) {
      case Rotation.zero:
      case Rotation.one_eighty:
        if (location.y >= 0) points.add(new Point(location.x, location.y));
        if (location.y >= 1) points.add(new Point(location.x, location.y - 1));
        if (location.y >= 2) points.add(new Point(location.x, location.y - 2));
        if (location.y >= 3) points.add(new Point(location.x, location.y - 3));
        break;
      case Rotation.ninty:
      case Rotation.two_seventy:
        if (location.y >= 0) points.add(new Point(location.x, location.y));
        if (location.y >= 0) points.add(new Point(location.x + 1, location.y));
        if (location.y >= 0) points.add(new Point(location.x + 2, location.y));
        if (location.y >= 0) points.add(new Point(location.x + 3, location.y));
        break;
    }
    return points;
  }
}
