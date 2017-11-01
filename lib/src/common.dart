part of tetris;

enum Rotation { zero, ninty, one_eighty, two_seventy }
enum PieceType { none, I, J, L, O, S, T, Z }

String getColorForPiece(PieceType piece) {
  switch (piece) {
    case PieceType.none:
      return 'white';
    case PieceType.I:
      return 'maroon';
    case PieceType.J:
      return 'silver';
    case PieceType.L:
      return 'purple';
    case PieceType.O:
      return 'blue';
    case PieceType.S:
      return 'green';
    case PieceType.T:
      return 'brown';
    case PieceType.Z:
      return 'teal';
  }
  return 'black';
}

class Point<T> {
  T x;
  T y;

  Point(this.x, this.y);
}

/*
 * canvas-astar.dart
 * MIT licensed
 *
 * Created by Daniel Imms, http://www.growingwiththeweb.com
 */
class Array2d<T> {
  List<List<T>> array;
  T defaultValue;

  Array2d(int width, int height, {T this.defaultValue}) {
    array = new List<List<T>>();
    this.width = width;
    this.height = height;
  }

  operator [](int x) => array[x];

  set width(int v) {
    while (array.length > v) array.removeLast();
    while (array.length < v) {
      List<T> newList = new List<T>();
      if (array.length > 0) {
        for (int y = 0; y < array.first.length; y++) newList.add(defaultValue);
      }
      array.add(newList);
    }
  }

  set height(int v) {
    while (array.first.length > v) {
      for (int x = 0; x < array.length; x++) array[x].removeLast();
    }
    while (array.first.length < v) {
      for (int x = 0; x < array.length; x++) array[x].add(defaultValue);
    }
  }
}
