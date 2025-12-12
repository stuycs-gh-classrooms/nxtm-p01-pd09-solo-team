Cell dish;
int sz = 10;
float d = 0.3;
boolean playing = false; // seperate before game starts and after
boolean PINKMODE;

void setup() {
  size(500, 500);
  dish = new Cell(width/sz, height/sz, sz, d);
  PINKMODE = false;
}

void draw() {
  background(255);
  if (playing == true) {
    dish.nextGen();
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
  if (key == 'b') {
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
  if (key == 'r') {
    dish.dens(d);
    playing = false;
  } // reset/randomize grid
  if (key == ' ') {
    if (playing == true) {
      playing = false;
    } else if (playing == false) {
      playing = true;
    }
  } // pause grid
  if (key == '1') {
    dish.nextGen();
  }
  if (key == 'p') {
    if (PINKMODE == false) {
      PINKMODE = true;
    }
    else if (PINKMODE == true) {
      PINKMODE = false;
    }
  }
} // user can start game
