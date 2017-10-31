import "dart:html" as html;
import "package:tetris/tetris.dart" as tetris;

main() {
  // set up the container element
  html.Element container = html.querySelector('.container');
  container.style.setProperty('height', '600px');
  container.style.setProperty('width', '100%');

  var tetrisGame = new tetris.Game(container, rows: 10, cols: 5, debug: true);
  tetrisGame.start();
}
