include <variables.scad>;
use <checker.scad>;
use <tile.scad>;

COLOR1 = "black";
COLOR2 = "white";
Z = TILE_HEIGHT - TILE_CIRCLE_DEPTH;

for (y=[0:7])
  for (x=[0:7])
    translate([TILE_SIZE * x, TILE_SIZE * y, 0])
      color(y % 2 == 0 ? (x % 2 == 0 ? COLOR2 : COLOR1) : (x % 2 != 0 ? COLOR2 : COLOR1)) tile();

for (y=[0:2])
  for (x=[0:2:7])
    color("red") translate([TILE_SIZE * x + TILE_SIZE * (y%2), TILE_SIZE * y, Z + BODY_HEIGHT]) mirror([0,0,1]) checker();

for (y=[5:7])
  for (x=[0:2:7])
    color("green") translate([TILE_SIZE * x + TILE_SIZE * (y%2), TILE_SIZE * y, Z + BODY_HEIGHT]) mirror([0,0,1]) checker();
