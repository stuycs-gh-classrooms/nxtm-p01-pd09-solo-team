Cell dish;
int sz = 10;
float d = 0.3;
boolean playing = false; // seperate before game starts and after

void setup() {
  size(500, 500);
  dish = new Cell(width/sz, height/sz, sz, d);
}

void draw() {
  background(255);
  if (playing == true) {
    dish.update();
  }
  dish.display();
}

void mousePressed() {
  if (playing == false) {
    // since each cell is sz wide/tall, we can just divide the x/y coords of mouse to get row/col
    int c = mouseX/sz;
    int r = mouseY/sz;
    if (c >= 0 && c < dish.cols && r >= 0 && r < dish.rows && dish.grid[c][r] == 0) {
      dish.grid[c][r] = 1;
    } else if (c >= 0 && c < dish.cols && r >= 0 && r < dish.rows && dish.grid[c][r] == 1) {
      dish.grid[c][r] = 0;
    }
  }
} // user can click a cell to life

void keyPressed() {
  if (key == 's') {
    playing = true;
  } // start the game
  if (key == 'r') {
    for (int r = 0; r < dish.cols; r++) {
      for (int c = 0; c < dish.rows; c++) {
        if (c >= 0 && c < dish.cols && r >= 0 && r < dish.rows) {
          if (dish.grid[c][r] != 0) {
            dish.grid[c][r] = 0;
          }
        }
      }
    }
  } // reset whole thing
  if (key == ' ') {
    dish.dens(d);
    playing = false;
  } // reset/randomize grid
} // user can start game
