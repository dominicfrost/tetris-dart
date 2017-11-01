part of tetris;

class EventHandler {
  Game tetrisGame;

  EventHandler(this.tetrisGame) {
    html.window.addEventListener('keydown', _handleKeyDown);
  }

  _handleKeyDown(html.KeyboardEvent e) {
    switch (e.keyCode) {
      case 37: // left
        tetrisGame.activePiece.moveLeft(tetrisGame.tetrisBoard.boardArray);
        break;
      case 38: // up
        tetrisGame.activePiece.moveToBottom(tetrisGame.tetrisBoard.boardArray);
        break;
      case 39: // right
        tetrisGame.activePiece.moveRight(tetrisGame.tetrisBoard.boardArray);
        break;
      case 40: // down
        tetrisGame.activePiece.moveDown(tetrisGame.tetrisBoard.boardArray);
        break;
      case 81: // q
        tetrisGame.activePiece.rotateCounterClockwise(tetrisGame.tetrisBoard.boardArray);
        break;
      case 87: // w
        tetrisGame.activePiece.rotateClockwise(tetrisGame.tetrisBoard.boardArray);
        break;
      default: // tha rest
      // do nothing, case we dont care
    }
  }
}
