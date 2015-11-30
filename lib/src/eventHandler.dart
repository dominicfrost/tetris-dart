part of tetris;

class EventHandler {
  Game tetrisGame;

  EventHandler(this.tetrisGame) {
    // TODO: stop using the window plox
    html.window.addEventListener('keydown', _handleKeyDown);
  }

  _handleKeyDown(html.KeyboardEvent e) {
    switch (e.keyCode) {
      case 37: // left
        tetrisGame.activePiece.moveLeft();
        break;
      case 38: // up
        tetrisGame.activePiece.toBottom();
        break;
      case 39: // right
        tetrisGame.activePiece.moveRight(tetrisGame.tetrisBoard.boardArray);
        break;
      case 40: // down
        tetrisGame.activePiece.moveDown(tetrisGame.tetrisBoard.boardArray);
        break;
      case 81: // q
        tetrisGame.activePiece.rotateCounterClockwise();
        break;
      case 87: // w
        tetrisGame.activePiece.rotateClockwise();
        break;
      default: // tha rest
      // do nothing, case we dont care
    }
  }
}
