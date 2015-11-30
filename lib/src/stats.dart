part of tetris;

class Stats {
  html.DivElement parent;

  int _rows;

  Stats(this.parent, this._rows) {
    _drawTetrisStats();
  }

  _drawTetrisStats() {
    html.DivElement tetrisScore = new html.DivElement();

    tetrisScore.setAttribute('class', 'tetris-score');

    tetrisScore.style.setProperty('height', '${this._rows * blockWidth}px');
    tetrisScore.style.setProperty('width', '100px');
    tetrisScore.style.setProperty('box-sizing', 'border-box');
    tetrisScore.style.setProperty('float', 'left');

    this.parent.append(tetrisScore);
  }
}
